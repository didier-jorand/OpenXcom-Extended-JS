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
%echo "Processing RuleManufacture.i"
#endif

namespace OpenXcom
{
class RuleItem;

enum ManufacturingFilterType
{
	MANU_FILTER_DEFAULT,
	MANU_FILTER_DEFAULT_SUPPLIES_OK,
	MANU_FILTER_DEFAULT_NO_SUPPLIES,
	MANU_FILTER_FACILITY_REQUIRED,
	MANU_FILTER_HIDDEN
};

class RuleManufacture
{
public:
	static const int MANU_STATUS_NEW = 0;
	static const int MANU_STATUS_NORMAL = 1;
	static const int MANU_STATUS_HIDDEN = 2;
	static const int MANU_STATUSES = 3;

	/// Gets the manufacture name.
	const std::string &getName() const;
	/// Gets the manufacture category.
	const std::string &getCategory() const;
	/// Gets the manufacture's requirements.
	const std::vector<const RuleResearch*> &getRequirements() const;
#if 0
	/// Gets the base requirements.
	RuleBaseFacilityFunctions getRequireBaseFunc() const { return _requiresBaseFunc; }
#endif
	/// Gets the required workshop space.
	int getRequiredSpace() const;
	/// Gets the time required to manufacture one object.
	int getManufactureTime() const;
	/// Gets the cost of manufacturing one object.
	int getManufactureCost() const;

	/// Checks if there's enough funds to manufacture one object.
	bool haveEnoughMoneyForOneMoreUnit(int64_t funds) const;

	/// Gets the points earned for manufacturing one production object.
	int getPoints() const;
	/// Should all resources of a cancelled project be refunded?
	bool getRefund() const;

	/// Gets the list of items required to manufacture one object.
	const std::map<const RuleItem*, int> &getRequiredItems() const;
	/// Gets the list of crafts required to manufacture one object.
	const std::map<const RuleCraft*, int> &getRequiredCrafts() const;
	/// Gets the list of items produced by completing "one object" of this project.
	/// by default: it contains only the "name" item with a value of 1.
	const std::map<const RuleItem*, int> &getProducedItems() const;
	/// If this produce craft return its type, otherwise null.
	const RuleCraft* getProducedCraft() const;
	/// Gets the random manufacture rules.
	const std::vector<std::pair<int, std::map<const RuleItem*, int> > > &getRandomProducedItems() const;

	/// Gets the "manufactured person", i.e. person spawned when manufacturing project ends.
	const std::string &getSpawnedPersonType() const;
	/// Gets the custom name of the "manufactured person".
	const std::string &getSpawnedPersonName() const;
#if 0
	/// Gets the spawned soldier template.
	const YAML::YamlString& getSpawnedSoldierTemplate() const;
#endif

	/// Is it possible to use auto-sell feature for this manufacturing project?
	bool canAutoSell() const;
	/// Gets the transfer time info.
	const std::vector<int>& getTransferTimes() const;

#if 0
	/// Gets geoscape event rule name to spawn after (each) item production
	std::string chooseEvent() const;
	const WeightedOptions& getEventsRaw() const { return _events; }
	/// Gets the list weight for this manufacture item.
	int getListOrder() const;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleManufacture@%p", self);
		return strdup(buffer);
	}

	bool isItemProduced(const const OpenXcom::RuleItem *r) const {
		const std::map<const OpenXcom::RuleItem*, int> pi = self->getProducedItems();
		return (pi.find(r) != pi.end());
	}

#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleManufacture);

}  /* end of namespace OpenXcom */

