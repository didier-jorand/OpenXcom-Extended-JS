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
%echo "Processing ScrollBar.i"
#endif

namespace OpenXcom
{

class TextList;


class ScrollBar : public InteractiveSurface
{
public:
#if 0
	// InteractiveSurface: to create a ScrollBar, use JSScrollBar
	/// Creates a new text button with the specified size and position. => see JSScrollBar
	ScrollBar(int width, int height, int x = 0, int y = 0);
	/// Cleans up the text button.
	~ScrollBar();
#endif

	/// Sets the X position of the surface.
	void setX(int x) override;
	/// Sets the Y position of the surface.
	void setY(int y) override;

	/// Sets the height of the surface.
	void setHeight(int height) override;
	/// Sets the scrollbar's color.

	void setColor(Uint8 color) override;
	/// Gets the scrollbar's color.
	Uint8 getColor() const;
	/// Sets the scrollbar's high contrast color setting.
	void setHighContrast(bool contrast) override;

	/// Sets the scrollbar's list.
	void setTextList(TextList *list);

	/// Sets the background for the track.
	void setBackground(Surface *bg);

	/// Sets the scrollbar's palette.
	void setPalette(const SDL_Color *colors, int firstcolor = 0, int ncolors = 256) override;

#if 0
	/// Blits the scrollbar onto another surface.
	void blit(SDL_Surface *surface) override;
	/// Moves the scrollbar.
	void handle(Action *action, State *state) override;
	/// Special handling for mouse presses.
	void mousePress(Action *action, State *state) override;
	/// Special handling for mouse releases.
	void mouseRelease(Action *action, State *state) override;
	/// Draws the scrollbar contents.
	void draw() override;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "ScrollBar@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ScrollBar);

}  /* end of namespace OpenXcom */

