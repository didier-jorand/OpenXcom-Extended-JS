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

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%echo "Processing Base.i"

%template(BaseFacilityPVector) std::vector<OpenXcom::BaseFacility*>;
%template(ResearchProjectPVector) std::vector<OpenXcom::ResearchProject*>;
%template(ProductionPVector) std::vector<OpenXcom::Production*>;
%template(SoldierPVector) std::vector<OpenXcom::Soldier*>;
%template(CraftPVector) std::vector<OpenXcom::Craft*>;
%template(TransferPVector) std::vector<OpenXcom::Transfer*>;
#endif

namespace OpenXcom
{

class BaseFacility;

enum BasePlacementErrors : int
{
	/// 0: ok
	BPE_None = 0,
	/// 1: not connected to lift or on top of another facility (standard OXC behavior)
	BPE_NotConnected = 1,
	/// 2: trying to upgrade over existing facility, but it's in use
	BPE_Used = 2,
	/// 3: trying to upgrade over existing facility, but it's already being upgraded
	BPE_Upgrading = 3,
	/// 4: trying to upgrade over existing facility, but size/placement mismatch
	BPE_UpgradeSizeMismatch = 4,
	/// 5: trying to upgrade over existing facility, but ruleset of new facility requires a specific existing facility
	BPE_UpgradeRequireSpecific = 5,
	/// 6: trying to upgrade over existing facility, but ruleset disallows it
	BPE_UpgradeDisallowed = 6,
	/// 7: trying to upgrade over existing facility, but all buildings next to it are under construction and build queue is off
	BPE_Queue = 7,
	/// 8: trying to build a facility, which is forbidden by other existing facilities in the base
	BPE_ForbiddenByOther = 8,
	/// 9: trying to build a facility, which would forbid (i.e. would be in conflict with) other existing facilities in the base
	BPE_ForbiddenByThis = 9,
	/// 10: not enough storage space
	BPE_Used_Stores = 10,
	/// 11: not enough living quarters
	BPE_Used_Quarters = 11,
	/// 12: not enough laboratories
	BPE_Used_Laboratories = 12,
	/// 13: not enough workshops
	BPE_Used_Workshops = 13,
	/// 14: not enough hangars
	BPE_Used_Hangars = 14,
	/// 15: not enough psi labs
	BPE_Used_PsiLabs = 15,
	/// 16: not enough gyms
	BPE_Used_Gyms = 16,
	/// 17: not enough alien containment
	BPE_Used_AlienContainment = 17,
	/// 18: trying to build a facility (from scratch) that can only be built as an upgrade of another facility
	BPE_UpgradeOnly = 18,
};


class Base
{
public:

	/// Gets the base's type.
	std::string getType() const override;
	/// Gets the base's name.
	std::string getName(Language *lang = 0) const override;

#if 0
	/// Gets the base's marker sprite.
	int getMarker() const override;
#endif

	/// Gets the base's facilities.
	std::vector<BaseFacility*> *getFacilities();

	/// Gets the base's soldiers.
	std::vector<Soldier*> *getSoldiers();

	/// Gets the base's crafts.
	std::vector<Craft*> *getCrafts() {	return &_crafts; }
	// Gets the base's crafts.
	//const std::vector<Craft*> *getCrafts() const { return &_crafts; }

	/// Gets the base's transfers.
	std::vector<Transfer*> *getTransfers() { return &_transfers; }
	// Gets the base's transfers.
	//const std::vector<Transfer*> *getTransfers() const { return &_transfers; }

	/// Gets the base's items.
	ItemContainer *getStorageItems() { return _items; }
	// Gets the base's items.
	//const ItemContainer *getStorageItems() const { return _items; }

	/// Gets the base's scientists.
	int getScientists() const;
	/// Sets the base's scientists.
	void setScientists(int scientists);

	/// Gets the base's engineers.
	int getEngineers() const;
	/// Sets the base's engineers.
	void setEngineers(int engineers);

#if 0
	/// Checks if a target is detected by the base's radar.
	UfoDetection detect(const Ufo *target, const SavedGame *save, bool alreadyTracked) const;
#endif

	/// Gets the base's available soldiers.
	int getAvailableSoldiers(bool checkCombatReadiness = false, bool includeWounded = false) const;
	/// Gets the base's total soldiers.
	int getTotalSoldiers() const;

	/// Gets the base's available scientists.
	int getAvailableScientists() const;
	/// Gets the base's total scientists.
	int getTotalScientists() const;
	/// Gets the base's available engineers.

	int getAvailableEngineers() const;
	/// Gets the base's total engineers.
	int getTotalEngineers() const;

	/// Gets the base's total number and cost of other staff & inventory.
	int getTotalOtherStaffAndInventoryCost(int& staffCount, int& inventoryCount) const;

	/// Gets the base's used living quarters.
	int getUsedQuarters() const;
	/// Gets the base's available living quarters.
	int getAvailableQuarters() const;

	/// Gets the base's used storage space.
	double getUsedStores(bool excludeNormalItems = false) const;
	/// Checks if the base's stores are overfull.
	bool storesOverfull(double offset = 0.0) const;
	/// Checks if the base's stores are so full that even craft equipment and incoming transfers can't fit.
	bool storesOverfullCritical() const;
	/// Gets the base's available storage space.
	int getAvailableStores() const;

	/// Gets the base's used laboratory space.
	int getUsedLaboratories() const;
	/// Gets the base's available laboratory space.
	int getAvailableLaboratories() const;

	/// Gets the base's used workshop space.
	int getUsedWorkshops() const;
	/// Gets the base's available workshop space.
	int getAvailableWorkshops() const;

	/// Gets the base's used hangars.
	int getUsedHangars() const;
	/// Gets the base's available hangars.
	int getAvailableHangars() const;

	/// Get the number of available space lab (not used by a ResearchProject)
	int getFreeLaboratories() const;

	/// Get the number of available space lab (not used by a Production)
	int getFreeWorkshops() const;

	int getAllocatedScientists() const;
	int getAllocatedEngineers() const;

	/// Gets the base's defense value.
	int getDefenseValue() const;

	/// Gets the base's short range detection.
	int getShortRangeDetection() const;
	/// Gets the base's long range detection.
	int getLongRangeDetection() const;

	/// Gets the base's crafts of a certain type.
	int getCraftCount(const RuleCraft *craft) const;
	/// Gets the base's crafts of a certain type.
	int getCraftCountForProduction(const RuleCraft *craft) const;
	/// Gets the base's craft maintenance.
	int getCraftMaintenance() const;

	/// Gets the total count and total salary of soldiers of a certain type stored in the base.
	std::pair<int, int> getSoldierCountAndSalary(const std::string &soldier) const;
	/// Gets the base's personnel maintenance.
	int getPersonnelMaintenance() const;
	/// Gets the base's facility maintenance.
	int getFacilityMaintenance() const;
	/// Gets the base's total monthly maintenance.
	//%rename(getMonthlyMaintenace) getMonthlyMaintenance
	int getMonthlyMaintenace() const;

	// Get the list of base's ResearchProject
	//const std::vector<ResearchProject *> & getResearch() const;
	/// Get the list of base's ResearchProject
	std::vector<ResearchProject *> & getResearch() { return _research; }
	/// Add a new ResearchProject to the Base
	void addResearch(ResearchProject *);
	/// Remove a ResearchProject from the Base
	void removeResearch(ResearchProject *);

	/// Add a new Production to Base
	void addProduction (Production * p);
	/// Remove a Base Production's
	void removeProduction (Production * p);
	/// Get the list of Base Production's
	const std::vector<Production *> & getProductions() const;

	/// Gets the base's used psi lab space.
	int getUsedPsiLabs() const;
	/// Gets the base's total available psi lab space.
	int getAvailablePsiLabs() const;
	/// Gets the base's total free psi lab space.
	int getFreePsiLabs() const;

	/// Gets the base's used training space.
	int getUsedTraining() const;
	/// Gets the base's total available training space.
	int getAvailableTraining() const;
	/// Gets the base's total free training space.
	int getFreeTrainingSpace() const;

	/// Gets the amount of free Containment space.
	int getFreeContainment(int prisonType) const;
	/// Gets the total amount of Containment space.
	int getAvailableContainment(int prisonType) const;
	/// Gets the total amount of used Containment space.
	int getUsedContainment(int prisonType, bool onlyExternal = false) const;

#if 0
	/// Sets the craft's battlescape status.
	void setInBattlescape(bool inbattle);
	/// Gets if the craft is in battlescape.
	bool isInBattlescape() const;
	/// Mark this base for alien retaliation.
	void setRetaliationTarget(bool mark = true);
	/// Gets the retaliation status of this base.
	bool getRetaliationTarget() const;
	/// Sets the corresponding alien retaliation mission.
	void setRetaliationMission(AlienMission* retaliationMission) { _retaliationMission = retaliationMission; }
	/// Gets the corresponding alien retaliation mission.
	AlienMission* getRetaliationMission() const { return _retaliationMission; }

	/// Mark/unmark this base as a fake underwater base.
	void setFakeUnderwater(bool fakeUnderwater) { _fakeUnderwater = fakeUnderwater; }
	/// Is this a fake underwater base?
	bool isFakeUnderwater() const { return _fakeUnderwater; }

	/// Get the detection chance for this base.
	size_t getDetectionChance() const;
	/// Gets how many Grav Shields the base has
	int getGravShields() const;
	/// Setup base defenses.
	void setupDefenses(AlienMission* am);
	/// Get a list of Defensive Facilities
	std::vector<BaseFacility*> *getDefenses();
#endif


	/// Gets the base's vehicles.
	std::vector<Vehicle*> *getVehicles();

#if 0
	/// Gets the list of recently destroyed base facilities.
	std::map<const RuleBaseFacility*, int> *getDestroyedFacilitiesCache() { return &_destroyedFacilitiesCache; }
	/// Damage and/or destroy facilities after a missile impact.
	void damageFacilities(Ufo *ufo);
	/// Damage a given facility.
	int damageFacility(BaseFacility *toBeDamaged);
	/// Destroys all disconnected facilities in the base.
	void destroyDisconnectedFacilities();
	/// Gets a sorted list of the facilities(=iterators) NOT connected to the Access Lift.
	std::list<BASEFACILITIESITERATOR> getDisconnectedFacilities(BaseFacility *remove);
	/// destroy a facility and deal with the side effects.
	void destroyFacility(BASEFACILITIESITERATOR facility);
	void cleanupPrisons(int prisonType);
	/// Cleans up the defenses vector and optionally reclaims the tanks and their ammo.
	void cleanupDefenses(bool reclaimItems);

	/// Check if any facilities in a given area are used.
	BasePlacementErrors isAreaInUse(BaseAreaSubset area, const RuleBaseFacility* replacement = nullptr) const;
	/// Gets available base functionality.
	RuleBaseFacilityFunctions getProvidedBaseFunc(BaseAreaSubset skip) const;
	RuleBaseFacilityFunctions getInherentProvidedBaseFunc() const { return _provideBaseFunc; }
	/// Gets used base functionality.
	RuleBaseFacilityFunctions getRequireBaseFunc(BaseAreaSubset skip) const;
	/// Gets forbidden base functionality.
	RuleBaseFacilityFunctions getForbiddenBaseFunc(BaseAreaSubset skip) const;
	RuleBaseFacilityFunctions getInherentForbiddenBaseFunc() const { return _forbiddenBaseFunc; }
	/// Gets future base functionality.
	RuleBaseFacilityFunctions getFutureBaseFunc(BaseAreaSubset skip) const;
	RuleBaseFacilityFunctions getInherentFutureBaseFunc() const { return _provideBaseFunc; }
	/// Checks if it is possible to build another facility of a given type.
	bool isMaxAllowedLimitReached(RuleBaseFacility *rule) const;

	/// Gets the summary of all recovery rates provided by the base.
	BaseSumDailyRecovery getSumRecoveryPerDay() const;
	/// Removes a craft from the base.
	std::vector<Craft*>::iterator removeCraft(Craft *craft, bool unload);

	/// Gets the base's globe texture.
	const Texture* getGlobeTexture() const { return _globeTexture; }
	/// Sets the base's globe texture.
	void setGlobeTexture(const Texture* globeTexture) { _globeTexture = globeTexture; }
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Base(%s)@%p", self->getName().c_str(), self);
		return strdup(buffer);
	}

	// as purchases are transfers managed in PurchaseState::btnOKClick,
	// we duplicate the functionality here
	/// (JS Extension) This method generates a purchase operation (in
	/// fact a transfer) after checking the budget and space
	/// availability. The funds are decreased of the cost of
	/// this purchase.
	///
	/// @param rule: defines the item to be procured
	/// @param quantity: number of items to purchase
	///
	/// @returns true if OK, false if purchase is not possible
	///
	bool requestPurchase(const OpenXcom::RuleItem* rule, int quantity) {
		OpenXcom::SavedGame *sg = game->getSavedGame();

		// Check budget and store availability
		int64_t cost = quantity * rule->getBuyCostAdjusted(self, sg);
		if (cost == 0 || cost > sg->getFunds()) {
			// cannot buy this or not enough money
			return false;
		}
		double size = quantity * rule->getSize();
		if (self->storesOverfull(size)) {
			// no enough space
			return false;
		}

		// Generate the purchase (a transfer actually)
		OpenXcom::Transfer *t = new OpenXcom::Transfer(rule->getTransferTime());
		t->setItems(rule, quantity);
		self->getTransfers()->push_back(t);
		// Decrease the funds by the purchased amount
		sg->setFunds(sg->getFunds() - cost);
		return true;
	}


	/// (JS Extension) This method checks if an item can be or is manufactured.
	///
	/// Two variants of this method: with RuleItem and with RuleManufacture
	/// @param rule: defines the item to be manufactured
	///
	/// @returns true if OK, false if production is not possible
	bool isProductionAllowed(const OpenXcom::RuleManufacture *rule) {
		OpenXcom::SavedGame *sg = game->getSavedGame();

		// Check that we are allowed to manufacture this item
		bool allowed = false;
		std::vector<OpenXcom::RuleManufacture*> productions;
		sg->getAvailableProductions(productions, game->getMod(), self, OpenXcom::MANU_FILTER_DEFAULT_SUPPLIES_OK);
		for (auto rmi = productions.begin(); rmi != productions.end(); rmi++) {
			if ((*rmi) == rule) {
				allowed = true;
				break;
			}
		}
		if (!allowed) {
			for (auto* ongoing : self->getProductions()) {
				if (ongoing->getRules() == rule) {
					allowed = true;
					break;
				}
			}
		}

		return allowed;
	}

	/// (JS Extension) This method checks if an item can be or is manufactured.
	///
	/// Two variants of this method: with RuleItem and with RuleManufacture
	/// @param item: defines the item to be manufactured
	///
	/// @returns true if OK, false if production is not possible
	bool isProductionAllowed(const OpenXcom::RuleItem *item) {
		OpenXcom::SavedGame *sg = game->getSavedGame();

		// Find the manufacturing rule and check if we are allowed to manufacture this item
		bool allowed = false;
		std::vector<OpenXcom::RuleManufacture*> productions;
		sg->getAvailableProductions(productions, game->getMod(), self, OpenXcom::MANU_FILTER_DEFAULT_SUPPLIES_OK);
		for (auto rmi = productions.begin(); rmi != productions.end(); rmi++) {
			if ((*rmi)->getProducedItems().find(item) != (*rmi)->getProducedItems().end()) {
				allowed = true;
				break;
			}
		}
		if (!allowed) {
			for (auto* ongoing : self->getProductions()) {
				auto* rmi = ongoing->getRules();
				if (rmi->getProducedItems().find(item) != rmi->getProducedItems().end()) {
					allowed = true;
					break;
				}
			}
		}

		return allowed;
	}

	/// (JS Extension) This method generates a new production line
	/// after checking if the item can be manufactured
	/// and it there is enough worshop space and engineers.
	///
	/// It does not check if this item is not already in production.
	///
	/// Two variants of this method: with RuleItem and with RuleManufacture
	/// @param rule: defines the item to be manufactured
	/// @param quantity: number of item to produce
	/// @param engineers: number of engineers to allocate
	///
	/// @returns true if OK, false if production is not possible
	bool requestProduction(const OpenXcom::RuleManufacture *rule, int quantity, int engineers) {
		OpenXcom::SavedGame *sg = game->getSavedGame();

		// Check that we are allowed to manufacture this item
		bool allowed = false;
		std::vector<OpenXcom::RuleManufacture*> productions;
		sg->getAvailableProductions(productions, game->getMod(), self, OpenXcom::MANU_FILTER_DEFAULT_SUPPLIES_OK);
		for (auto rmi = productions.begin(); rmi != productions.end(); rmi++) {
			if ((*rmi) == rule) {
				allowed = true;
				break;
			}
		}
		if (!allowed) {
			// cannot produce this item
			return false;
		}

		int availableWorkSpace = self->getFreeWorkshops();
		if (availableWorkSpace < rule->getRequiredSpace()) {
			// Not enough workspace
			return false;
		}
		availableWorkSpace -= rule->getRequiredSpace();
		// Do we really have this number of engineers available ?
		int availableEngineer = self->getAvailableEngineers();
		if (availableEngineer < engineers) {
			// Not the expected number of engineers
			return false;
		}

		int can_assign = std::min(engineers, availableWorkSpace);
		OpenXcom::Production *p = new OpenXcom::Production(rule, quantity);
		self->addProduction(p);
		p->setAssignedEngineers(can_assign);
		self->setEngineers(self->getEngineers()-can_assign);
		return true;
	}

	/// (JS Extension) This method generates a new production line
	/// after checking if the item can be manufactured
	/// and it there is enough worshop space and engineers.
	///
	/// It does not check if this item is not already in production.
	///
	/// Two variants of this method: with RuleItem and with RuleManufacture
	///
	/// @param item: defines the item to be manufactured
	/// @param quantity: number of item to produce
	/// @param engineers: number of engineers to allocate
	///
	/// @returns true if OK, false if production is not possible
	bool requestProduction(const OpenXcom::RuleItem *item, int quantity, int engineers) {
		OpenXcom::SavedGame *sg = game->getSavedGame();

		// Find the manufacturing rule (and check if we are allowed to manufacture this item)
		bool allowed = false;
		std::vector<OpenXcom::RuleManufacture*> productions;
		sg->getAvailableProductions(productions, game->getMod(), self, OpenXcom::MANU_FILTER_DEFAULT_SUPPLIES_OK);
		OpenXcom::RuleManufacture* rule = nullptr;
		for (auto rmi = productions.begin(); rmi != productions.end(); rmi++) {
			if ((*rmi)->getProducedItems().find(item) != (*rmi)->getProducedItems().end()) {
				allowed = true;
				rule = *rmi;
				break;
			}
		}
		if (!allowed) {
			// cannot produce this item
			return false;
		}

		int availableWorkSpace = self->getFreeWorkshops();
		if (availableWorkSpace < rule->getRequiredSpace()) {
			// Not enough workspace
			return false;
		}
		availableWorkSpace -= rule->getRequiredSpace();
		// Do we really have this number of engineers available ?
		int availableEngineer = self->getAvailableEngineers();
		if (availableEngineer < engineers) {
			// Not the expected number of engineers
			return false;
		}

		int can_assign = std::min(engineers, availableWorkSpace);
		OpenXcom::Production *p = new OpenXcom::Production(rule, quantity);
		self->addProduction(p);
		p->setAssignedEngineers(can_assign);
		self->setEngineers(self->getEngineers()-can_assign);
		return true;
	}

#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Base);

}  /* end of namespace OpenXcom */

