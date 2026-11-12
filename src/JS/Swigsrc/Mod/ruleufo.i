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
%echo "Processing RuleUfo.i"
#endif

namespace OpenXcom
{

class RuleUfo
{
public:

	/// Gets the UFO's type.
	const std::string &getType() const;
	/// Gets the UFO's size.
	const std::string &getSize() const;
	/// Gets the UFO's radius.
	int getRadius() const;
	/// Gets the UFO's default visibility.
	int getDefaultVisibility() const;

#if 0
	/// Gets the UFO's blob size.
	int getBlobSize() const;
	/// Gets the UFO's sprite.
	int getSprite() const;
	/// Gets the UFO's globe marker when flying.
	int getMarker() const;
	/// Gets the UFO's globe marker when landed.
	int getLandMarker() const;
	/// Gets the UFO's globe marker when crashed.
	int getCrashMarker() const;
	/// Gets the UFO's weapon power.
	int getWeaponPower() const;
	/// Gets the UFO's weapon range.
	int getWeaponRange() const;
	/// Gets the UFO's score.
	int getScore() const;
	/// Sets the battlescape terrain data ruleset for this UFO
	RuleTerrain *getBattlescapeTerrainData() const;
	/// Gets the reload time of the UFO's weapon.
	int getWeaponReload() const;
	/// Gets the UFO's escape time.
	int getBreakOffTime() const;
	/// Gets the UFO's fire sound.
	int getFireSound() const;
	/// Gets the alert sound for this UFO (UFO detected alert).
	int getAlertSound() const;
	/// Gets the alert sound for this UFO (UFO on intercept course alert).
	int getHuntAlertSound() const;
	/// Gets the hit sound for this UFO (to be used in the BaseDestroyedState UI).
	int getHitSound() const { return _hitSound; }
	/// Gets the name of the surface that represents this UFO.
	const std::string &getModSprite() const;
	/// Gets the name of the surface to be displayed in the BaseDestroyedState UI.
	const std::string& getHitImage() const { return _hitImage; }
	/// Get basic statistic of UFO.
	const RuleUfoStats& getStats() const;
	/// Get race bonus of statistic of UFO.
	const RuleUfoStats& getRaceBonus(const std::string& s) const;
	const std::map<std::string, RuleUfoStats> &getRaceBonusRaw() const;
	/// Gets the UFO's mission score.
	int getMissionScore() const;
	/// Gets the UFO's chance to become a hunter-killer.
	int getHunterKillerPercentage() const;
	/// Gets the UFO's hunting preferences.
	int getHuntMode() const;
	/// Gets the UFO's hunting speed (in percent of maximum speed).
	int getHuntSpeed() const;
	/// Gets the UFO's hunting behavior (normal, kamikaze or random).
	int getHuntBehavior() const;
	/// Gets the amount of shots fired before a softlock is detected.
	int getSoftlockThreshold() const { return _softlockThreshold; }
	/// Gets the missile power (of a UFO that represents one or more missiles).
	int getMissilePower() const { return _missilePower; }
	/// Gets the chance to stop retaliation mission after a successful missile strike (default = 0).
	int getMissileStopChance() const { return _missileStopChance; }
	/// Is this an unmanned UFO (drone, missile, etc.)?
	bool isUnmanned() const { return _unmanned; }
	/// Show extra info during base defense even if the UFO was not yet hyper-detected classically?
	bool isInstaHyper() const { return _instaHyper; }
	/// Suppress UFO detection alerts?
	bool isNoAlert() const { return _noAlert; }
	/// Gets the chance of surviving a splashdown on fake water.
	int getSplashdownSurvivalChance() const { return _splashdownSurvivalChance; }
	/// Gets the chance for deciding to land on fake water texture.
	int getFakeWaterLandingChance() const { return _fakeWaterLandingChance; }
#endif /* 0 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleUfo@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleUfo);

}  /* end of namespace OpenXcom */

