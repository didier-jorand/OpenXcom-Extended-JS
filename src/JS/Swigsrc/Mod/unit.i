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
%echo "Processing Unit.i"
#endif

namespace OpenXcom
{

struct UnitStats
{
	using Type = Sint16;

	Type tu, stamina, health, bravery, reactions, firing, throwing, strength, psiStrength, psiSkill, melee, mana;


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "UnitStats@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(UnitStats);

class Unit
{
public:
	/// Gets the unit's type.
	const std::string& getType() const;

#if 0
	/// Gets if unit can be recovered as civilian.
	bool isRecoverableAsCivilian() const { return _civilianRecoveryTypeName.empty() == false || _civilianRecoverySoldierType || _civilianRecoveryItemType; }
	/// Gets if engineer is recovered when a civilian is saved.
	bool isRecoverableAsEngineer() const { return _civilianRecoveryTypeName == "STR_ENGINEER"; }
	/// Gets if scientist is recovered when a civilian is saved.
	bool isRecoverableAsScientist() const { return _civilianRecoveryTypeName == "STR_SCIENTIST"; }
	/// Gets soldier type that is recovered when a civilian is saved.
	const RuleSoldier* getCivilianRecoverySoldierType() const { return _civilianRecoverySoldierType; }
	/// Gets item type that is recovered when a civilian is saved.
	const RuleItem* getCivilianRecoveryItemType() const { return _civilianRecoveryItemType; }
	/// Gets the custom name of the "spawned person".
	const std::string &getSpawnedPersonName() const { return _spawnedPersonName; }
	/// Gets the spawned soldier template.
	const YAML::YamlString &getSpawnedSoldierTemplate() const { return _spawnedSoldier; }

	/// Gets the unit's stats.
	const UnitStats *getStats() const;
	/// Gets the unit's height when standing.
	int getStandHeight() const;
	/// Gets the unit's height when kneeling.
	int getKneelHeight() const;
	/// Gets the unit's float elevation.
	int getFloatHeight() const;
	/// Gets the armor type.
	const Armor* getArmor() const;
	/// Gets the alien race type.
	std::string getRace() const;
	/// Gets the alien rank.
	std::string getRank() const;
	/// Gets the value - for score calculation.
	int getValueKilled() const { return _valueKilled; }
	int getValueCaptured() const { return _valueCaptured; }
	int getValueCapturedResearched() const { return _valueCapturedResearched; }
	int getValueCivilian() const { return _valueCivilian; }
	int getValueCivilianKilledByXcom() const { return _valueCivilianKilledByXcom; }
	int getValueVIP() const { return _valueVIP; }
	/// Percentage modifier for morale loss when this unit is killed.
	int getMoraleLossWhenKilled() const { return _moraleLossWhenKilled; };
	/// Gets the death sound id.
	const std::vector<int> &getDeathSounds() const;
	/// Gets the unit's panic sounds.
	const std::vector<int> &getPanicSounds() const;
	/// Gets the unit's berserk sounds.
	const std::vector<int> &getBerserkSounds() const;
	/// Gets the unit's "select unit" sounds.
	const std::vector<int> &getSelectUnitSounds() const { return _selectUnitSound; }
	/// Gets the unit's "start moving" sounds.
	const std::vector<int> &getStartMovingSounds() const { return _startMovingSound; }
	/// Gets the unit's "select weapon" sounds.
	const std::vector<int> &getSelectWeaponSounds() const { return _selectWeaponSound; }
	/// Gets the unit's "annoyed" sounds.
	const std::vector<int> &getAnnoyedSounds() const { return _annoyedSound; }

	/// Gets the list of defined voice sets.
	const std::vector<const RuleVoiceSet*> &getVoiceSetsRaw() const { return _voiceSets; }
	/// Gets a random voice set.
	const RuleVoiceSet* getRandomVoiceSet() const;

	/// Gets the move sound id.
	int getMoveSound() const;
	/// Gets the intelligence. This is the number of turns AI remembers your troop positions.
	int getIntelligence() const;
	/// Gets the aggression. Determines the chance of revenge and taking cover.
	int getAggression() const;
	/// Gets the spotter score. This is the number of turns sniper AI units can use spotting info from this unit.
	int getSpotterDuration() const;
	/// Gets the sniper score. Determines chance of acting on information gained by spotter units.
	int getSniperPercentage() const;
	/// Gets the alien's special ability.
	int getSpecialAbility() const;
	/// Gets the Geoscape live alien item.
	const RuleItem* getLiveAlienGeoscape() const { return _liveAlien; }
	/// Gets the unit's spawn unit.
	const Unit *getSpawnUnit() const;
	/// Gets the unit's warcries.
	const std::vector<int> &getAggroSounds() const;
	/// Gets how much energy this unit recovers per turn.
	int getEnergyRecovery() const;
	/// Checks if this unit has a built in weapon.
	bool isLivingWeapon() const;
	/// Gets the name of any melee weapon that may be built in to this unit.
	const std::string &getMeleeWeapon() const;
	/// Gets the name of any psi weapon that may be built in to this unit.
	const std::string &getPsiWeapon() const;
	/// Gets a vector of integrated items this unit has available.
	const std::vector<std::vector<const RuleItem*> > &getBuiltInWeapons() const;
	/// Gets a vector of integrated item options this unit has available.
	const std::vector<WeightedOptions*>& getWeightedBuiltInWeapons() const { return _weightedBuiltInWeapons; }
	/// Gets whether the alien can be captured alive.
	bool getCapturable() const;
	/// Checks if this unit can surrender.
	bool canSurrender() const;
	/// Checks if this unit surrenders automatically, if all other units surrendered too.
	bool autoSurrender() const;
	bool isLeeroyJenkins() const { return _isLeeroyJenkins; };
	/// Should the unit get "stuck" trying to fire from outside of weapon range? Vanilla bug, that may serve as "feature" in rare cases.
	bool waitIfOutsideWeaponRange() const { return _waitIfOutsideWeaponRange; };
	/// Should the unit try to pick up weapons more actively?
	int getPickUpWeaponsMoreActively() const { return _pickUpWeaponsMoreActively; }
	/// Is the unit afraid to pathfind through fire?
	bool avoidsFire() const;
	/// Should alien inventory show full name (e.g. Sectoid Leader) or just the race (e.g. Sectoid)?
	bool getShowFullNameInAlienInventory(Mod *mod) const;
	/// Is this a VIP unit?
	bool isVIP() const { return _vip; }
	/// Is this only a cosmetic unit?
	bool isCosmetic() const { return _cosmetic; }
	/// Should this unit be ignored by the AI?
	bool isIgnoredByAI() const { return _ignoredByAI; }
	/// Checks if this unit can panic.
	bool canPanic() const { return _canPanic; }
	/// Checks if this unit can be mind controlled.
	bool canBeMindControlled() const { return _canBeMindControlled; }
	/// Gets the probability of unit berserking when panicked.
	int getBerserkChance() const { return _berserkChance; }
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Unit@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Unit);

}  /* end of namespace OpenXcom */

