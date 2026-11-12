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
%echo "Processing MovingTarget.i"
#endif

namespace OpenXcom
{

class MovingTarget
{
public:
	/// Gets the moving target's destination.
	Target *getDestination() const;
	/// Sets the moving target's destination.
	virtual void setDestination(Target *dest);

	/// Gets the moving target's speed.
	int getSpeed() const;
	/// Gets the moving target's radial speed.
	double getSpeedRadian() const;
	/// Sets the moving target's speed.
	void setSpeed(int speed);

	/// Has the moving target reached its destination?
	bool reachedDestination() const;

	/// Move towards the destination.
	void move();

	/// Calculate meeting point with the target.
	void calculateMeetPoint();
	/// Returns the latitude of the meeting point.
	double getMeetLatitude() const;
	/// Returns the longitude of the meeting point.
	double getMeetLongitude() const;
	/// Reset meeting point calculation.
	void resetMeetPoint();
	/// Returns if the meeting point was calculated.
	bool isMeetCalculated() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "MovingTarget(%s)@%p", self->getType().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(MovingTarget);

}  /* end of namespace OpenXcom */

