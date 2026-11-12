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
%echo "Processing Slider.i"
#endif

namespace OpenXcom
{

class Font;
class Language;
class State;

enum SliderHAlign { ALIGN_LEFT, ALIGN_CENTER, ALIGN_RIGHT };
enum SliderVAlign { ALIGN_TOP, ALIGN_MIDDLE, ALIGN_BOTTOM };


class Slider : public InteractiveSurface
{
public:

	/// Creates a new text with the specified size and position.
	Slider(int width, int height, int x = 0, int y = 0);
	/// Cleans up the text.
	~Slider();

	/// Sets the X position of the surface.
	void setX(int x) override;
	/// Sets the Y position of the surface.
	void setY(int y) override;

	/// Initializes the slider's resources.
	void initText(Font *big, Font *small, Language *lang) override;

	/// Sets the slider's high contrast color setting.
	void setHighContrast(bool contrast) override;
	/// Sets the slider's color.
	void setColor(Uint8 color) override;
	/// Gets the slider's color.
	Uint8 getColor() const;
	/// Sets the slider's palette.
	void setPalette(const SDL_Color *colors, int firstcolor = 0, int ncolors = 256) override;

	/// Sets the slider's range.
	void setRange(int min, int max);
	/// Sets the slider's value.
	void setValue(int value);
	/// Gets the slider's value.
	int getValue() const;

#if 0
	/// Blits the slider onto another surface.
	void blit(SDL_Surface *surface) override;
	/// Moves the slider.
	void handle(Action *action, State *state) override;
	/// Special handling for mouse presses.
	void mousePress(Action *action, State *state) override;
	/// Special handling for mouse releases.
	void mouseRelease(Action *action, State *state) override;
	/// Hooks an action handler to when the slider changes.
	void onChange(ActionHandler handler);
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Slider@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Slider);

}  /* end of namespace OpenXcom */

