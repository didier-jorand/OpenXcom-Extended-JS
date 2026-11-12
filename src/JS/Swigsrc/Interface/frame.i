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
%echo "Processing Frame.i"
#endif

namespace OpenXcom
{

class Frame : public Surface
{
public:

	/// Creates a new bar with the specified size and position.
	Frame(int width, int height, int x = 0, int y = 0);
	/// Cleans up the bar.
	~Frame();

	/// Sets the border color.
	void setColor(Uint8 color) override;
	/// Gets the border color.
	Uint8 getColor() const;

	void setBorderColor(Uint8 color) override;
	/// Sets the background color.
	void setSecondaryColor(Uint8 bg) override;
	/// Gets the background color.
	Uint8 getSecondaryColor() const;
	/// Sets the high contrast color setting.

	void setHighContrast(bool contrast) override;
	/// Sets the border thickness.

	void setThickness(int thickness);

#if 0
	/// Draws the frame.
	void draw() override;
#endif
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Frame@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Frame);

}  /* end of namespace OpenXcom */

