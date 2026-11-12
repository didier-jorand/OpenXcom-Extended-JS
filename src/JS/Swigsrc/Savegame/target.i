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
%echo "Processing Target.i"
#endif

namespace OpenXcom
{

class Target
{
public:

	/// Gets the target's type.
	virtual std::string getType() const = 0;

	/// Gets the target's longitude.
	double getLongitude() const;
	/// Sets the target's longitude.
	void setLongitude(double lon);
	/// Gets the target's latitude.
	double getLatitude() const;
	/// Sets the target's latitude.
	void setLatitude(double lat);

	/// Gets the target's ID.
	int getId() const;
	/// Sets the target's ID.
	void setId(int id);

	/// Gets the target's name.
	virtual std::string getName(Language *lang) const;
	/// Sets the target's name.
	void setName(const std::string &newName);
	/// Gets the target's default name.
	virtual std::string getDefaultName(Language *lang) const;

	/// Gets the target's marker name.
	virtual std::string getMarkerName() const;
	/// Gets the target's marker ID.
	virtual int getMarkerId() const;
#if 0
	/// Gets the target's marker sprite.
	virtual int getMarker() const = 0;
#endif

#if 0
	/// Gets the target's followers.
	std::vector<MovingTarget*> *getFollowers();
	/// Gets the target's craft followers.
	std::vector<Craft*> getCraftFollowers() const;
	/// Gets the target's UFO followers.
	std::vector<Ufo*> getUfoFollowers() const;
#endif

	/// Gets the distance to another target.
	double getDistance(const Target *target) const { return getDistance(target->getLongitude(), target->getLatitude()); }
	/// Gets the distance to another position.
	double getDistance(double lon, double lat) const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Target(%s)@%p", self->getType().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Target);

}  /* end of namespace OpenXcom */

