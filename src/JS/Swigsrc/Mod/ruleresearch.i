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
%echo "Processing RuleResearch.i"

%template(RuleResearchPVector) std::vector<const OpenXcom::RuleResearch*>;
#endif

namespace OpenXcom
{

class RuleResearch
{
public:

	static const int RESEARCH_STATUS_NEW = 0;
	static const int RESEARCH_STATUS_NORMAL = 1;
	static const int RESEARCH_STATUS_DISABLED = 2;
	static const int RESEARCH_STATUS_HIDDEN = 3;

	/// Gets time needed to discover this ResearchProject.
	int getCost() const;
	/// Gets the research name.
	const std::string &getName() const;

	/// Gets the research dependencies.
	const std::vector<const RuleResearch*> &getDependencies() const;
	/// Checks if this ResearchProject gives free topics in sequential order (or random order).
	bool sequentialGetOneFree() const;

	/// Gets the Item needed for this research.
	const RuleItem* getNeededItem() const { return _neededItem; }
	/// Checks if this ResearchProject needs a corresponding Item to be researched.
	bool needItem() const;
	/// Checks if this ResearchProject consumes the corresponding Item when research completes.
	bool destroyItem() const;
	/// Checks if this ResearchProject returns the corresponding Item when research completes.
	bool returnItem() const;
	/// Checks if this ResearchProject hold reserched item during research.
	bool isHoldingNeededItem() const;

#if 0
	/// Check if this ResearchProject is unlocking final mission, it can be only one!
	bool unlockFinalMission() const { return _unlockFinalMission; }
	/// Check if this ResearchProject is repeatable, i.e. is never marked as discovered.
	bool isRepeatable() const { return _repeatable; }
	/// Gets the list of ResearchProjects unlocked by this research.
	const std::vector<const RuleResearch*> &getUnlocked() const;
	/// Gets the list of ResearchProjects disabled by this research.
	const std::vector<const RuleResearch*> &getDisabled() const;
	/// Gets the list of ResearchProjects reenabled by this research.
	const std::vector<const RuleResearch*> &getReenabled() const;
	/// Gets the points earned for discovering this ResearchProject.
	int getPoints() const;
	/// Gets the list of ResearchProjects granted at random for free by this research.
	const std::vector<const RuleResearch*> &getGetOneFree() const;
	/// Gets the list(s) of ResearchProjects granted at random for free by this research (if a defined prerequisite is met).
	const std::vector<std::pair<const RuleResearch*, std::vector<const RuleResearch*> > > &getGetOneFreeProtected() const;
	/// Gets what to look up in the ufopedia.
	const RuleResearch* getLookup() const { return _lookup; }
	/// Gets the requirements for this ResearchProject.
	const std::vector<const RuleResearch*> &getRequirements() const;
	/// Gets the base requirements for this ResearchProject.
	RuleBaseFacilityFunctions getRequireBaseFunc() const { return _requiresBaseFunc; }
	/// Gets the list weight for this research item.
	int getListOrder() const;
	/// Gets the cutscene to play when this item is researched
	const std::string & getCutscene() const;
	/// Gets the item to spawn in the base stores when this topic is researched.
	const std::string & getSpawnedItem() const;
	/// Gets the number of items to spawn in the base stores when this topic is researched.
	int getSpawnedItemCount() const { return _spawnedItemCount; }
	/// Gets the list of items to spawn in the base stores when this topic is researched.
	const std::vector<std::string>& getSpawnedItemList() const { return _spawnedItemList; }
	/// Gets the geoscape event to spawn when this topic is researched.
	const std::string& getSpawnedEvent() const { return _spawnedEvent; }
	/// Gets the name of custom counter variables to decrease when this topic is researched.
	const std::vector<std::string>& getDecreaseCounter() const { return _decreaseCounter; }
	/// Gets the name of custom counter variables to increase when this topic is researched.
	const std::vector<std::string>& getIncreaseCounter() const { return _increaseCounter; }
	/// Gets geoscape event rule name to spawn after (each) research completion
	std::string chooseEvent() const { return _events.choose(); }
	const WeightedOptions& getEventsRaw() const { return _events; }
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleResearch@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleResearch);

}  /* end of namespace OpenXcom */

