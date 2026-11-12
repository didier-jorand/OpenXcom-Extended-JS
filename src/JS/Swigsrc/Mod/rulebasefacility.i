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
%echo "Processing RuleBaseFacility.i"
#endif

namespace OpenXcom
{
class RuleResearch;
class RuleItem;
enum BasePlacementErrors : int;

class RuleBaseFacility
{
public:
	/// Gets the facility's type.
	const std::string& getType() const;

#if 0
	/// Gets the facility's requirements.
	const std::vector<const RuleResearch*> &getRequirements() const { return _requires; }
	/// Gets the facility's required function in base to build.
	RuleBaseFacilityFunctions getRequireBaseFunc() const { return _requiresBaseFunc; }
	/// Gets the functions that facility provide in base.
	RuleBaseFacilityFunctions getProvidedBaseFunc() const { return _provideBaseFunc; }
	/// Gets the functions that facility prevent in base.
	RuleBaseFacilityFunctions getForbiddenBaseFunc() const { return _forbiddenBaseFunc; }
	/// Gets the facility's shape sprite.
	int getSpriteShape() const;
	/// Gets the facility's content sprite.
	int getSpriteFacility() const;
	/// Retain sprite over shape behavior for bigger facility?
	bool getSpriteEnabled() const;
	bool getSpriteEnabledRaw() const { return _spriteEnabled; }
	/// Should there be connectors leading to this facility?
	bool connectorsDisabled() const { return _connectorsDisabled; }
#endif

	/// Gets if the facility's size is 1x1.
	bool isSmall() const;
	/// Gets the facility's size.
	int getSizeX() const { return _sizeX; }
	/// Gets the facility's size.
	int getSizeY() const { return _sizeY; }

#if 0
	/// Gets the facility's missile attraction.
	int getMissileAttraction() const { return _missileAttraction; }
	/// Is this facility allowed for a given type of base?
	bool isAllowedForBaseType(bool fakeUnderwaterBase) const;
	int getFakeUnderwaterRaw() const { return _fakeUnderwater; }
#endif

	/// Gets if the facility is an access lift.
	bool isLift() const;
	/// Gets if the facility has hyperwave detection.
	bool isHyperwave() const;
	/// Gets if the facility is a mind shield.
	bool isMindShield() const;
	/// Gets the mind shield power.
	int getMindShieldPower() const;
	/// Gets if the facility is a grav shield.
	bool isGravShield() const;
	/// Gets the facility's construction cost.
	int getBuildCost() const;
	/// Gets the facility's refund value.
	int getRefundValue() const;
	/// Gets the facility's construction cost in items, `first` is build cost, `second` is refund.
	const std::map<std::string, std::pair<int, int> >& getBuildCostItems() const;
	/// Gets the facility's construction time.
	int getBuildTime() const;
	/// Gets the facility's monthly cost.
	int getMonthlyCost() const;
	/// Gets the facility's storage capacity.
	int getStorage() const;
	/// Gets the facility's personnel capacity.
	int getPersonnel() const;
	/// Gets the facility's alien capacity.
	int getAliens() const;
	/// Gets the facility's craft capacity.
	int getCrafts() const;
	/// Gets the facility's laboratory space.
	int getLaboratories() const;
	/// Gets the facility's workshop space.
	int getWorkshops() const;
	/// Gets the facility's psi-training capacity.
	int getPsiLaboratories() const;
	/// Gets the facility's sight range.
	int getSightRange() const { return _sightRange; }
	/// Gets the facility's alien base detection chance.
	int getSightChance() const { return _sightChance; }
	/// Gets the facility's radar range.
	int getRadarRange() const;
	/// Gets the facility's detection chance.
	int getRadarChance() const;
	/// Gets the facility's defense value.
	int getDefenseValue() const;
	/// Gets the facility's weapon hit ratio.
	int getHitRatio() const;
	/// Gets the facility's weapon ammo capacity.
	int getAmmoMax() const { return _ammoMax; }
	/// Gets the facility's weapon rearm rate.
	int getRearmRate() const { return _rearmRate; }
	/// Gets the facility's weapon ammo spent per shot.
	int getAmmoNeeded() const { return _ammoNeeded; }
	/// Should unified or vanilla formula be used?
	bool unifiedDamageFormula() const { return _unifiedDamageFormula; }
	/// Gets the facility's weapon effectiveness against shields.
	int getShieldDamageModifier() const { return _shieldDamageModifier; }
	/// Gets the facility's weapon ammo item.
	const RuleItem* getAmmoItem() const { return _ammoItem; }
	/// Gets the facility's battlescape map name.
	std::string getMapName() const;
	/// Gets the facility's fire sound.
	int getFireSound() const;
	/// Gets the facility's hit sound.
	int getHitSound() const;
	/// Gets the facility's place sound.
	int getPlaceSound() const { return _placeSound; }
	/// Gets the facility's list weight.
	int getListOrder() const;
	/// Gets the facility's training capacity.
	int getTrainingFacilities() const;
	/// Gets the maximum allowed number of facilities per base.
	int getMaxAllowedPerBase() const;
	/// Gets the facility's mana recovery rate.
	int getManaRecoveryPerDay() const { return _manaRecoveryPerDay; }
	/// Gets the facility's health recovery rate.
	int getHealthRecoveryPerDay() const { return _healthRecoveryPerDay; }
	/// Gets the facility's bonus to wound healing.
	float getSickBayAbsoluteBonus() const { return _sickBayAbsoluteBonus; }
	/// Gets the facility's bonus to wound healing (as percentage of max hp of the soldier).
	float getSickBayRelativeBonus() const { return _sickBayRelativeBonus; }
	/// Gets the prison type.
	int getPrisonType() const;
	/// Gets the action type to perform on right click.
	int getRightClickActionType() const;
#if 0
	/// Gets the vertical levels for this facility map generation.
	const std::vector<VerticalLevel> &getVerticalLevels() const;
#endif
	/// Gets the facility left behind when this one is sold
	const std::vector<const RuleBaseFacility*> &getLeavesBehindOnSell() const { return _leavesBehindOnSell; }
	/// Gets how long facilities left behind when this one is sold should take to build
	int getRemovalTime() const;
	/// Gets whether or not this facility can be built over by other ones
	bool getCanBeBuiltOver() const;
	/// Gets whether or not this facility can ONLY be built over another facility (i.e. not standalone)
	bool isUpgradeOnly() const { return _upgradeOnly; }
	/// Check if a given facility `fac` can be replaced by this facility.
	BasePlacementErrors getCanBuildOverOtherFacility(const RuleBaseFacility* fac) const;
	/// Gets which facilities are allowed to be replaced by this building
	const std::vector<const RuleBaseFacility*> &getBuildOverFacilities() const { return _buildOverFacilities; }
#if 0
	/// Gets a list of which tiles are used to place items stored in this facility
	const std::vector<Position> &getStorageTiles() const;
#endif
	/// Gets the ruleset for the destroyed version of this facility.
	const RuleBaseFacility* getDestroyedFacility() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleBaseFacility@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleBaseFacility);

}  /* end of namespace OpenXcom */

