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
%echo "Processing CraftWeapon.i"
#endif

namespace OpenXcom
{
class RuleCraftWeapon;

class CraftWeapon
{
public:

	/// Gets the craft weapon's ruleset.
	RuleCraftWeapon *getRules() const;

	/// Gets the craft weapon's ammo.
	int getAmmo() const;
	/// Sets the craft weapon's ammo.
	bool setAmmo(int ammo);

	/// Gets the craft weapon's rearming status.
	bool isRearming() const;
	/// Sets the craft weapon's rearming status
	void setRearming(bool rearming);

	/// Is the weapon disabled?
	bool isDisabled() const;
	/// Sets whether the weapon is disabled or not.
	void setDisabled(bool disabled);

	/// Rearms the craft weapon.
	int rearm(const int available, const int clipSize);
	/// Fires the craft weapon. Used during dogfights.
	// CraftWeaponProjectile* fire() const;
	/// get how many clips are loaded into this weapon.
	int getClipsLoaded() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		const OpenXcom::RuleCraftWeapon *r = self->getRules();
		snprintf(buffer, 128, "CraftWeapon(%s)@%p", r->getType().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(CraftWeapon);

}  /* end of namespace OpenXcom */

