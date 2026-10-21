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
		dumpSavedGameBases: function (self) {
			print("SavedGame " + self);

			// Bases in SavedGame
			let bases = self.getBases();
			let bl = ""
			for (let k = 0; k < bases.size(); k++) {
				let b = bases.get(k);
				bl = bl + " " + b.getName();
			}
			print("Bases:" + bl);
			// Test API "bases"
			if (bases.size() > 0) {
				let b = bases.get(0);
				print("Name:", b.getName());

				// Test "people"
				print("Workshops/Engineers:", 	b.getUsedWorkshops(), b.getAvailableWorkshops(), b.getFreeWorkshops(),
					b.getEngineers(), b.getTotalEngineers() , b.getAvailableEngineers());
				print("Laboratories/Scientists:", 	b.getUsedLaboratories(), b.getAvailableLaboratories(), b.getFreeLaboratories(),
					b.getScientists(), b.getTotalScientists(), b.getAvailableScientists());
				print("Soldiers:", b.getTotalSoldiers() , b.getTotalSoldiers());
				print("Quarters: ", b.getUsedQuarters(), b.getAvailableQuarters());

				// Test "hangars"
				print("Hangars: ", b.getUsedHangars(), b.getAvailableHangars());

				// Test "stores"
				print("Stores:", b.getUsedStores(), b.getAvailableStores(),
					b.storesOverfull(), b.storesOverfullCritical());


				// Test "facilities"
				let facilities = b.getFacilities();
				let fl = "";
				for (let k = 0; k < facilities.size(); k++) {
					let f = facilities.get(k);
					let r = f.getRules();
					fl = fl + "  (" + f.getX() + "," + f.getY() + ":" + r.getSizeX() + "x" + r.getSizeY() + ") " + r.getType();
				}
				print("Facilities" + fl);

				// Test "psi-lab"
				print("Psi-Lab:", 	b.getUsedPsiLabs(), b.getAvailablePsiLabs(), b.getFreePsiLabs());

				// Test "training"
				print("Training:", 	b.getUsedTraining(), b.getAvailableTraining(), b.getFreeTrainingSpace());

				// Test "containment" (Alien containment: prisonType=0)
				print("Alien Containment:", b.getUsedContainment(0), b.getAvailableContainment(0), b.getFreeContainment(0));

				// Test "soldiers" details (more in JSTWSoldier<N>)
				let soldiers = b.getSoldiers();
				let sl = "";
				for (let k = 0; k < soldiers.size(); k++) {
					let s = soldiers.get(k);
					let r = s.getRules();
					sl = sl + " " + s.getName() + " (" + r.getType() + ")";
				}
				print("Soldiers" + sl);


				// Test "stores/items" details
				// See JSTWItem1, JSTUStore1

				// Test "research" details
				let projects = b.getResearch();
				let pl = "";
				for (let k = 0; k < projects.size(); k++) {
					let p = projects.get(k);
					let r = p.getRules();
					if (r.needItem()) {
						pl = pl + " " + r.getName() + " (" + p.getSpent() + "/" + p.getCost() + "," + r.getCost() + ") " +
							p.getAssigned() + " {" + r.getNeededItem().getName() + "}";
					} else {
						pl = pl + " " + r.getName() + " (" + p.getSpent() + "/" + p.getCost() + "," + r.getCost() + ") " +
							p.getAssigned();
					}
				}
				print("Research (ongoing)" + pl);


				// Test "production" details
				let prod = b.getProductions();
				pl = "";
				for (let k = 0; k < prod.size(); k++) {
					let p = prod.get(k);
					let r = p.getRules();
					if (p.getInfiniteAmount()) {
						pl = pl + " " + r.getName() + " (" + p.getAmountProduced() + "/INF " + p.getSellItems() + ") " + p.getAssignedEngineers();
					} else {
						pl = pl + " " + r.getName() + " (" + p.getAmountProduced() + "/" + p.getAmountTotal() + " " + p.getSellItems() + ") " + p.getAssignedEngineers();
					}
				}
				print("Production" + pl);

			}
		},

		onLoad: function (step, self, filename) {
			print("(tw) SavedGame.onLoad", step, self, filename);
			saved_game.dumpSavedGameBases(self);
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
