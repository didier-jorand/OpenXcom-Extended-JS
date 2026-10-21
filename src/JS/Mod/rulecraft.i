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
%echo "Processing RuleCraft.i"
#endif

namespace OpenXcom
{

class RuleCraft
{
public:
	/// Maximum number of weapon slots on craft.
	static const int WeaponMax = 4;
	/// Maximum of different types in one weapon slot.
	static const int WeaponTypeMax = 8;

	/// Default craft preview ID.
	static const std::string DEFAULT_CRAFT_DEPLOYMENT_PREVIEW;
	/// Dummy craft ID.
	static const int DUMMY_CRAFT_ID = -42; // a negative integer

	/// Gets the craft's type.
	const std::string &getType() const;

	/// Gets the craft's requirements.
	const std::vector<const RuleResearch*>& getRequirements() const { return _requires; }
#if 0
	/// Gets the base functions required to buy craft.
	RuleBaseFacilityFunctions getRequiresBuyBaseFunc() const { return _requiresBuyBaseFunc; }
#endif
	/// Gets the allied country name required to buy this craft.
	const std::string& getRequiresBuyCountry() const { return _requiresBuyCountry; }

#if 0
	/// Gets the craft's sprite.
	int getSprite(int skinIndex) const;
	const std::vector<int> &getSkinSpritesRaw() const { return _skinSprites; }
	/// Gets the craft's globe marker.
	int getMarker() const;
#endif

	/// Gets the craft's maximum fuel.
	int getMaxFuel() const;
	/// Gets the craft's maximum damage.
	int getMaxDamage() const;
	/// Gets the craft's maximum speed.
	int getMaxSpeed() const;
	/// Gets the craft's acceleration.
	int getAcceleration() const;
	/// Gets the craft's weapon capacity.
	int getWeapons() const;

	/// Checks if this craft is supported in the New Battle mode (and Preview mode).
	bool isForNewBattle() const;

	/// Gets the craft's maximum unit capacity (soldiers and vehicles, small and large).
	int getMaxUnits() const;
	/// Gets the craft's maximum unit capacity (soldiers and vehicles, small and large) *including* any additional weapons module bonuses.
	int getMaxUnitsLimit() const { return _maxUnitsLimit; }
	/// Gets the craft's pilot capacity/requirement.
	int getPilots() const;
	/// Gets the craft's maximum vehicle capacity (incl. 2x2 soldiers).
	int getMaxVehiclesAndLargeSoldiers() const;
	/// Gets the craft's maximum vehicle capacity (incl. 2x2 soldiers) *including* any additional weapons module bonuses.
	int getMaxVehiclesAndLargeSoldiersLimit() const { return _maxVehiclesAndLargeSoldiersLimit; }
	/// Gets the craft's maximum supported number of small (size=1) soldiers.
	int getMaxSmallSoldiers() const { return _maxSmallSoldiers; }
	/// Gets the craft's maximum supported number of large (size=2) soldiers.
	int getMaxLargeSoldiers() const { return _maxLargeSoldiers; }
	/// Gets the craft's maximum supported number of small (size=1) vehicles (HWPs/SWSs).
	int getMaxSmallVehicles() const { return _maxSmallVehicles; }
	/// Gets the craft's maximum supported number of large (size=2) vehicles (HWPs/SWSs).
	int getMaxLargeVehicles() const { return _maxLargeVehicles; }
	/// Gets the craft's maximum supported number of small (size=1) units (soldiers + vehicles).
	int getMaxSmallUnits() const { return _maxSmallUnits; }
	/// Gets the craft's maximum supported number of large (size=2) units (soldiers + vehicles).
	int getMaxLargeUnits() const { return _maxLargeUnits; }
	/// Gets the craft's maximum supported number of soldiers (small + large).
	int getMaxSoldiers() const { return _maxSoldiers; }
	/// Gets the craft's maximum supported number of vehicles (small + large).
	int getMaxVehicles() const { return _maxVehicles; }
	/// Gets the craft's monthly buy limit.
	int getMonthlyBuyLimit() const { return _monthlyBuyLimit; }
	/// Gets the craft's monthly buy limit message.
	const std::string& getMonthlyBuyLimitMessage() const { return _monthlyBuyLimitMessage; }
	/// Gets the craft's cost.
	int getBuyCost() const;
	/// Gets the craft's rent for a month.
	int getRentCost() const;
	/// Gets the craft's value.
	int getSellCost() const;
	/// Gets the craft's refuel item.
	const RuleItem* getRefuelItem() const;
	/// Gets the craft's repair rate.
	int getRepairRate() const;
	/// Gets the craft's refuel rate.
	int getRefuelRate() const;
	/// Gets the craft's radar range.
	int getRadarRange() const;
	/// Gets the craft's radar chance.
	int getRadarChance() const;
	/// Gets the craft's sight range.
	int getSightRange() const;
	/// Gets the craft's transfer time.
	int getTransferTime() const;
	/// Gets the craft's score.
	int getScore() const;

#if 0
	/// Gets the craft's terrain data.
	RuleTerrain *getBattlescapeTerrainData() const;
	/// Gets the craft's maximum skin index.
	int getMaxSkinIndex() const { return _maxSkinIndex; }

	/// Checks if this craft is lost after a failed mission or not.
	bool keepCraftAfterFailedMission() const;
	/// Checks if this craft is capable of landing (on missions).
	bool getAllowLanding() const;
	/// Checks if this craft is capable of travelling to mars.
	bool getSpacecraft() const;
	/// Should notification be displayed when the craft is refueled?
	bool notifyWhenRefueled() const;
	/// Does this craft support auto-patrol?
	bool canAutoPatrol() const;
	/// Is this craft immune to detection by HKs and alien bases?
	bool isUndetectable() const { return _undetectable; }
	/// Can this craft patrol without fuel comsumption?
	bool patrolWithoutFuel() const { return _patrolWithoutFuel; }
	/// Is this craft a self-destruct missile?
	bool isMissile() const { return (_missilePower > 0); }
	/// Gets the missile power.
	int missilePower() const { return _missilePower; }
	/// Gets the list weight for this craft.
	int getListOrder() const;

	/// Gets the deployment priority for the craft.
	const RuleCraftDeployment &getDeployment() const;
	/// Gets the craft inventory tile position.
	const std::vector<int> &getCraftInventoryTile() const;
	/// Gets the craft groups (used in map scripts).
	const std::vector<int>& getGroups() const { return _groups; }
	/// Gets the list of allowed soldier groups.
	const std::vector<int>& getAllowedSoldierGroups() const { return _allowedSoldierGroups; }
	/// Gets the list of allowed armor groups.
	const std::vector<int>& getAllowedArmorGroups() const { return _allowedArmorGroups; }
	/// Gets the list of allowed armor groups.
	const std::map<int, int>& getLimitArmorGroups() const { return _limitArmorGroups; }
	/// Does this craft allow soldiers of the same group only?
	bool isOnlyOneSoldierGroupAllowed() const { return _onlyOneSoldierGroupAllowed; }
	/// Gets the item limit for this craft.
	int getMaxItems() const;
	/// Gets the item storage space limit for this craft.
	double getMaxStorageSpace() const;
	/// Test for possibility of usage of weapon type in weapon slot.
	bool isValidWeaponSlot(int slot, int weaponType) const;
	int getWeaponTypesRaw(int slot, int subslot) const;
	/// Get description string of weapon slot.
	const std::string &getWeaponSlotString(int slot) const;
	/// Gets the string ID of a fixed weapon in a given slot.
	const std::string &getFixedWeaponInSlot(int slot) const;
	/// Get basic statistic of craft.
	const RuleCraftStats& getStats() const;
	/// Gets how high this craft can go.
	int getMaxAltitude() const;
	/// Gets the craft's default display altitude.
	const std::string& getDefaultDisplayAltitude() const;
	/// Gets if this craft only fights on water.
	bool isWaterOnly() const;
	/// Get how many shield points are recharged per hour at base
	int getShieldRechargeAtBase() const;
	/// Get whether the craft's map should be visible at the start of a battle
	bool isMapVisible() const;
	/// Gets whether or not the craft type should be displayed in Monthly Costs even if not present in the base.
	bool forceShowInMonthlyCosts() const;
	/// Can the player utilize all start tiles on a craft or only the ones specified in the '_deployment' list?
	bool useAllStartTiles() const;
	/// Gets the craft's custom preview type.
	const std::string& getCustomPreviewType() const;
	const std::string& getCustomPreviewTypeRaw() const;

	/// Calculate the theoretical range of the craft in nautical miles
	int calculateRange(int type);

	/// Gets the sound played when the player directly selects a craft on the globe.
	int getSelectSound() const;
	const std::vector<int>& getSelectSoundRaw() const { return _selectSound; }
	/// Gets the sound played when a craft takes off from a base.
	int getTakeoffSound() const;
	const std::vector<int>& getTakeoffSoundRaw() const { return _takeoffSound; }

	/// Gets the minimum stats a soldier needs to be eligible for piloting this craft
	const UnitStats& getPilotMinStatsRequired() const { return _pilotMinStatsRequired; }
	/// Gets the list of soldier bonuses a soldier needs to be eligible for piloting this craft
	const std::vector<const RuleSoldierBonus*>& getPilotSoldierBonusesRequired() const { return _pilotSoldierBonusesRequired; }
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleCraft(%s)@%p", self->getType().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleCraft);

}  /* end of namespace OpenXcom */

