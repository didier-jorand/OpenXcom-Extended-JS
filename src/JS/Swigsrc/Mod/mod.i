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
%echo "Processing Mod.i"
#endif

namespace OpenXcom
{

class Mod
{
public:

	/// Gets the ruleset for a country type.
	RuleCountry *getCountry(const std::string &id, bool error = false) const;
	/// Gets the available countries.
	const std::vector<std::string> &getCountriesList() const;
	/// Gets the ruleset for an extra globe label type.
	RuleCountry *getExtraGlobeLabel(const std::string &id, bool error = false) const;
	/// Gets the available extra globe labels.
	const std::vector<std::string> &getExtraGlobeLabelsList() const;

	/// Gets the ruleset for a region type.
	RuleRegion *getRegion(const std::string &id, bool error = false) const;
	/// Gets the available regions.
	const std::vector<std::string> &getRegionsList() const;

	/// Gets the ruleset for a facility type.
	RuleBaseFacility *getBaseFacility(const std::string &id, bool error = false) const;
	/// Gets the available facilities.
	const std::vector<std::string> &getBaseFacilitiesList() const;

	/// Gets the ruleset for a craft type.
	RuleCraft *getCraft(const std::string &id, bool error = false) const;
	/// Gets the available crafts.
	const std::vector<std::string> &getCraftsList() const;

	/// Gets the ruleset for a craft weapon type.
	RuleCraftWeapon *getCraftWeapon(const std::string &id, bool error = false) const;
	/// Gets the available craft weapons.
	const std::vector<std::string> &getCraftWeaponsList() const;
	/// Is given item a launcher or ammo for craft weapon.
	bool isCraftWeaponStorageItem(const RuleItem* item) const;

#if 0
	/// Gets the ruleset for an item category type.
	RuleItemCategory *getItemCategory(const std::string &id, bool error = false) const;
	/// Gets the available item categories.
	const std::vector<std::string> &getItemCategoriesList() const;
#endif

	/// Gets the ruleset for an item type.
	RuleItem *getItem(const std::string &id, bool error = false) const;
	/// Gets the available items.
	const std::vector<std::string> &getItemsList() const;

#if 0
	/// Gets the ruleset for a voice set type.
	RuleVoiceSet* getVoiceSet(const std::string& type, bool error = false) const;
	/// Gets the available voice sets.
	const std::vector<std::string> &getVoiceSetsList() const;
#endif

#if 0
	/// Gets the ruleset for a weapon set type.
	RuleWeaponSet* getWeaponSet(const std::string& type, bool error = false) const;

	/// Gets the ruleset for a UFO type.
	RuleUfo *getUfo(const std::string &id, bool error = false) const;
	/// Gets the available UFOs.
	const std::vector<std::string> &getUfosList() const;
	/// Gets terrains for battlescape games.

	RuleTerrain *getTerrain(const std::string &name, bool error = false) const;
	/// Gets the available terrains.
	const std::vector<std::string> &getTerrainList() const;

	/// Gets mapdatafile for battlescape games.
	MapDataSet *getMapDataSet(const std::string &name);

	/// Gets skill rules.
	RuleSkill *getSkill(const std::string &name, bool error = false) const;

	/// Gets soldier unit rules.
	RuleSoldier *getSoldier(const std::string &name, bool error = false) const;
	/// Gets the available soldiers.
	const std::vector<std::string> &getSoldiersList() const;

	/// Gets commendation rules.
	RuleCommendations *getCommendation(const std::string &id, bool error = false) const;
	/// Gets the available commendations.
	const std::map<std::string, RuleCommendations *> &getCommendationsList() const;

	/// Gets generated unit rules.
	Unit *getUnit(const std::string &name, bool error = false) const;

	/// Gets alien race rules.
	AlienRace *getAlienRace(const std::string &name, bool error = false) const;
	/// Gets the available alien races.
	const std::vector<std::string> &getAlienRacesList() const;

	/// Gets an enviro effects definition.
	RuleEnviroEffects* getEnviroEffects(const std::string& name) const;
	/// Gets the available enviro effects.
	const std::vector<std::string>& getEnviroEffectsList() const;

	/// Gets a starting condition.
	RuleStartingCondition* getStartingCondition(const std::string& name) const;
	/// Gets the available starting conditions.
	const std::vector<std::string>& getStartingConditionsList() const;

	/// Gets deployment rules.
	AlienDeployment *getDeployment(const std::string &name, bool error = false) const;
	/// Gets the available alien deployments.
	const std::vector<std::string> &getDeploymentsList() const;

	/// Gets armor rules.
	Armor *getArmor(const std::string &name, bool error = false) const;
	/// Gets the all armors.
	const std::vector<std::string> &getArmorsList() const;
	/// Gets the available armors for soldiers.
	const std::vector<const Armor*> &getArmorsForSoldiers() const;
	/// Check if item is used for armor storage.
	bool isArmorStorageItem(const RuleItem* item) const;

	/// Gets Ufopaedia article definition.
	ArticleDefinition *getUfopaediaArticle(const std::string &name, bool error = false) const;
	/// Gets the available articles.
	const std::vector<std::string> &getUfopaediaList() const;
	/// Gets the available article categories.
	const std::vector<std::string> &getUfopaediaCategoryList() const;

	/// Gets the inventory list.
	std::map<std::string, RuleInventory*> *getInventories();
	/// Gets the ruleset for a specific inventory.
	RuleInventory *getInventory(const std::string &id, bool error = false) const;
	/// Gets the ruleset for right hand inventory slot.
	RuleInventory *getInventoryRightHand() const { return getInventory("STR_RIGHT_HAND", true); }
	/// Gets the ruleset for left hand inventory slot.
	RuleInventory *getInventoryLeftHand() const { return getInventory("STR_LEFT_HAND", true); }
	/// Gets the ruleset for backpack inventory slot.
	RuleInventory *getInventoryBackpack() const { return getInventory("STR_BACK_PACK", true); }
	/// Gets the ruleset for belt inventory slot.
	RuleInventory *getInventoryBelt() const { return getInventory("STR_BELT", true); }
	/// Gets the ruleset for ground inventory slot.
	RuleInventory *getInventoryGround() const { return getInventory("STR_GROUND", true); }

	/// Gets whether or not the inventory slots overlap with the paperdoll button
	bool getInventoryOverlapsPaperdoll() const { return _inventoryOverlapsPaperdoll; }
	/// Gets max view distance in BattleScape.
	int getMaxViewDistance() const { return _maxViewDistance; }
	/// Gets threshold of darkness for LoS calculation.
	int getMaxDarknessToSeeUnits() const { return _maxDarknessToSeeUnits; }
	/// Gets max static (tiles & fire) light distance in BattleScape.
	int getMaxStaticLightDistance() const { return _maxStaticLightDistance; }
	/// Gets max dynamic (items & units) light distance in BattleScape.
	int getMaxDynamicLightDistance() const { return _maxDynamicLightDistance; }
	/// Get flags for enhanced lighting, 0x1 - tiles and fire, 0x2 - items, 0x4 - units.
	int getEnhancedLighting() const { return _enhancedLighting; }
	/// Get basic damage type
	const RuleDamageType *getDamageType(ItemDamageType type) const;

	/// Gets the cost of hiring an engineer.
	int getHireEngineerCost() const;
	/// Gets the research topic required for hiring new engineers.
	const RuleResearch* getHireEngineersUnlockResearch() const { return _hireEngineersUnlockResearch; }
	/// Gets the base functions required for hiring new engineers.
	RuleBaseFacilityFunctions getHireEngineersRequiresBaseFunc() const { return _hireEngineersRequiresBaseFunc; }

	/// Gets the cost of hiring a scientist.
	int getHireScientistCost() const;
	/// Gets the research topic required for hiring new scientists.
	const RuleResearch* getHireScientistsUnlockResearch() const { return _hireScientistsUnlockResearch; }
	/// Gets the base functions topic required for hiring new scientists.
	RuleBaseFacilityFunctions getHireScientistsRequiresBaseFunc() const { return _hireScientistsRequiresBaseFunc; }

	/// Gets the monthly cost of an engineer.
	int getEngineerCost() const;
	/// Gets the monthly cost of a scientist.
	int getScientistCost() const;
	/// Gets the transfer time of personnel.
	int getPersonnelTime() const;
	/// Gets the odds of hiring soldiers by country.
	int getHireByCountryOdds() const { return _hireByCountryOdds; }
	/// Gets the odds of hiring soldiers by region.
	int getHireByRegionOdds() const { return _hireByRegionOdds; }

	/// Gets the global transfer cost multiplier.
	int getGlobalTransferCostMultiplier() const { return _globalTransferCostMult; }
	/// Gets the global transfer cost divider.
	int getGlobalTransferCostDivider() const { return _globalTransferCostDiv; }

	/// Gets first turn when AI can use Blaster launcher.
	int getAIUseDelayBlaster() const  {return _aiUseDelayBlaster;}
	/// Gets first turn when AI can use firearms.
	int getAIUseDelayFirearm() const  {return _aiUseDelayFirearm;}
	/// Gets first turn when AI can use grenades.
	int getAIUseDelayGrenade() const  {return _aiUseDelayGrenade;}
	/// Gets first turn when AI can use proxy grenades.
	int getAIUseDelayProxy() const  {return _aiUseDelayProxy;}
	/// Gets first turn when AI can use martial arts.
	int getAIUseDelayMelee() const {return _aiUseDelayMelee;}
	/// Gets first turn when AI can use psionic abilities.
	int getAIUseDelayPsionic() const  {return _aiUseDelayPsionic;}
	/// Gets first turn when AI can use self-target medikits.
	int getAIUseDelayMedikit() const { return _aiUseDelayMedikit; }
	/// Gets how much AI intelligence should be used to determine firing mode for sniping.
	int getAIFireChoiceIntelCoeff() const {return _aiFireChoiceIntelCoeff;}
	/// Gets how much AI aggression should be used to determine firing mode for sniping.
	int getAIFireChoiceAggroCoeff() const {return _aiFireChoiceAggroCoeff;}
	/// Gets whether or not to use extended firing mode scoring for determining which attack the AI should use
	bool getAIExtendedFireModeChoice() const {return _aiExtendedFireModeChoice;}
	/// Gets whether or not the AI should try to shoot beyond a weapon's max range, true = don't shoot if you can't
	bool getAIRespectMaxRange() const {return _aiRespectMaxRange;}
	/// Gets whether or not the AI should be allowed to continue destroying base facilities after first encountering XCom
	bool getAIDestroyBaseFacilities() const { return _aiDestroyBaseFacilities; }
	/// Gets whether or not the alien AI should pick up weapons more actively.
	bool getAIPickUpWeaponsMoreActively() const { return _aiPickUpWeaponsMoreActively; }
	/// Gets whether or not the civilian AI should pick up weapons more actively.
	bool getAIPickUpWeaponsMoreActivelyCiv() const { return _aiPickUpWeaponsMoreActivelyCiv; }
	/// Gets the reaction fire threshold (default = 0).
	int getReactionFireThreshold(UnitFaction faction) const;
	/// Gets weight value that AI use to determine if target is dangerous.
	AIAttackWeight getAITargetWeightThreatThreshold() const { return _aiTargetWeightThreatThreshold; }
	/// Gets default weight value of hostile unit.
	AIAttackWeight getAITargetWeightAsHostile() const { return _aiTargetWeightAsHostile; }
	/// Gets default weight value of civilian unit when consider by aliens.
	AIAttackWeight getAITargetWeightAsHostileCivilians() const { return _aiTargetWeightAsHostileCivilians; }
	/// Gets default weight value of same faction unit.
	AIAttackWeight getAITargetWeightAsFriendly() const { return _aiTargetWeightAsFriendly; }
	/// Gets default weight value of neutral unit (xcom to civ or vice versa).
	AIAttackWeight getAITargetWeightAsNeutral() const { return _aiTargetWeightAsNeutral; }

	/// Gets maximum supported lookVariant.
	int getMaxLookVariant() const;
	/// Gets the threshold for too much smoke (vanilla default = 10).
	int getTooMuchSmokeThreshold() const  {return _tooMuchSmokeThreshold;}
	/// Gets the custom physical training factor in percent (default = 100).
	int getCustomTrainingFactor() const { return _customTrainingFactor; }
	/// Gets the chance to stop retaliation after unsuccessful xcom base attack (default = 0).
	int getChanceToStopRetaliation() const { return _chanceToStopRetaliation; }
	/// Gets the chance to detect an alien base by xcom operatives each month (default = 20).
	int getChanceToDetectAlienBaseEachMonth() const { return _chanceToDetectAlienBaseEachMonth; }
	/// Should a damaged UFO deploy less aliens during the base defense?
	bool getLessAliensDuringBaseDefense() const { return _lessAliensDuringBaseDefense; }
	/// Will countries join the good side again after the infiltrator base is destroyed?
	bool getAllowCountriesToCancelAlienPact() const { return _allowCountriesToCancelAlienPact; }
	/// Should alien infiltration bases be built close to the infiltrated country?
	bool getBuildInfiltrationBaseCloseToTheCountry() const { return _buildInfiltrationBaseCloseToTheCountry; }
	/// Should alien infiltration pick countries in a region randomly (or in a pre-defined ruleset order)?
	bool getInfiltrateRandomCountryInTheRegion() const { return _infiltrateRandomCountryInTheRegion; }
	/// Should alien bases be allowed (in worst case) on invalid globe textures or not?
	bool getAllowAlienBasesOnWrongTextures() const { return _allowAlienBasesOnWrongTextures; }
	/// Gets the global kneel bonus (default = 115).
	int getKneelBonusGlobal() const { return _kneelBonusGlobal; }
	/// Gets the global one-handed penalty (default = 80).
	int getOneHandedPenaltyGlobal() const { return _oneHandedPenaltyGlobal; }
	/// Gets whether close quarters combat is enabled (default = 0 is off).
	int getEnableCloseQuartersCombat() const { return _enableCloseQuartersCombat; }
	/// Gets the default close quarters combat accuracy (default = 100).
	int getCloseQuartersAccuracyGlobal() const { return _closeQuartersAccuracyGlobal; }
	/// Gets the default close quarters combat TU cost (default = 12).
	int getCloseQuartersTuCostGlobal() const { return _closeQuartersTuCostGlobal; }
	/// Gets the default close quarters combat energy cost (default = 8).
	int getCloseQuartersEnergyCostGlobal() const { return _closeQuartersEnergyCostGlobal; }
	/// Gets the percentage for successfully avoiding CQC when sneaking up on the enemy (default = 0% = turned off).
	int getCloseQuartersSneakUpGlobal() const { return _closeQuartersSneakUpGlobal; }
	/// Gets the default accuracy penalty for having no LOS to the target (default = 0 is no penalty)
	int getNoLOSAccuracyPenaltyGlobal() const { return _noLOSAccuracyPenaltyGlobal; }
	/// Gets the default setting for primed grenades exploding in the inventory (default = 0 is no explosion)
	int getExplodeInventoryGlobal() const { return _explodeInventoryGlobal; }
	/// Gets the surrender mode (default = 0).
	int getSurrenderMode() const { return _surrenderMode; }
	/// Gets the bug hunt mode minimum turn requirement (default = 20).
	int getBughuntMinTurn() const { return _bughuntMinTurn; }
	/// Gets the bug hunt mode maximum remaining enemies requirement (default = 2).
	int getBughuntMaxEnemies() const { return _bughuntMaxEnemies; }
	/// Gets the bug hunt mode "VIP rank" parameter (default = 0).
	int getBughuntRank() const { return _bughuntRank; }
	/// Gets the bug hunt mode low morale threshold parameter (default = 40).
	int getBughuntLowMorale() const { return _bughuntLowMorale; }
	/// Gets the bug hunt mode time units % parameter (default = 60).
	int getBughuntTimeUnitsLeft() const { return _bughuntTimeUnitsLeft; }

	/// Is the mana feature enabled (default false)?
	bool isManaFeatureEnabled() const { return _manaEnabled; }
	/// Is the mana bar enabled for the Battlescape UI (default false)?
	bool isManaBarEnabled() const { return _manaBattleUI; }
	/// Is the mana trained as a primary skill (e.g. like firing accuracy)?
	bool isManaTrainingPrimary() const { return _manaTrainingPrimary; }
	/// Is the mana trained as a secondary skill (e.g. like strength)?
	bool isManaTrainingSecondary() const { return _manaTrainingSecondary; }
	/// Gets the mana unlock research topic (default empty)?
	const RuleResearch* getManaUnlockResearch() const { return _manaUnlockResearch; }

	/// How much missing mana will act as "fatal wounds" and prevent the soldier from going into battle.
	int getManaWoundThreshold() const { return _manaMissingWoundThreshold; }
	/// Should a soldier's mana be fully replenished after a mission?
	bool getReplenishManaAfterMission() const { return _manaReplenishAfterMission; }

	/// How much missing health will act as "fatal wounds" and prevent the soldier from going into battle.
	int getHealthWoundThreshold() const { return _healthMissingWoundThreshold; }
	/// Should a soldier's health be fully replenished after a mission?
	bool getReplenishHealthAfterMission() const { return _healthReplenishAfterMission; }

	/// Gets the cutscene ID that should be played when the player loses due to poor economy management.
	const std::string &getLoseMoneyCutscene() const { return _loseMoney; }
	/// Gets the cutscene ID that should be played when the player loses due to poor rating.
	const std::string &getLoseRatingCutscene() const { return _loseRating; }
	/// Gets the cutscene ID that should be played when the player loses the last base.
	const std::string &getLoseDefeatCutscene() const { return _loseDefeat; }

	/// Gets the research topic required for building XCOM bases on fakeUnderwater globe textures.
	const RuleResearch* getFakeUnderwaterBaseUnlockResearch() const { return _fakeUnderwaterBaseUnlockResearch; }
	/// Gets the research topic required for building XCOM bases.
	const RuleResearch* getNewBaseUnlockResearch() const { return _newBaseUnlockResearch; }

	/// Gets the threshold for defining a glancing hit on a ufo during interception
	int getUfoGlancingHitThreshold() const { return _ufoGlancingHitThreshold; }
	/// Gets the parameter for drawing the width of a ufo's beam weapon based on power
	int getUfoBeamWidthParameter() const { return _ufoBeamWidthParameter; }
	/// Gets the modifier to a tractor beam's power based on a ufo's size
	int getUfoTractorBeamSizeModifier(int ufoSize) const { return _ufoTractorBeamSizeModifiers[ufoSize]; }
	/// Gets the escort range
	double getEscortRange() const;
	/// Gets the setting for drawing alien base/UFO radar circles.
	int getDrawEnemyRadarCircles() const { return _drawEnemyRadarCircles; }
	/// Should escorts join the fight against HK (automatically)? Or is only fighting one-on-one allowed?
	bool getEscortsJoinFightAgainstHK() const { return _escortsJoinFightAgainstHK; }
	/// Should hunter-killers be able to retarget every 5 seconds on slow game timers (5Sec / 1Min)?
	bool getHunterKillerFastRetarget() const { return _hunterKillerFastRetarget; }
	/// Gets the crew emergency evacuation survival chance
	int getCrewEmergencyEvacuationSurvivalChance() const { return _crewEmergencyEvacuationSurvivalChance; }
	/// Gets the pilots emergency evacuation survival chance
	int getPilotsEmergencyEvacuationSurvivalChance() const { return _pilotsEmergencyEvacuationSurvivalChance; }
	/// Should UFO preview be shown in base defense UI?
	bool showUfoPreviewInBaseDefense() const { return _showUfoPreviewInBaseDefense; }
	/// Gets how many soldiers are needed for one promotion of a given rank
	int getSoldiersPerRank(const SoldierRank rank) const { return _soldiersPerRank[(size_t)rank]; }
	/// Gets the firing accuracy needed for no bonus/penalty
	int getPilotAccuracyZeroPoint() const { return _pilotAccuracyZeroPoint; }
	/// Gets the firing accuracy impact (as percentage of distance to zero point) on pilot's aim in dogfight
	int getPilotAccuracyRange() const { return _pilotAccuracyRange; }
	/// Gets the reactions needed for no bonus/penalty
	int getPilotReactionsZeroPoint() const { return _pilotReactionsZeroPoint; }
	/// Gets the reactions impact (as percentage of distance to zero point) on pilot's dodge ability in dogfight
	int getPilotReactionsRange() const { return _pilotReactionsRange; }
	/// Gets the pilot's bravery needed for very bold approach speed
	int getPilotBraveryThresholdVeryBold() const { return _pilotBraveryThresholds[0]; }
	/// Gets the pilot's bravery needed for bold approach speed
	int getPilotBraveryThresholdBold() const { return _pilotBraveryThresholds[1]; }
	/// Gets the pilot's bravery needed for normal approach speed
	int getPilotBraveryThresholdNormal() const { return _pilotBraveryThresholds[2]; }
	/// Gets a performance bonus for a given score
	int getPerformanceBonus(int score) const { return (int)(score * _performanceBonusFactor); }
	/// Should the player have the option to sort the 'New Research' list?
	bool getEnableNewResearchSorting() const { return _enableNewResearchSorting; }
	/// Should custom categories be used in Buy/Sell/Transfer GUIs? 0=no, 1=yes, custom only, 2=both vanilla and custom.
	int getDisplayCustomCategories() const { return _displayCustomCategories; }
	/// Should weapons "inherit" categories of their ammo?
	bool getShareAmmoCategories() const { return _shareAmmoCategories; }
	/// Should distance in dogfight GUI be shown in kilometers?
	bool getShowDogfightDistanceInKm() const { return _showDogfightDistanceInKm; }
	/// Should alien inventory show full name (e.g. Sectoid Leader) or just the race (e.g. Sectoid)?
	bool getShowFullNameInAlienInventory() const { return _showFullNameInAlienInventory; }
	/// Gets the offset for alien inventory paperdoll and hand slots
	int getAlienInventoryOffsetX() const { return _alienInventoryOffsetX; }
	/// Gets the extra offset for alien inventory hand slots for 2x2 units
	int getAlienInventoryOffsetBigUnit() const { return _alienInventoryOffsetBigUnit; }
	/// Show the INFO button (where applicable) or not?
	bool getShowPediaInfoButton() const { return !_hidePediaInfoButton; }
	/// Display extra item info (accuracy modifier and power bonus) in the main pedia article?
	int getExtraNerdyPediaInfoType() const { return _extraNerdyPediaInfoType; }
	/// In debriefing, give score also for already researched alien artifacts?
	bool getGiveScoreAlsoForResearchedArtifacts() const { return _giveScoreAlsoForResearchedArtifacts; }
	/// When recovering ammo, should partially spent clip have a chance to recover as full?
	bool getStatisticalBulletConservation() const { return _statisticalBulletConservation; }
	/// Does stunning an enemy improve unit and squad morale?
	bool getStunningImprovesMorale() const { return _stunningImprovesMorale; }
	/// Gets how much TU (in percent) should be given to a unit waking up from stun at the beginning of a new turn.
	int getTURecoveryWakeUpNewTurn() const { return _tuRecoveryWakeUpNewTurn; }
	/// Gets whether or not to load base defense terrain from globe texture
	int getBaseDefenseMapFromLocation() const { return _baseDefenseMapFromLocation; }

	/// Return mod what created given rule object.
	template<typename T>
	const ModData* getModCreatingRule(const T* t) const { return _ruleCreationTracking.at(static_cast<const void*>(t)); }
	/// Return mod what last updated given rule object.
	template<typename T>
	const ModData* getModLastUpdatingRule(const T* t) const { return _ruleLastUpdateTracking.at(static_cast<const void*>(t)); }

	/// Gets the ruleset for a specific research project.
	RuleResearch *getResearch(const std::string &id, bool error = false) const;
	/// Gets the ruleset for a specific research project.
	std::vector<const RuleResearch*> getResearch(const std::vector<std::string> &id) const;
	/// Gets the ruleset for a specific research project.
	const std::map<std::string, RuleResearch *> &getResearchMap() const;
	/// Gets the list of all research projects.
	const std::vector<std::string> &getResearchList() const;
	/// Gets the ruleset for a specific manufacture project.
	RuleManufacture *getManufacture (const std::string &id, bool error = false) const;
	/// Gets the list of all manufacture projects.
	const std::vector<std::string> &getManufactureList() const;
	/// Gets the ruleset for a specific soldier bonus type.
	RuleSoldierBonus *getSoldierBonus(const std::string &id, bool error = false) const;
	/// Gets the list of all soldier bonus types.
	const std::vector<std::string> &getSoldierBonusList() const;
	/// Gets the ruleset for a specific soldier transformation project.
	RuleSoldierTransformation *getSoldierTransformation(const std::string &id, bool error = false) const;
	/// Gets the list of all soldier transformation projects.
	const std::vector<std::string> &getSoldierTransformationList() const;
	/// Gets facilities for custom bases.
	std::vector<RuleBaseFacility*> getCustomBaseFacilities(GameDifficulty diff) const;
	/// Gets a specific UfoTrajectory.
	const UfoTrajectory *getUfoTrajectory(const std::string &id, bool error = false) const;
	/// Gets the ruleset for a specific alien mission.
	const RuleAlienMission *getAlienMission(const std::string &id, bool error = false) const;
	/// Gets the ruleset for a random alien mission.
	const RuleAlienMission *getRandomMission(MissionObjective objective, size_t monthsPassed) const;
	/// Gets the list of all alien missions.
	const std::vector<std::string> &getAlienMissionList() const;
	/// Gets the alien item level table.
	const std::vector<std::vector<int> > &getAlienItemLevels() const;
	/// Gets the player starting base.
	const YAML::YamlString& getDefaultStartingBase() const;
	const YAML::YamlString& getStartingBase(GameDifficulty diff) const;
	/// Gets the game starting time.
	const GameTime &getStartingTime() const;
	/// Gets the game starting difficulty.
	int getStartingDifficulty() const { return _startingDifficulty; }
	/// Gets an MCDPatch.
	MCDPatch *getMCDPatch(const std::string &id) const;
	/// Gets the list of external Sprites.
	const std::map<std::string, std::vector<ExtraSprites *> > &getExtraSprites() const;
	/// Gets the list of custom palettes.
	const std::vector<std::string> &getCustomPalettes() const;
	/// Gets the list of external Sounds.
	const std::vector<std::pair<std::string, ExtraSounds *> > &getExtraSounds() const;
	/// Gets the list of external Strings.
	const std::map<std::string, ExtraStrings *> &getExtraStrings() const;
	/// Gets the list of StatStrings.
	const std::vector<StatString *> &getStatStrings() const;
	/// Gets the research-requirements for Psi-Lab (it's a cache for psiStrengthEval)
	const std::vector<const RuleResearch*> &getPsiRequirements() const;
	/// Returns the sorted list of inventories.
	const std::vector<std::string> &getInvsList() const;
	/// Generates a new soldier.
	Soldier *genSoldier(SavedGame *save, const RuleSoldier* ruleSoldier, int nationality) const;
	/// Gets the item to be used as fuel for ships.
	std::string getAlienFuelName() const;
	/// Gets the amount of alien fuel to recover
	int getAlienFuelQuantity() const;
	/// Gets the font name.
	std::string getFontName() const;
	/// Gets the maximum radar range still considered as short.
	int getShortRadarRange() const;
	/// Gets the custom scaling (defined by the modder) applied on the facility upgrade/build time reduction calculated by the game.
	int getBuildTimeReductionScaling() const { return _buildTimeReductionScaling; }
	/// Gets what type of information should be shown in craft articles for the fuel capacity/range
	int getPediaReplaceCraftFuelWithRangeType() const;
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Mod@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Mod);

}  /* end of namespace OpenXcom */

