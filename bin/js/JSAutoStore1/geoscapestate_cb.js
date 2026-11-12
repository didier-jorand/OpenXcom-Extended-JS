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
		// to move in each "configuration" ?
		engineers_percent: 0.5, //0.20, // = use up to 20% of engineers
		config: null,
		reload: false,

		//////////////////////////////////////////
		//// base_store_perform_refill
		//////////////////////////////////////////
		base_store_perform_refill: function (geoscape, saved_game, base, ir, target, prod) {
			if (geo.debug)
				print("base_store_perform_refill:", base.getName(), ir.getName(), target);

			let t = saved_game.getTime();
			let note_prefix = std.sprintf("%d-%d-%d %s - %s: ",
						t.getYear() % 100, t.getMonth(), t.getDay(),
						base.getName(),
						geoscape.tr(ir.getName()));

			if (ir.getBuyCost() > 0) {
				if (base.requestPurchase(ir, target)) {
					geo.str += base.getName() + ": " + ir.getName() + ": request purchase of " + target + "\n";
					saved_game.getUserNotes().add(note_prefix + "request purchase of " + target);
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
					// Check available engineers & workspace
					let avail = base.getAvailableEngineers();
					let requested = Math.floor(base.getTotalEngineers()*geo.engineers_percent);

					if (requested > avail) {
						//print(base.getName() + " " + ir.getName() + ": Fallback calculation: available: " + avail + ", requested: " + requested + " missing: " + (requested-avail));
						// less engineers available that expected, try to free some
						// if we are manufacturing the fallback production (sold for profit) ?
						// Note: XXX check also "production.isFallback' as it can be configured from the game
						if (geo.config.hasOwnProperty("fallback_production")) {
							let fl = geo.config["fallback_production"];
							let fallback_prod;
							for (let k = 0; (!fallback_prod) && (k < fl.length); k++) {
								//print("Fallback production " + fl[k].item);
								let fallback = fl[k];
								let fallback_item = openxcom.mod.getItem(fallback["item"]);
								if (!fallback_item) {
									// not found, maybe mispelled or not in the loaded mods
									//print("Fallback <" + fallback["item"] + ">: unknown item type");
									geo.str += base.getName() + ": fallback " + fallback["item"] + ": unknown item type (ignored)\n";
									continue; // try the next fallback
								}
								let prds = base.getProductions();
								for (let l = 0; l < prds.size(); l++) {
									let p = prds.get(l);
									// get the RuleManufacture
									let rm = p.getRules();
									// this is the fallback line if the production is infinite and sold
									if (rm.isItemProduced(fallback_item) && p.getSellItems() && p.getInfiniteAmount()) {
										//print("Fallback: infinite sold production found");
										fallback_prod = p;
										break;
									}
								}
							}
							if (fallback_prod) {
								let allocated = fallback_prod.getAssignedEngineers();
								//print("    Fallback: allocated before => " + allocated);
								if (allocated > 1) {
									// we can reallocate all but one of the engineers working on the fallback
									// but we only need requested minus available
									let reallocated = Math.min(allocated-1, requested - avail);
									//print("    Fallback: will reallocate => " + reallocated + " (new allocation: " + (allocated-reallocated) + ")");
									fallback_prod.setAssignedEngineers(allocated - reallocated);
									// Put the number of "freed" engineers in the pool of available engineers
									base.setEngineers(base.getEngineers() + reallocated);
									//print("    New number of available engineers: " + base.getAvailableEngineers());
								}
							}
						}
					}

					// Get the (now) available engineers and start the production
					let eng = Math.min(
								base.getAvailableEngineers(),
								requested
							);
					if (eng > 0 && base.requestProduction(ir, target, eng)) {
						geo.str += base.getName() + ": " + ir.getName() + ": request production of " + target + " by " + eng + " engineers\n";
						saved_game.getUserNotes().add(note_prefix + "request production of " + target + " by " + eng + " engineers");
					} else {
						geo.str += base.getName() + ": " + ir.getName() + ": failed to manufacture " + target + ": not allowed (yet) or not enough workspace or engineers\n";
					}
				}
			}
		},

		//////////////////////////////////////////
		//// base_content_count
		//////////////////////////////////////////
		base_content_count: function (saved_game, base, item) {
			let counters = { store: 0, weapon: 0, weapon_ammo: 0, craft: 0, soldier: 0,
				transfer: 0, production: 0, total: 0, current_production: null };
			let q;

			// Count the items present in craft, either used as weapon, as
			// weapon ammo or in storage bay
			let crafts = base.getCrafts();
			for (let k = 0; k < crafts.size(); k++) {
				let craft = crafts.get(k);

				// count the weapons and the weapons ammo (clips)
				let weapons = craft.getWeapons();
				for (let l = 0; l < weapons.size(); l++) {
					let w = weapons.get(l);
					if (w && w.getRules().getLauncherItem().equals(item)) {
						counters.weapon++;
						counters.total++;
					}
					// check w: is 'null' if no weapon in slot
					// check w.getRules.getClipItem(): is 'null' for laser cannon or plasma beam
					if (w && w.getRules().getClipItem() && w.getRules().getClipItem().equals(item)) {
						//print(item.getName() + " -> " + w.getRules().getClipItem() +  " <" + w.getAmmo() + "> Loaded: " + w.getClipsLoaded());
						q = w.getClipsLoaded();
						counters.weapon_ammo += q;
						counters.total += q;
					}
				}
				// count the items in storage bay
				q = craft.getItems().getItem(item);
				counters.craft += q;
				counters.total += q;
			}
			// Count the items in store
			let ic = base.getStorageItems();
			q = ic.getItem(item);
			counters.store += q;
			counters.total += q;
			// Count the item (armor only in fact) owned by soldier
			// (note: don't count the soldier's equipment, it is
			// integrated in the craft storage or in the store)
			let soldiers = base.getSoldiers();
			for (let k = 0; k < soldiers.size(); k++) {
				let a = soldiers.get(k).getArmor();
				// for armor None, there is no store-item
				if (a.getStoreItem() && item.equals(a.getStoreItem())) {
					counters.soldier++;
					counters.total++;
				}
			}

			// Count the items currently in transfer
			// Note: count all transfer, either purchase or from another
			// base
			let trfs = base.getTransfers();
			for (let k = 0; k < trfs.size(); k++) {
				let t = trfs.get(k);
				if ((t.getType() == OpenXcom.TRANSFER_ITEM) && (item.equals(t.getItems()))) {
					q = t.getQuantity();
					counters.transfer += q;
					counters.total += q;
				}
			}

			// Count the items currently in production
			if (item.getBuyCost() === 0) {
				let prds = base.getProductions();
				// Note: perform the loop on all production because
				// some items (grav module, alien electronics)
				// can be obtained in different ways
				for (let k = 0; k < prds.size(); k++) {
					let p = prds.get(k);
					// get the RuleManufacture
					let rm = p.getRules()
					if (rm.isItemProduced(item)) {
						// number of items remaining to produce
						// (that is, not already counted in store above)
						q = p.getAmountTotal() - p.getAmountProduced();
						counters.production += q;
						counters.total += q;
						counters.current_production = p;
					}
				}
			}
			return counters;
		},


		//////////////////////////////////////////
		//// base_store_refill
		//////////////////////////////////////////
		base_store_refill: function (geoscape, saved_game, base, base_conf) {
			if (geo.debug)
				print("base_store_refill:", base.getName() /*, base_conf*/);
			//let items = openxcom.mod.getItemsList();
			//for (k = 0; k < items.size(); k++) { print(k, items.get(k)); }
			for (item in base_conf) {
				//print("  - ", item, base_conf[item]);
				let conf = base_conf[item]
				let ir;

				if (conf.warned) continue; // this item is invalid

				if (!conf.hasOwnProperty("ruleitem")) {
					ir = openxcom.mod.getItem(item);
					if (!ir) {
						// not found, maybe mispelled or not in the loaded mods
						geo.str += base.getName() + ": " + item + ": unknown item type (ignored)\n";
						conf.warned = true;
						continue;
					}
					conf["ruleitem"] = ir;
				} else {
					ir = conf["ruleitem"];
				}

				// check condition item
				let ok = true;
				let ok_as_craft_weapon = false;
				let ok_as_craft_item = false;
				let ok_as_stored_item = false;
				let not_ok_msg;

				if (conf.hasOwnProperty("onlyifnot")) {
					// a more recent item can block the need to supply an "older" item,
					// this is defined by "onlyifnot: _item_id_" (supply this item
					// only if this other item is not available)
					// Example: replace standard ammo by alloy ammo
					let not_req_ir = openxcom.mod.getItem(conf["onlyifnot"]);
					if (not_req_ir) {
						// Block if we can purchase this item or we can manufacture it
						ok = !((not_req_ir.getBuyCost() > 0) || (base.isProductionAllowed(not_req_ir)));
						if (!ok) {
							if (!conf.onlyifnot_reported) {
								not_ok_msg = base.getName() + ": " + ir.getName() + " blocked by item " + not_req_ir.getName() + "\n";
								conf.onlyifnot_reported = true;
							}
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifnot' item type " + conf["onlyifnot"] + " (ignored)\n";
						conf.warned = true;
						continue;
					}
				}

				if (ok && conf.hasOwnProperty("onlyifresearched")) {
					// for many items, they can only be manufactured if
					// they have been discovered ; this is defined by
					// "onlyifresearched: _research_id_"
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
						if (!conf.onlyifresearched_reported) {
							not_ok_msg = base.getName() + ": " + ir.getName() + " blocked by research " + topic + "\n";
							conf.onlyifresearched_reported = true;
						}
					}
				}

				if (ok && conf.hasOwnProperty("onlyifweapon")) {
					ok = false; // default ok don't apply anymore
					// for craft weapon ammo, it is needed to
					// supply them only if the weapon is actually used on
					// a craft ; this is defined by "onlyifweapon: _weapon_id_"
					let req_ir = openxcom.mod.getItem(conf["onlyifweapon"]);
					if (req_ir) {
						let crafts = base.getCrafts();
						for (let k = 0; (!ok_as_craft_weapon) && (k < crafts.size()); k++) {
							let craft = crafts.get(k);
							let weapons = craft.getWeapons();
							for (let l = 0; l < weapons.size(); l++) {
								let w = weapons.get(l);
								if (w && w.getRules().getLauncherItem().equals(req_ir)) {
									ok_as_craft_weapon = true;
									break;
								}
							}
						}
						if (!ok_as_craft_weapon) {
							if (!conf.onlyifweapon_reported) {
								not_ok_msg = base.getName() + ": " + ir.getName() + " misses " + req_ir.getName() + " as craft weapon\n";
								conf.onlyifweapon_reported = true;
							}
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifweapon' " + conf["onlyifweapon"] + " (ignored)\n";
						conf.warned = true;
						continue;
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
							if (!conf.onlyifcraft_reported) {
								not_ok_msg = base.getName() + ": " + ir.getName() + " misses " + req_ir.getName() + " in craft\n";
								conf.onlyifcraft_reported = true;
							}
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifcraft' " + conf["onlyifcraft"] + " (ignored)\n";
						conf.warned = true;
						continue;
					}
				}

				if (ok && !ok_as_craft_weapon && !ok_as_craft_item && conf.hasOwnProperty("onlyifstore")) {
					ok = false; // default ok don't apply anymore
					// do we have the requested item in the base storage ?
					let req_ir = openxcom.mod.getItem(conf["onlyifstore"]);
					if (req_ir) {
						let ic = base.getStorageItems();
						if (ic.getItem(req_ir) > 0) {
							ok_as_stored_item = true;
						}
						if (!ok_as_stored_item) {
							if (!conf.onlyifstore_reported) {
								not_ok_msg = base.getName() + ": " + ir.getName() + " misses " + req_ir.getName() + " in store\n";
								conf.onlyifstore_reported = true;
							}
						}
					} else {
						geo.str += base.getName() + ": " + item + ": unknown 'onlyifstore' " + conf["onlyifstore"] + " (ignored)\n";
						conf.warned = true;
						continue;
					}
				}

				if (!(ok || ok_as_craft_weapon || ok_as_craft_item || ok_as_stored_item)) {
					if (not_ok_msg) geo.str += not_ok_msg;
					continue; // process the next item in configuration
				}

				// Get the number of items in the store, in production, in transfer, in craft, attached to soldier...
				let counters = geo.base_content_count(saved_game, base, ir);

				if (geo.debug)
					print("\tItem " + ir, counters);

				let min=1, max=1;
				if ("min" in conf) min = conf.min;
				if ("max" in conf) max = conf.max;

				let relitem, rmin, rmax;
				if ("relto" in conf && "rmax" in conf) {
					let relitem = openxcom.mod.getItem(conf.relto);
					if (!relitem) {
						// related item not found, maybe mispelled or not in the loaded mods
						geo.str += base.getName() + ": " + item + ": unknown related item type '" + conf.relto + "' (ignored)\n";
						conf.warned = true;
						continue;
					}
					if ("rmin" in conf) {
						rmin = conf.rmin;
					} else {
						rmin = 1;
					}
					rmax = conf.rmax;

					let rcounters = geo.base_content_count(saved_game, base, relitem);

					min = Math.ceil(rmin * rcounters.total);
					max = Math.round(rmax * rcounters.total);

					if (geo.debug)
						print("\tRelated Item " + relitem.getName() + " (" + rmin + ", " + rmax + ")", rcounters, " ---> " + min + "," + max);
				}

				if (min < 1) min = 1;
				if (max < min) max = min;

				// Are we in the expected limit
				if (counters.total >= min) {
					if (geo.debug)
						std.printf("\t\tNo need to refill: %d vs [%d,%d]\n", counters.total, min, max);
				} else {
					if (geo.debug)
						print("\t\tNeed to refill: ", counters.total, "/", min, "/", max, " => +", max - counters.total);
					geo.base_store_perform_refill(geoscape, saved_game, base, ir, max - counters.total, counters.current_production);
				}
			}

			// at the end of the process, if we have engineers and workspace remaining available, we switch
			// them to the fallback production (if any)
			let avail_engineers = base.getAvailableEngineers();
			let avail_workspace = base.getAvailableWorkshops() - base.getUsedWorkshops();
			let avail = Math.min(avail_engineers, avail_workspace);

			if (avail > 0) {
				//print(base.getName() + ": Fallback - " + avail + " available engineers/workspace (" +
				//	avail_engineers + "," + avail_workspace + ")");
				if (geo.config.hasOwnProperty("fallback_production")) {
					let fl = geo.config["fallback_production"];
					let fallback_prod;
					for (let k = 0; (!fallback_prod) && (k < fl.length); k++) {
						//print("Fallback production " + fl[k].item);
						let fallback = fl[k];
						let fallback_item = openxcom.mod.getItem(fallback["item"]);
						if (!fallback_item) {
							// not found, maybe mispelled or not in the loaded mods
							//print("Fallback <" + fallback["item"] + ">: unknown item type");
							geo.str += base.getName() + ": fallback " + fallback["item"] + ": unknown item type (ignored)\n";
							continue; // try the next fallback
						}
						let prds = base.getProductions();
						for (let l = 0; l < prds.size(); l++) {
							let p = prds.get(l);
							// get the RuleManufacture
							let rm = p.getRules();
							// this is the fallback line if the production is infinite and sold
							if (rm.isItemProduced(fallback_item) && p.getSellItems() && p.getInfiniteAmount()) {
								//print("Fallback: infinite sold production found");
								fallback_prod = p;
								break;
							}
						}
					}
					if (fallback_prod) {
						// check available workspace XXX
						let allocated = fallback_prod.getAssignedEngineers();
						//print("    Fallback: allocated before => " + allocated);
						//print("    Fallback: will increase => " + avail + " (new allocation: " + (allocated + avail) + ")");
						fallback_prod.setAssignedEngineers(allocated + avail);
						// Remove the "allocated" engineers from the pool of available engineers
						base.setEngineers(base.getEngineers() - avail);
						//print("    New number of available engineers: " + base.getAvailableEngineers());
					}
				}
			}

		},

		//////////////////////////////////////////
		//// store_refill
		//////////////////////////////////////////
		/// store_refill checks the quantities of (some) items in every database
		/// store and order or manufacture the items that are below the threshold
		/// in order to reach the expected number.
		///
		store_refill: function (geoscape, saved_game) {
			// Load the file describing the requirements: StoreRefill.json
			// from the user directory
			if (!geo.config || geo.reload) {
				let d = OpenXcom.Options.getUserFolder()
				let str = std.loadFile(d + "StoreRefill.json");
				if (!str) {
					geoscape.errorMessage("Failed to load StoreRefill.json: file not found or not readable\nMod '" + geo.modName + "' deactivated");
					geo.warned = true;
					return;
				}
				let config = std.parseExtJSON(str);
				if (typeof config != "object") {
					geoscape.errorMessage("Failed to load StoreRefill.json: invalid file content\nMod '" + geo.modName + "' deactivated");
					geo.warned = true;
					return;
				}
				geo.config = config; // to keep the global parameters of the configuration available in all sub-functions
			}

			if (geo.config && geo.config.hasOwnProperty("bases")) {
				let base_config = geo.config["bases"];
				let bases = saved_game.getBases();
				for (let k = 0; k < bases.size(); k++) {
					let base = bases.get(k);
					let c;
					if (base_config.hasOwnProperty((toString(k+1)))) {
						c = base_config[k+1];
					} else if (base_config.hasOwnProperty(base.getName())) {
						c = base_config[base.getName()];
					} else if (base_config.hasOwnProperty("default")) {
						c = base_config["default"];
					}
					if(c) {
						geo.base_store_refill(geoscape, saved_game, base, c);
					}
				}
				if (true && geo.str.length > 0) {
					print("-------------------------------------");
					std.puts(geo.str);
					print("-------------------------------------");
					geo.str = "";
				}
			}
		},

		onTime1Hour: function (step, self, saved_game) {
			//print("GeoscapeState~onTime1Hour 'refill store'" + self + " " + saved_game + " (" + step + ")");
			if (!geo.warned) {
				var tt = saved_game.getTime();
				// runs only every N hours
				if ((tt.getHour() % 4) == 0)
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
	jsGeoscapeState.registerCallback("onTime1Hour", 0, geo.onTime1Hour);
})();
