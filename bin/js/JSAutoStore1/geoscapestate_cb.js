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
	let geo = {
		modName: "JSAutoStore1",
		warned: false,	// there is an error that was reported, don't
						// report again and don't try to run anymore
		str: "",
		debug: false,
		engineers_percent: 1, //0.20, // use up to 20% of engineers

		base_store_perform_refill(saved_game, base, ir, target, prod) {
			if (geo.debug)
				print("base_store_perform_refill:", base.getName(), ir.getName(), target);

			if (ir.getBuyCost() > 0) {
				if (base.requestPurchase(ir, target)) {
					geo.str += base.getName() + ": " + ir.getName() + ": request purchase of " + target + "\n";
				} else {
					geo.str += base.getName() + ": " + ir.getName() + ": failed to purchase " + target + ": not enough money or space\n";
				}
			} else {
				// If we have a current production, increase the amount
				// (don't check the cost vs budget)
				if (prod) {
					prod.setAmountTotal(prod.getAmountTotal() + target);
					geo.str += base.getName() + ": " + ir.getName() + ": increase production by " + target + "\n";
				} else {
					// If not, create/queue a new production
					let eng = Math.min(
								base.getAvailableEngineers(),
								Math.floor(base.getTotalEngineers()*geo.engineers_percent)
							);
					if (base.requestProduction(ir, target, eng)) {
						geo.str += base.getName() + ": " + ir.getName() + ": request production of " + target + " by " + eng + " engineers\n";
					} else {
						geo.str += base.getName() + ": " + ir.getName() + ": failed to manufacture " + target + ": not allowed (yet) or not enough workspace or engineers\n";
					}
				}
			}
		},

		base_store_refill: function (saved_game, base, config) {
			if (geo.debug)
				print("base_store_refill:", base.getName() /*, config*/);
			//let items = openxcom.mod.getItemsList();
			//for (k = 0; k < items.size(); k++) { print(k, items.get(k)); }
			for (item in config) {
				//print("  - ", item, config[item]);
				let conf = config[item]
				let ir = openxcom.mod.getItem(item);
				if (!ir) {
					// not found, maybe mispelled or not in the loaded mods
					geo.str += base.getName() + ": " + item + ": unknown item type (ignored)\n";
					continue;
				}

				// check condition item
				let ok = true;
				let ok_research = true;
				let ok_as_craft_weapon = false;
				let ok_as_craft_item = false;
				let ok_as_stored_item = false;
				let not_ok_msg = "";

				if (conf.hasOwnProperty("onlyifnot")) {
					let not_req_ir = openxcom.mod.getItem(conf["onlyifnot"]);
					if (not_req_ir) {
						// Block if we can purchase this item or we can manufacture it
						ok = !((not_req_ir.getBuyCost() > 0) || (base.isProductionAllowed(not_req_ir)));
						if (!ok) {
							not_ok_msg = base.getName() + ": " + ir.getName() + " blocked by item " + not_req_ir.getName() + "\n";
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifnot' item type " + conf["onlyifnot"] + " (ignored)\n";
					}
				}

				if (ok && conf.hasOwnProperty("onlyifresearched")) {
					let topic = conf["onlyifresearched"];
					let completed = saved_game.getDiscoveredResearch();
					ok = false;
					for (let k = 0; k < completed.size(); k++) {
						if (completed.get(k).getName() == topic) {
							ok = true;
							break;
						}
					}
					if (!ok) {
						not_ok_msg = base.getName() + ": " + ir.getName() + " blocked by research " + topic + "\n";
					}
				}

				if (ok && conf.hasOwnProperty("onlyifweapon")) {
					ok = false; // default ok don't apply anymore
					// do we have a craft which has this item as weapon ?
					let req_ir = openxcom.mod.getItem(conf["onlyifweapon"]);
					if (req_ir) {
						let crafts = base.getCrafts();
						for (let k = 0; (!ok_as_craft_weapon) && (k < crafts.size()); k++) {
							let craft = crafts.get(k);
							let weapons = craft.getWeapons();
							for (let l = 0; l < weapons.size(); l++) {
								let w = weapons.get(l);
								if (w.getRules().getLauncherItem().equals(req_ir)) {
									ok_as_craft_weapon = true;
									break;
								}
							}
						}
						if (!ok_as_craft_weapon) {
							not_ok_msg = base.getName() + ": " + ir.getName() + " misses " + req_ir.getName() + " as craft weapon\n";
						}

					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifweapon' " + conf["onlyifweapon"] + " (ignored)\n";
					}
				}
				if (ok && !ok_as_craft_weapon && conf.hasOwnProperty("onlyifcraft")) {
					ok = false; // default ok don't apply anymore
					// do we have a craft which has this item in storage bay ?
					let req_ir = openxcom.mod.getItem(conf["onlyifcraft"]);
					if (req_ir) {
						let crafts = base.getCrafts();
						for (let k = 0; (!ok_as_craft_item) && (k < crafts.size()); k++) {
							let craft = crafts.get(k);
							let ic = craft.getItems();
							if (ic.getItem(req_ir)) {
								ok_as_craft_item = true;
								break;
							}
						}
						if (!ok_as_craft_item) {
							not_ok_msg = base.getName() + ": " + ir.getName() + " misses " + req_ir.getName() + " in craft\n";
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifcraft' " + conf["onlyifcraft"] + " (ignored)\n";
					}
				}

				if (ok && !ok_as_craft_weapon && !ok_as_craft_item && conf.hasOwnProperty("onlyifstore")) {
					ok = false; // default ok don't apply anymore
					// do we have a craft which has this item in storage bay ?
					let req_ir = openxcom.mod.getItem(conf["onlyifstore"]);
					if (req_ir) {
						let ic = base.getStorageItems();
						if (ic.getItem(req_ir)) {
							ok_as_stored_item = true;
						}
						if (!ok_as_stored_item) {
							not_ok_msg = base.getName() + ": " + ir.getName() + " misses " + req_ir.getName() + " in store\n";
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifstore' " + conf["onlyifstore"] + " (ignored)\n";
					}
				}

				if (!(ok || ok_as_craft_weapon || ok_as_craft_item || ok_as_stored_item)) {
					//print("Dependency not fulfilled for " + item);
					geo.str += not_ok_msg;
					continue; // process next item in configuration
				}

				// How many units do we have in the base store or in transfer
				// or in production (or, optionally, in craft(s))
				// Note: even if we can produce the items, we check the
				// transfer in case we are getting them from another base
				// Note: we only count the item currently in crafts as
				// an option, since the objective is to (re)fill the storage
				let ic = base.getStorageItems();
				let n = ic.getItem(ir);

				let trfs = base.getTransfers();
				let q = 0;
				for (let k = 0; k < trfs.size(); k++) {
					let t = trfs.get(k);
					//print("" + k + " " + t);
					if ((t.getType() == OpenXcom.TRANSFER_ITEM) && (ir.equals(t.getItems()))) {
						q += t.getQuantity();
					}
				}

				let m = 0;
				let current_prod;
				if (ir.getBuyCost() === 0) {
					let prds = base.getProductions();
					for (let k = 0; k < prds.size(); k++) {
						let p = prds.get(k);
						//print("" + k + " " + p);
						// get the RuleManufacture
						let rm = p.getRules()
						if (rm.isItemProduced(ir)) {
							// number of items remaining to produce
							// (that is, not already counted in store above)
							m += p.getAmountTotal() - p.getAmountProduced();
							current_prod = p;
							break;
						}
					}
				}
				if (geo.debug)
					print("\tItem " + item + " in store: " + n + ", in transfer: " + q + ", in production: " + m);

				let total = n + q + m;

				// Option: also count "in craft" items
				if (conf.hasOwnProperty("options")) {
					if (conf.options.indexOf("in-craft") >= 0) {
						let o = 0;
						let crafts = base.getCrafts();
						for (let k = 0; k < crafts.size(); k++) {
							let craft = crafts.get(k);
							let ic = craft.getItems();
							o += ic.getItem(ir);
						}
						if (geo.debug)
							print("In craft, " + item + ": " + o);
						total += o;
					}
				}

				// Are we in the expected limit
				if (total >= conf.min) {
					if (geo.debug)
						std.printf("\t\tNo need to refill: %d vs [%d,%d]\n", total, conf.min, conf.max);
				} else if (total < conf.max) {
					if (geo.debug)
						print("\t\tNeed to refill: ", total, "/", conf.min, "/", conf.max, " => +", conf.max - total);
					geo.base_store_perform_refill(saved_game, base, ir, conf.max - total, current_prod);
				}
			}

		},

		/// store_refill checks the quantities of (some) items in every database
		/// store and order or manufacture the items that are below the threshold
		/// in order to reach the expected number.
		///
		///
		store_refill: function (geoscape, saved_game) {
			// Load the file describing the requirements: StoreRefill.json
			// from the user directory
			let d = OpenXcom.Options.getUserFolder()
			let str = std.loadFile(d + "StoreRefill.json");
			if (!str) {
				geoscape.errorMessage("Failed to load StoreRefill.json: file not found or not readable\nMod '" + geo.modName + "' deactivated");
				print("Failed to load StoreRefill.json");
				geo.warned = true;
				return;
			}
			let config = std.parseExtJSON(str);
			if (typeof config != "object") {
				geoscape.errorMessage("Failed to load StoreRefill.json: invalid file content\nMod '" + geo.modName + "' deactivated");
				print("JSON parse failed for StoreRefill.json", typeof(config));
				print(str);
				geo.warned = true;
				return;
			}

			if (config.hasOwnProperty("bases")) {
				let base_config = config["bases"];
				let bases = saved_game.getBases();
				for (let k = 0; k < bases.size(); k++) {
					let c;
					if (base_config.hasOwnProperty((toString(k+1)))) {
						c = config[k+1];
					} else if (base_config.hasOwnProperty("default")) {
						c = base_config["default"];
					}
					if(c) {
						geo.base_store_refill(saved_game, bases.get(k), c);
					}
				}
				if (geo.str.length > 0) {
					print("-------------------------------------");
					print(geo.str);
					print("-------------------------------------");
					geo.str = "";
				}
			}
		},

		onTime1Day: function (step, self, saved_game) {
			//print("GeoscapeState.onTime1Day 'refill store'" + self + " " + saved_game + " (" + step + ")");
			if (!geo.warned) {
				geo.store_refill(self, saved_game);

				if (geo.warned) {
					// Unregister the callback, since the module is deactivated
					jsGeoscapeState.unregisterCallback("onTime1Hour", 0, geo.onTime1Hour);
				}
			}
			return 0;
		},
	};

	// Register the callback(s)
	jsGeoscapeState.registerCallback("onTime1Hour", 0, geo.onTime1Day);
})();
