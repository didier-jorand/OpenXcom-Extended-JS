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
%echo "Processing ArrowButton.i"
#endif

namespace OpenXcom
{
enum ArrowShape { ARROW_NONE, ARROW_BIG_UP, ARROW_BIG_DOWN, ARROW_SMALL_UP, ARROW_SMALL_DOWN, ARROW_SMALL_LEFT, ARROW_SMALL_RIGHT };

class TextList;
class Timer;

class ArrowButton : public ImageButton
{
public:
	/// Creates a new arrow button with the specified size and position.
	ArrowButton(ArrowShape shape, int width, int height, int x = 0, int y = 0);
	/// Cleans up the arrow button.
	~ArrowButton();

	/// Sets the arrow button's color.
	void setColor(Uint8 color) override;

	/// Sets the arrow button's shape.
	void setShape(ArrowShape shape);

	/// Sets the arrow button's list.
	void setTextList(TextList *list);

#if 0
	/// Handles the timers.
	void think() override;
#endif

	/// Scrolls the list.
	void scroll();
	/// Draws the arrow button.
	void draw() override;

#if 0
	/// Special handling for mouse presses.
	void mousePress(Action *action, State *state) override;
	/// Special handling for mouse releases.
	void mouseRelease(Action *action, State *state) override;
	/// Special handling for mouse clicks.
	void mouseClick(Action *action, State *state) override;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "ArrowButton@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ArrowButton);

}  /* end of namespace OpenXcom */

