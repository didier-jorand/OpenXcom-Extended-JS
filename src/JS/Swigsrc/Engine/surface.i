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
%echo "Processing Surface.i"
#endif

namespace OpenXcom
{

class Surface
{
public:

	/// Sets the X position of the surface.
	virtual void setX(int x);
	/// Gets the X position of the surface.
	int getX() const;
	/// Sets the Y position of the surface.
	virtual void setY(int y);
	/// Gets the Y position of the surface.
	int getY() const;
	/// Sets the surface's visibility.
	virtual void setVisible(bool visible);
	/// Gets the surface's visibility.
	bool getVisible() const;


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Surface@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Surface);

}  /* end of namespace OpenXcom */

