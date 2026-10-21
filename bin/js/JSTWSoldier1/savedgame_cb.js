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
		dumpSoldier: function (base, soldier) {
			let s = "\t-  " + soldier.getName();
			if (soldier.getCraft()) {
				s += " " + soldier.getCraft().getType();
			}

			if (soldier.getArmor()) {
				s += " " + soldier.getArmor().getType();
			}

			let stats = soldier.getCurrentStats();
			print("" + stats);
			keys = ['tu', 'stamina', 'health', 'bravery', 'reactions', 'firing', 'throwing', 'strength', 'psiStrength', 'psiSkill', 'melee', 'mana'];
			keys.forEach( (k) => {s += " " + k + ": " + stats[k]} );

			let layout = soldier.getEquipmentLayout();
			for (let k = 0; k < layout.size(); k++) {
				let slot = layout.get(k).getSlot();
				s += " [[" + layout.get(k) + " " + slot + "]]" ;
			}
			layout = soldier.getPersonalEquipmentLayout();
			for (let k = 0; k < layout.size(); k++) {
				let slot = layout.get(k).getSlot();
				s += " [[" + layout.get(k) + " " + slot + "]]" ;
			}
			print(s);


		},

		dumpSoldiers: function (self) {
			let bases = self.getBases();
			for (let k = 0; k < bases.size(); k++) {
				let base = bases.get(k);
				if (base.getTotalSoldiers() > 0) {
					print(base.getName() + ":");
					let soldiers = base.getSoldiers();
					for (let l = 0; l < soldiers.size(); l++) {
						saved_game.dumpSoldier(base.getName(), soldiers.get(l));
					}
				}
			}
		},

		onLoad: function (step, self, filename) {
			print("(tw) SavedGame.onLoad - soldier", step, self, filename);
			saved_game.dumpSoldiers(self);
			return 0;
		},

		details: false,
	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onLoad", 1, saved_game.onLoad);
})();
