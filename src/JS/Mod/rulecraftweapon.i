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
%echo "Processing RuleCraftWeapon.i"
#endif

namespace OpenXcom
{

// TEMP, from CraftWeaponProjectile XXX
enum CraftWeaponProjectileType { CWPT_STINGRAY_MISSILE, CWPT_AVALANCHE_MISSILE, CWPT_CANNON_ROUND, CWPT_FUSION_BALL, CWPT_LASER_BEAM, CWPT_PLASMA_BEAM };
enum CraftWeaponProjectileGlobalType { CWPGT_MISSILE, CWPGT_BEAM };

class RuleCraftWeapon
{
public:

	/// Gets the craft weapon's type.
	const std::string& getType() const;
	/// Gets the craft weapon's tooltip.
	const std::string& getTooltip() const;

#if 0
	/// Gets the craft weapon's sprite.
	int getSprite() const;
	/// Gets the craft weapon's sound.
	int getSound() const;
#endif

	/// Gets the craft weapon's damage.
	int getDamage() const;

#if 0
	/// Should the weapon's stats be displayed in Ufopedia or not?
	bool getHidePediaInfo() const { return _hidePediaInfo; }
	/// Should the statistical bullet saving be used or not?
	bool useStatisticalBulletSaving() const { return _statisticalBulletSaving; }
	/// Should unified or vanilla formula be used?
	bool unifiedDamageFormula() const { return _unifiedDamageFormula; }
	/// Gets the craft weapon's effectiveness against shields.
	int getShieldDamageModifier() const;
#endif
	/// Gets the craft weapon's range.
	int getRange() const;
	/// Gets the craft weapon's accuracy.
	int getAccuracy() const;
	/// Gets the craft weapon's cautious reload time.
	int getCautiousReload() const;
	/// Gets the craft weapon's standard reload time.
	int getStandardReload() const;
	/// Gets the craft weapon's aggressive reload time.
	int getAggressiveReload() const;
	/// Gets the craft weapon's maximum ammo.
	int getAmmoMax() const;
	/// Gets the craft weapon's rearm rate.
	int getRearmRate() const;
	/// Gets the craft weapon's launcher item.
	const RuleItem* getLauncherItem() const;
	/// Gets the craft weapon's clip item.
	const RuleItem* getClipItem() const;
	/// Gets the craft weapon's projectile's type.
	CraftWeaponProjectileType getProjectileType() const;
	/// Gets the craft weapon's projectile speed.
	int getProjectileSpeed() const;
	/// Gets weapon type used by craft slots.
	int getWeaponType() const;

#if 0
	/// Gets bonus stats given by this weapon.
	const RuleCraftStats& getBonusStats() const;
	/// Is this item restricted to use underwater?
	bool isWaterOnly() const;
	/// Get the craft weapon's tractor beam power
	int getTractorBeamPower() const;
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleCraftWeapon(%s)@%p", self->getType().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleCraftWeapon);

}  /* end of namespace OpenXcom */

