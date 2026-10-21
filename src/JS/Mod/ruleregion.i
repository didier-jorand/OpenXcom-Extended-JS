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
%echo "Processing RuleRegion.i"
#endif

namespace OpenXcom
{

class RuleRegion
{
public:
	/// Gets the region's type.
	const std::string& getType() const;
	/// Gets the region's base cost.
	int getBaseCost() const;
	/// Checks if a point is inside the region.
	bool insideRegion(double lon, double lat, bool ignoreTechnicalRegion = false) const;
#if 0
	/// Gets the cities in this region.
	std::vector<City*> *getCities();
	/// Gets the weight of this region for mission selection.
	size_t getWeight() const;
	/// Gets the weighted list of missions for this region.
	const WeightedOptions &getAvailableMissions() const { return _missionWeights; }
	/// Gets the substitute mission region.
	const std::string &getMissionRegion() const { return _missionRegion; }
	/// Gets a random point inside a mission zone.
	std::pair<double, double> getRandomPoint(size_t zone, int area = -1) const;
	/// Gets the maximum longitude.
	const std::vector<double> &getLonMax() const { return _lonMax; }
	/// Gets the minimum longitude.
	const std::vector<double> &getLonMin() const { return _lonMin; }
	/// Gets the maximum latitude.
	const std::vector<double> &getLatMax() const { return _latMax; }
	/// Gets the minimum latitude.
	const std::vector<double> &getLatMin() const { return _latMin; }
	/// Gets a list of MissionZones.
	const std::vector<MissionZone> &getMissionZones() const;
	/// Gets the functions provided by the region.
	RuleBaseFacilityFunctions getProvidedBaseFunc() const { return _provideBaseFunc; }
	/// Gets the functions forbidden by the region.
	RuleBaseFacilityFunctions getForbiddenBaseFunc() const { return _forbiddenBaseFunc; }
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleRegion@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleRegion);

}  /* end of namespace OpenXcom */

