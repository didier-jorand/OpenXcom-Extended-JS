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
		modName: "JSYAMLTest1",
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

		onLoad: function (step, self, filename) {
			print("(yaml) SavedGame.onLoad", step, self, filename);

			if (saved_game.warned) return;

			let d = OpenXcom.Options.getUserFolder()
			print("UserFolder: " + d + ", MasterUserFolder: " + OpenXcom.Options.getMasterUserFolder());
			let str = std.loadFile(d + "options.cfg");
			if (!str) {
				print("Failed to load options.cfg: file not found or not readable\nMod '" + saved_game.modName + "' deactivated");
				saved_game.warned = true;
				return;
			}

			// Case 1: read from the file
			let root = new OpenXcom.YAML.YamlRootNodeReader(d + "options.cfg", false, false);
			//print(root, root.isValid(), root.isMap());
			//if(root.isMap()) {
			//	print("Map: " + root.childrenCount() + " children");
			//	for (let k = 0; k < root.childrenCount(); k++) {
			//		print("\t" + root.getChild(k));
			//	}
			//}
			//print(""+root.emit());

			saved_game.dumpNode(root, "");

			return 0;
		},

		onSave: function (step, self, filename) {
			print("(yaml) SavedGame.onSave", step, self, filename);

			let root = new OpenXcom.YAML.YamlRootNodeWriter();
			root.setAsMap();
			// test: set map item as basic types
			root.write("string_prop1", "String1Test");
			root.write("string_prop2", "String2Test");
			root.write("int_prop", 999);
			root.write("bool_prop1", true);
			root.write("bool_prop2", false);

			// test: set map item as sequence
			let subseq = root.mapAdd("subseq1");
			subseq.setAsSeq();
			subseq.write(1);
			subseq.write(10);
			subseq.write(100);
			let submap = root.mapAdd("submap1");
			submap.setAsMap();
			submap.write("sub_string_prop", "SubStringTest");

			// test: add a map as a sequence item
			subseq = root.mapAdd("subseq2");
			subseq.setAsSeq();
			let s = subseq.seqAdd()
			s.setAsMap();
			s.setFlowStyle();
			s.write("1.A", "a");
			s.write("1.B", "b");
			subseq.write("2.C");

			let result = root.emit();
			print(result.yaml);
		},

	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onLoad", 1, saved_game.onLoad);
	jsSavedGame.registerCallback("onSave", 1, saved_game.onSave);
})();
