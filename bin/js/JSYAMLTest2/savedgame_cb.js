/*
 * Copyright 2026 D.Jorand.
 *
 * This file is part of OpenXcom.
 *
 * OpenXcom is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OpenXcom is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenXcom.	If not, see <http://www.gnu.org/licenses/>.
 */

(function () {
	// Define the callback function(s)
	let saved_game = {
		// Test of the capability to put and restore additional
		// data in the game save files.
		modName: "JSYAMLTest2",
		warned: false,	// there is an error that was reported, don't
						// report again and don't try to run anymore

		dumpNode: function (node, level) {
			if (node.isMap()) {
				if(node.key().length > 0)
					print(level + node.key() + ": {");
				else
					print(level + "{");
				for (let k = 0; k < node.childrenCount(); k++) {
					saved_game.dumpNode(node.getChild(k), level+"  ");
				}
				print(level + "},");
			} else if (node.isSeq()) {
				if(node.key().length > 0)
					print(level + node.key() + ": [");
				else
					print(level + "[");
				for (let k = 0; k < node.childrenCount(); k++) {
					saved_game.dumpNode(node.getChild(k), level+"  ");
				}
				print(level + "],");
			} else if (node.hasVal()) {
				print(level + node.key() + ": " + node.val());
			} else {
				print("??????????????????");
			}
		},


		// Reload data (yaml object "JSYAMLTest2" with scalar value)
		// from the saved file and dump it on the screen.
		onLoadOwnData: function (step, self, filename, reader) {
			print("(yaml) SavedGame.onLoadOwnData", step, self, filename, reader);

			if (saved_game.warned) return;

			let mydata = reader.getChild("JSYAMLTest2");
			saved_game.dumpNode(mydata, "");

			return 0;
		},

		// Add some data (yaml object "JSYAMLTest2" with scalar value)
		// in the saved file.
		onSaveOwnData: function (step, self, filename, writer) {
			print("(yaml) SavedGame.onSaveOwnData", step, self, filename, writer);

			if (saved_game.warned) return;

			let mydata = writer.mapAdd("JSYAMLTest2");
			mydata.setAsMap();
			mydata.write("strvalue", "StringTest");

			return 0;
		},

	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onLoadOwnData", 0, saved_game.onLoadOwnData);
	jsSavedGame.registerCallback("onSaveOwnData", 0, saved_game.onSaveOwnData);
})();
