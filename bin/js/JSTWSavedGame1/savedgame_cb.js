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
		dumpSavedGame: function (self) {
			print("Globals: " + openxcom.game + " " + openxcom.mod);
			print("SavedGame: " + self);
			// Test API "difficulty"
			print("Difficulty: " + self.getDifficulty() + " " +
				self.getDifficultyCoefficient() + " " +
				self.getSellPriceCoefficient() + " " +
				self.getBuyPriceCoefficient());

			// Test API "globe"
			print("Globe and time: " + self.getGlobeLongitude() + " " +
				self.getGlobeLatitude() + " " +
				self.getGlobeZoom() + " " +
				self.getTime());

			// Test API "ids"
			print("IDs: " + self.getAllIds() + " " +
				self.getId("USA") + " " + self.getId("RUSSIA"));

			// Test API "countries"
			let countries = self.getCountries();
			print("Countries: " + countries + " " +
				self.getCountryFunding());
			if (saved_game.details) {
				for (let k = 0; k < countries.size(); k++) {
					let c = countries.get(k);
					let f = c.getFunding();
					let fl = "";
					for (let i = 0; i < f.size(); i++) {
						fl = f.get(i)/1000 + " " + fl;
					}
					print("\tfunding (in k): " + fl + " (" + c.getSatisfaction() + ")");
					print("\tpact: " + c.getPact() + " " + c.getNewPact() + " " + c.getCancelPact());
					// Test: cancel 1st pact and setFunding
					if (false && c.getPact()) {
						c.setCancelPact();
						c.setFunding(80000);
						break;
					}
					let ax = c.getActivityXcom();
					let axl = "";
					for (let i = 0; i < ax.size(); i++) {
						axl= ax.get(i) + " " + axl;
					}
					print("\tXCom activity: " + axl);
					let aa = c.getActivityAlien();
					let aal = "";
					for (let i = 0; i < aa.size(); i++) {
						aal= aa.get(i) + " " + aal;
					}
					print("\Alien activity: " + aal);
				}
			}

			// Test API "regions"
			let regions = self.getRegions();
			print("Regions: " + regions);
			if (saved_game.details) {
				for (let k = 0; k < regions.size(); k++) {
					let r = regions.get(k);
					let ax = r.getActivityXcom();
					let axl = "";
					for (let i = 0; i < ax.size(); i++) {
						axl= ax.get(i) + " " + axl;
					}
					print("\tXCom activity: " + axl);
					let aa = r.getActivityAlien();
					let aal = "";
					for (let i = 0; i < aa.size(); i++) {
						aal= aa.get(i) + " " + aal;
					}
					print("\tAlien activity: " + aal);
				}
			}

			// Test API "bases"
			let bases = self.getBases();
			print("Bases: " + bases);
			if (true || saved_game.details) {
				let bl = ""
				for (let k = 0; k < bases.size(); k++) {
					let b = bases.get(k);
					bl = bl + " " + b.getName();
				}
				print("\tnames:" + bl);
			}

			// Test API "manufacture"
			print("Manufacture:");
			let can_produce_items = new openxcom.std.RuleManufacturePVector();
			self.getAvailableProductions(can_produce_items, openxcom.mod, bases.get(0))
			let il = ""
			for (let k = 0; k < can_produce_items.size(); k++) {
				let i = can_produce_items.get(k);
				il = il + " " + i.getName();
			}
			print("\tCan produce:" + il);

			// Test API "research" XXX
			print("Completed research:");
			let completed = self.getDiscoveredResearch();
			let crl = "";
			for (let k = 0; k < completed.size(); k++) {
				crl = crl + " " + completed.get(k).getName();
			}
			print("\t" + crl);

		},

		onLoad: function (step, self, filename) {
			print("(tw) SavedGame.onLoad", step, self, filename);
			saved_game.dumpSavedGame(self);
			return 0;
		},
		onSave: function (step, self, filename) {
			print("(tw) SavedGame.onSave", step, self, filename);
			return 0;
		},

		details: false,
	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onLoad", 1, saved_game.onLoad);
	jsSavedGame.registerCallback("onSave", 0, saved_game.onSave);
})();
