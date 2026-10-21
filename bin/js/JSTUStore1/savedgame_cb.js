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
		dumpStore: function (self, base) {
			print("dumpStore <" + base.getName() + ">:")
			let ic = base.getStorageItems();
			let iv = ic.getItems();
			for (let k = 0; k < iv.size(); k++) {
				let ir = iv.get(k);
				print("  - " + ir.getName() + " " + ic.getItem(ir));
			}
		},

		dumpCrafts: function (self, base) {
			print("dumpCraft <" + base.getName() + ">:")
			let crafts = base.getCrafts();
			for (let k = 0; k < crafts.size(); k++) {
				let craft = crafts.get(k);
				print("+ " + craft + " " + craft.getNumWeapons() + " weapons, " + craft.getNumEquipment() + " equip");
				let ic = craft.getItems();
				let iv = ic.getItems();
				for (let k = 0; k < iv.size(); k++) {
					let ir = iv.get(k);
					print("  - " + ir.getName() + " " + ic.getItem(ir));
				}
				let weapons = craft.getWeapons();
				for (let k = 0; k < weapons.size(); k++) {
					let w = weapons.get(k);
					print("  - " + w);
				}

			}
		},

		onLoad: function (step, self, filename) {
			print("(tu) SavedGame.onLoad - store & craft items", step, self, filename);
			let bases = self.getBases();
			for (let k = 0; k < bases.size(); k++) {
				saved_game.dumpStore(self, bases.get(k));
				saved_game.dumpCrafts(self, bases.get(k));
			}
			return 0;
		},

		details: false,
	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onLoad", 1, saved_game.onLoad);
})();
