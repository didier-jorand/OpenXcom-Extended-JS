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
%echo "Processing RuleCountry.i"
#endif

namespace OpenXcom
{


class RuleCountry
{
public:
	/// Gets the country's type.
	const std::string& getType() const;
	/// Gets the event triggered after the country leaves Xcom.
	const RuleEvent* getSignedPactEvent() const { return _signedPactEvent; }
	/// Gets the event triggered after the country rejoins Xcom.
	const RuleEvent* getRejoinedXcomEvent() const { return _rejoinedXcomEvent; }
	/// Generates the country's starting funding.
	int generateFunding() const;
	/// Gets the country's funding cap.
	int getFundingCap() const;
	/// Gets the country's label X position.
	double getLabelLongitude() const;
	/// Gets the country's label Y position.
	double getLabelLatitude() const;
	/// Checks if a point is inside the country.
	bool insideCountry(double lon, double lat) const;
	const std::vector<double> &getLonMax() const { return _lonMax; }
	const std::vector<double> &getLonMin() const { return _lonMin; }
	const std::vector<double> &getLatMax() const { return _latMax; }
	const std::vector<double> &getLatMin() const { return _latMin; }
	/// Gets the country's label color.
	int getLabelColor() const;
	/// Gets the minimum zoom level required to display the label (Note: works for extraGlobeLabels only, not for vanilla countries).
	int getZoomLevel() const;
#if 0
	// XXX needs RuleBaseFacilityFunctions
	/// Gets the functions provided by the country.
	RuleBaseFacilityFunctions getProvidedBaseFunc() const { return _provideBaseFunc; }
	/// Gets the functions forbidden by the coutry.
	RuleBaseFacilityFunctions getForbiddenBaseFunc() const { return _forbiddenBaseFunc; }
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleCountry@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleCountry);

}  /* end of namespace OpenXcom */

