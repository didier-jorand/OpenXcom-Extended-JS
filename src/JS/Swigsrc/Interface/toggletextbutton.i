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
%echo "Processing TextButton.i"
#endif

namespace OpenXcom
{

class ToggleTextButton : public TextButton
{
public:
#if 0
	// InteractiveSurface: to create a ToggleTextButton, use JSToggleTextButton
	/// Creates a new toggle text button with the specified size and position. => see JSToggleTextButton
	ToggleTextButton(int width, int height, int x, int y);
	TextButton(int width, int height, int x = 0, int y = 0);
	/// Cleans up the toggle text button.
	~ToggleTextButton(void);
#endif

#if 0
	void draw() override;
	void mousePress(Action *action, State *state) override;
#endif

	/// Set the pressed status
	void setPressed(bool pressed);
	bool getPressed() const { return _isPressed; }

	/// Sets the text button's color.
	void setColor(Uint8 color) override;
	/// Sets the text button's color when pressed.
	void setInvertColor(Uint8 color);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "ToggleTextButton@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ToggleTextButton);

}  /* end of namespace OpenXcom */

