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
		dumpItem: function (self) {
			//let ir = openxcom.mod.getItem("STR_AVALANCHE_MISSILES");
			let ir = openxcom.mod.getItem("STR_HEALING_SPRAY");
			print("" + ir);
			print("BuyCost: " + ir.getBuyCost() + ", SellCost: " + ir.getSellCost());
			let reqs = ir.getRequirements();
			let rl = "";
			for (let k = 0; k < reqs.size(); k++) {
				rl = rl + " " + reqs.get(k);
			}
			print("Requirements <" + reqs.size() + ">: " + rl);
			reqs = ir.getBuyRequirements();
			rl = "";
			for (let k = 0; k < reqs.size(); k++) {
				rl = rl + " " + reqs.get(k);
			}
			print("Buy Requirements <" + reqs.size() + ">: " + rl);
			print("Buy Country Requirements: " + ir.getRequiresBuyCountry());

		},

		onLoad: function (step, self, filename) {
			print("(tw) SavedGame.onLoad - item", step, self, filename);
			saved_game.dumpItem(self);
			return 0;
		},

		details: false,
	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onLoad", 1, saved_game.onLoad);
})();
