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
%echo "Processing BaseFacility.i"
#endif

namespace OpenXcom
{

class RuleBaseFacility;


class BaseFacility
{
public:
	/// Gets the facility's ruleset.
	const RuleBaseFacility *getRules() const;
	/// Gets the facility's X position.
	int getX() const;
	/// Sets the facility's X position.
	void setX(int x);
	/// Gets the facility's Y position.
	int getY() const;
	/// Sets the facility's Y position.
	void setY(int y);
#if 0
	/// Get placement of facility in base.
	BaseAreaSubset getPlacement() const;
#endif

	/// Gets the facility's construction time.
	int getBuildTime() const;
	/// Gets the facility's adjusted construction time (i.e. NOT considering upgrades/downgrades).
	int getAdjustedBuildTime() const;
	/// Sets the facility's construction time.
	void setBuildTime(int time);
	/// Builds up the facility.
	void build();
	/// Checks if the facility is currently in use.
	BasePlacementErrors inUse() const;

	/// Gets the facility's ammo count.
	int getAmmo() const { return _ammo; }
	/// Sets the facility's ammo count.
	void setAmmo(int ammo) { _ammo = ammo; }
	/// Resets the helper flag.
	void resetAmmoMissingReported() { _ammoMissingReported = false; }
	/// Rearms the facility.
	const RuleItem* rearm();

	/// Checks if the facility is disabled.
	bool getDisabled() const;
	/// Sets the facility's disabled flag.
	void setDisabled(bool disabled);
#if 0
	/// Gets craft, used for drawing facility.
	Craft *getCraftForDrawing() const;
	/// Sets craft, used for drawing facility.
	void setCraftForDrawing(Craft *craft);
#endif

	/// Gets whether this facility was placed over another or was placed by removing another
	bool getIfHadPreviousFacility() const;
	/// Sets whether this facility was placed over another or was placed by removing another
	void setIfHadPreviousFacility(bool hadPreviousFacility);
	/// Is the facility fully built or being upgraded/downgraded?
	bool isBuiltOrHadPreviousFacility() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "BaseFacility@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(BaseFacility);

}  /* end of namespace OpenXcom */

