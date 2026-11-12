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
%echo "Processing ProgressBar.i"
#endif

namespace OpenXcom
{

class ProgressBar : public Surface
{
public:

	/// Creates a new bar with the specified size and position.
	ProgressBar(int width, int height, int x = 0, int y = 0);
	/// Cleans up the bar.
	~ProgressBar();

	/// Sets the progress bar's color.
	void setColor(Uint8 color) override;
	/// Gets the progress bar's color.
	Uint8 getColor() const;

	/// Sets the outline color for the progress bar.
	void setBorderColor(Uint8 bc) override;

	/// Sets the progress bar's current value.
	void setValue(int value);
	/// Gets the progress bar's current value.
	int getValue() const;

#if 0
	/// Draws the progress bar.
	void draw() override;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "ProgressBar@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ProgressBar);

}  /* end of namespace OpenXcom */

