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
%echo "Processing Window.i"
#endif

namespace OpenXcom
{
class Timer;
class State;
class Sound;

/**
 * Enumeration for the type of animation when a window pops up.
 */
enum WindowPopup { POPUP_NONE, POPUP_HORIZONTAL, POPUP_VERTICAL, POPUP_BOTH };


class Window : public Surface
{
public:
	/// Creates a new window with the specified size and position.
	Window(State *state, int width, int height, int x = 0, int y = 0, WindowPopup popup = POPUP_NONE);
	/// Cleans up the window.
	~Window();

	/// Sets the background surface.
	void setBackground(const Surface *bg);

	/// Sets the border color.
	void setColor(Uint8 color) override;
	/// Gets the border color.
	Uint8 getColor() const;

	/// Sets the high contrast color setting.
	void setHighContrast(bool contrast) override;

	/// Handles the timers.
	void think() override;

	/// Popups the window.
	void popup();
	/// Draws the window.
	void draw() override;

	/// sets the X delta.
	void setDX(int dx);
	/// sets the Y delta.
	void setDY(int dy);
	/// Give this window a thin border.
	void setThinBorder();
	/// Give this window a custom inner color.
	void setInnerColor(Uint8 innerColor);
	/// Mute the window.
	void mute();


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Window@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Window);

}  /* end of namespace OpenXcom */

