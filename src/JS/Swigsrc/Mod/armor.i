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
%echo "Processing Armor.i"
#endif

namespace OpenXcom
{
enum UnitSide: int;

class Armor
{
public:

	/// Gets the armor's type.
	const std::string& getType() const;

#if 0
	/// Gets the unit's sprite sheet.
	std::string getSpriteSheet() const;
	/// Gets the unit's inventory sprite.
	std::string getSpriteInventory() const;
#endif

	/// Gets the front armor level.
	int getFrontArmor() const;
	/// Gets the left side armor level.
	int getLeftSideArmor() const;
	/// Gets the right side armor level.
	int getRightSideArmor() const;
	/// Gets the rear armor level.
	int getRearArmor() const;
	/// Gets the under armor level.
	int getUnderArmor() const;
	/// Gets the armor level of armor side.
	int getArmor(UnitSide side) const;

#if 0
	/// Gets the Geoscape corpse item.
	const RuleItem* getCorpseGeoscape() const;
	/// Gets the Battlescape corpse item.
	const std::vector<const RuleItem*> &getCorpseBattlescape() const;
	/// Gets the Geoscape corpse item.
	const RuleItem* getSelfDestructItem() const { return _selfDestructItem ? _selfDestructItem : _corpseGeo && _corpseGeo->getPower() > 0 ? _corpseGeo : nullptr; }
#endif

	/// Gets the stores item.
	const RuleItem* getStoreItem() const;
	/// Gets the special weapon type.
	const RuleItem* getSpecialWeapon() const;
	/// Gets the research required to be able to equip this armor.
	const RuleResearch* getRequiredResearch() const;

#if 0
	/// Gets the commendation required to be able to equip this armor.
	const RuleCommendations* getRequiredAward() const { return _requiresAward; }
	/// Gets the soldier bonus required to be able to equip this armor.
	const RuleSoldierBonus* getRequiredBonus() const { return _requiresBonus; }

	/// Armor have layered armor definition. Check by Prefix.
	bool hasLayersDefinition() const { return !_layersDefaultPrefix.empty(); }
	/// Gets the default prefix for layered armor sprite names.
	const std::string &getLayersDefaultPrefix() const { return _layersDefaultPrefix; }
	/// Gets the overrides for layered armor sprite name prefix, per layer.
	const std::map<int, std::string> &getLayersSpecificPrefix() const { return _layersSpecificPrefix; }
	/// Gets the layered armor definition.
	const std::map<std::string, std::vector<std::string> > &getLayersDefinition() const { return _layersDefinition; }

	/// Gets the battlescape drawing routine ID.
	int getDrawingRoutine() const;
	/// Gets whether or not to draw bubbles (breathing animation).
	bool drawBubbles() const;
	/// DO NOT USE THIS FUNCTION OUTSIDE THE BATTLEUNIT CONSTRUCTOR OR I WILL HUNT YOU DOWN.
	MovementType getMovementType() const;
	/// Get MovementType based on depth of battle.
	MovementType getMovementTypeByDepth(int depth) const;
	/// Gets the armor's special ability.
	int getSpecialAbility() const;

	/// Gets weight value as hostile unit.
	NullableValue<AIAttackWeight> getAITargetWeightAsHostile() const { return _aiTargetWeightAsHostile; }
	/// Gets weight value as civilian unit when consider by aliens.
	NullableValue<AIAttackWeight> getAITargetWeightAsHostileCivilians() const { return _aiTargetWeightAsHostileCivilians; }
	/// Gets weight value as same faction unit.
	NullableValue<AIAttackWeight> getAITargetWeightAsFriendly() const { return _aiTargetWeightAsFriendly; }
	/// Gets weight value as neutral unit (xcom to civ or vice versa).
	NullableValue<AIAttackWeight> getAITargetWeightAsNeutral() const { return _aiTargetWeightAsNeutral; }

	/// Should turning before first step cost TU or not?
	bool getTurnBeforeFirstStep() const { return _turnBeforeFirstStep; }
	/// Gets the turn cost.
	int getTurnCost() const { return _turnCost; }

	/// Multiplier of all move costs.
	ArmorMoveCost getMoveCostBase() const { return _moveCostBase; }
	/// Multiplier of normal base move cost.
	ArmorMoveCost getMoveCostBaseNormal() const { return _moveCostBaseNormal; }
	/// Multiplier of fly base move cost.
	ArmorMoveCost getMoveCostBaseFly() const { return _moveCostBaseFly; }
	/// Multiplier of climb base move cost.
	ArmorMoveCost getMoveCostBaseClimb() const { return _moveCostBaseClimb; }

	/// Multiplier of walk move cost.
	ArmorMoveCost getMoveCostWalk() const { return _moveCostWalk; }
	/// Multiplier of run move cost.
	ArmorMoveCost getMoveCostRun() const { return _moveCostRun; }
	/// Multiplier of strafe move cost.
	ArmorMoveCost getMoveCostStrafe() const { return _moveCostStrafe; }
	/// Multiplier of sneak move cost.
	ArmorMoveCost getMoveCostSneak() const { return _moveCostSneak; }
	/// Multiplier of fly "walk" move cost.
	ArmorMoveCost getMoveCostFlyWalk() const { return _moveCostFlyWalk; }
	/// Multiplier of fly "run" move cost.
	ArmorMoveCost getMoveCostFlyRun() const { return _moveCostFlyRun; }
	/// Multiplier of fly "strafe" cost.
	ArmorMoveCost getMoveCostFlyStrafe() const { return _moveCostFlyStrafe; }
	/// Multiplier of fly up move cost.
	ArmorMoveCost getMoveCostFlyUp() const { return _moveCostFlyUp; }
	/// Multiplier of fly down move cost.
	ArmorMoveCost getMoveCostFlyDown() const { return _moveCostFlyDown; }
	/// Multiplier of climb up move cost.
	ArmorMoveCost getMoveCostClimbUp() const { return _moveCostClimbUp; }
	/// Multiplier of climb down move cost.
	ArmorMoveCost getMoveCostClimbDown() const { return _moveCostClimbDown; }
	/// Multiplier of moving using GravLift cost.
	ArmorMoveCost getMoveCostGravLift() const { return _moveCostGravLift; }

	/// Gets the move sound id. Overrides default/unit's move sound. To be used in BattleUnit constructors only too!
	int getMoveSound() const;
	/// Gets the male death sounds.
	const std::vector<int> &getMaleDeathSounds() const { return _deathSoundMale; }
	/// Gets the female death sounds.
	const std::vector<int> &getFemaleDeathSounds() const { return _deathSoundFemale; }
	/// Gets the male "select unit" sounds.
	const std::vector<int> &getMaleSelectUnitSounds() const { return _selectUnitSoundMale; }
	/// Gets the female "select unit" sounds.
	const std::vector<int> &getFemaleSelectUnitSounds() const { return _selectUnitSoundFemale; }
	/// Gets the male "start moving" sounds.
	const std::vector<int> &getMaleStartMovingSounds() const { return _startMovingSoundMale; }
	/// Gets the female "start moving" sounds.
	const std::vector<int> &getFemaleStartMovingSounds() const { return _startMovingSoundFemale; }
	/// Gets the male "select weapon" sounds.
	const std::vector<int> &getMaleSelectWeaponSounds() const { return _selectWeaponSoundMale; }
	/// Gets the female "select weapon" sounds.
	const std::vector<int> &getFemaleSelectWeaponSounds() const { return _selectWeaponSoundFemale; }
	/// Gets the male "annoyed" sounds.
	const std::vector<int> &getMaleAnnoyedSounds() const { return _annoyedSoundMale; }
	/// Gets the female "annoyed" sounds.
	const std::vector<int> &getFemaleAnnoyedSounds() const { return _annoyedSoundFemale; }

	/// Gets the list of defined voice sets.
	const std::map<std::string, std::vector<const RuleVoiceSet*> > &getVoiceSetsRaw() const { return _voiceSets; }
	/// Gets a random voice set.
	const RuleVoiceSet* getRandomVoiceSet(const Soldier* s) const;
#endif

	/// Gets whether this is a normal or big unit.
	int getSize() const;
	/// Gets how much space the armor occupies in a craft.
	int getTotalSize() const;

#if 0
	/// Gets damage modifier.
	float getDamageModifier(ItemDamageType dt) const;
	const std::vector<float> getDamageModifiersRaw() const;
	/// Gets loftempSet
	const std::vector<int> &getLoftempsSet() const;
	/// Gets the armor's stats.
	const UnitStats *getStats() const;
	/// Gets unit psi defense.
	int getPsiDefence(const BattleUnit* unit) const;
	const RuleStatBonus *getPsiDefenceRaw() const { return &_psiDefence; }
	/// Gets unit melee dodge chance.
	int getMeleeDodge(const BattleUnit* unit) const;
	const RuleStatBonus *getMeleeDodgeRaw() const { return &_meleeDodge; }
	/// Gets unit dodge penalty if hit from behind.
	float getMeleeDodgeBackPenalty() const;

	/// Gets unit TU recovery.
	int getTimeRecovery(const BattleUnit* unit, int externalBonuses) const;
	const RuleStatBonus *getTimeRecoveryRaw() const { return &_timeRecovery; }
	/// Gets unit Energy recovery.
	int getEnergyRecovery(const BattleUnit* unit, int externalBonuses) const;
	const RuleStatBonus *getEnergyRecoveryRaw() const { return &_energyRecovery; }
	/// Gets unit Morale recovery.
	int getMoraleRecovery(const BattleUnit* unit, int externalBonuses) const;
	const RuleStatBonus *getMoraleRecoveryRaw() const { return &_moraleRecovery; }
	/// Gets unit Health recovery.
	int getHealthRecovery(const BattleUnit* unit, int externalBonuses) const;
	const RuleStatBonus *getHealthRecoveryRaw() const { return &_healthRecovery; }
	/// Gets unit Mana recovery.
	int getManaRecovery(const BattleUnit* unit, int externalBonuses) const;
	const RuleStatBonus* getManaRecoveryRaw() const { return &_manaRecovery; }
	/// Gets unit Stun recovery.
	int getStunRegeneration(const BattleUnit* unit, int externalBonuses) const;
	const RuleStatBonus *getStunRegenerationRaw() const { return &_stunRecovery; }

	/// Gets the armor's weight.
	int getWeight() const;
	/// Gets number of death frames.
	int getDeathFrames() const;
	/// Gets if armor uses constant animation.
	bool getConstantAnimation() const;
	/// Checks if this armor ignores gender (power suit/flying suit).
	ForcedTorso getForcedTorso() const;
	/// Gets built-in weapons of armor.
	const std::vector<const RuleItem*> &getBuiltInWeapons() const;

	/// Gets max view distance at dark in BattleScape.
	int getVisibilityAtDark() const;
	/// Gets max view distance at day in BattleScape.
	int getVisibilityAtDay() const;
	/// Gets info about camouflage at day.
	int getCamouflageAtDay() const;
	/// Gets info about camouflage at dark.
	int getCamouflageAtDark() const;
	/// Gets info about anti camouflage at day.
	int getAntiCamouflageAtDay() const;
	/// Gets info about anti camouflage at dark.
	int getAntiCamouflageAtDark() const;
	/// Gets info about heat vision.
	int getVisibilityThroughSmoke() const { return _visibilityThroughSmoke; }
	/// Gets info about visibility through fire.
	int getVisibilityThroughFire() const { return _visibilityThroughFire; }
	/// Gets info about psi vision.
	int getPsiVision() const;
	/// Gets info about psi camouflage.
	int getPsiCamouflage() const;
	/// Gets personal soldier light radius;
	int getPersonalLightFriend() const;
	/// Gets personal alien light radius;
	int getPersonalLightHostile() const;
	/// Gets personal civilian light radius;
	int getPersonalLightNeutral() const;
	/// Gets if unit should be always visible.
	bool isAlwaysVisible() const { return _isAlwaysVisible; }

	/// Gets how armor react to fear.
	bool getFearImmune(bool def = false) const;
	/// Gets how armor react to bleeding.
	bool getBleedImmune(bool def = false) const;
	/// Gets how armor react to inflicted pain.
	bool getPainImmune(bool def = false) const;
	/// Gets how armor react to zombification.
	bool getZombiImmune(bool def = false) const;
	/// Gets whether or not this unit ignores close quarters threats.
	bool getIgnoresMeleeThreat(bool def = false) const;
	/// Gets whether or not this unit is a close quarters threat.
	bool getCreatesMeleeThreat(bool def = true) const;
	/// Gets how much damage (over the maximum HP) is needed to vaporize/disintegrate a unit.
	float getOverKill() const;
	/// Get face base color
	int getFaceColorGroup() const;
	/// Get hair base color
	int getHairColorGroup() const;
	/// Get utile base color
	int getUtileColorGroup() const;
	/// Get rank base color
	int getRankColorGroup() const;
	/// Get face base color
	int getFaceColor(int i) const;
	const std::vector<int> &getFaceColorRaw() const { return _faceColor; }
	/// Get hair base color
	int getHairColor(int i) const;
	const std::vector<int> &getHairColorRaw() const { return _hairColor; }
	/// Get utile base color
	int getUtileColor(int i) const;
	const std::vector<int> &getUtileColorRaw() const { return _utileColor; }
	/// Get rank base color
	int getRankColor(int i) const;
	const std::vector<int> &getRankColorRaw() const { return _rankColor; }
	/// Can we access this unit's inventory?
	bool hasInventory() const;
	/// Gets script.
	template<typename Script>
	const typename Script::Container &getScript() const { return _battleUnitScripts.get<Script>(); }
	/// Get all script values.
	const ScriptValues<Armor> &getScriptValuesRaw() const { return _scriptValues; }

	/// Gets the armor's units.
	const std::vector<const RuleSoldier*> &getUnitsRaw() const;
	/// Gets the armor's supported soldier ranks.
	const std::vector<int>& getRanksRaw() const { return _ranks; }
	/// Check if a soldier can use this armor.
	bool getCanBeUsedBy(const Soldier* soldier) const;


	/// Gets the index of the sprite in the CustomArmorPreview sprite set
	const std::vector<int> &getCustomArmorPreviewIndex() const;
	/// Can you run while wearing this armor?
	bool allowsRunning(bool def = true) const;
	/// Can you strafe while wearing this armor?
	bool allowsStrafing(bool def = true) const;
	/// Can you sneak while wearing this armor?
	bool allowsSneaking(bool def = true) const;
	/// Can you kneel while wearing this armor?
	bool allowsKneeling(bool def = true) const;
	/// Can you move while wearing this armor?
	bool allowsMoving() const;
	/// Does this armor count for pilot bonuses?
	bool isPilotArmor() const { return _isPilotArmor; }
	/// Does this armor allow two main weapons during autoequip?
	bool getAllowTwoMainWeapons() const { return _allowTwoMainWeapons; }
	/// Does this armor instantly recover any wounds after the battle?
	bool getInstantWoundRecovery() const;
	/// Gets a unit's height when standing while wearing this armor.
	int getStandHeight() const;
	/// Gets a unit's height when kneeling while wearing this armor.
	int getKneelHeight() const;
	/// Gets a unit's float elevation while wearing this armor.
	int getFloatHeight() const;
	/// Gets a unit's offset for melee attacks.
	int getMeleeOriginVoxelVerticalOffset() const { return _meleeOriginVoxelVerticalOffset; }

	/// Gets the armor type group.
	int getGroup() const { return _group; }
	/// Get the list weight for this armor.
	int getListOrder() const { return _listOrder; }
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Armor@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Armor);

}  /* end of namespace OpenXcom */

