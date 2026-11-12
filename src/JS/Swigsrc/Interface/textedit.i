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
%echo "Processing TextEdit.i"
#endif

namespace OpenXcom
{

class State;
class Timer;

enum TextEditConstraint { TEC_NONE, TEC_NUMERIC_POSITIVE, TEC_NUMERIC };


class TextEdit : public InteractiveSurface
{
public:

#if 0
	// InteractiveSurface: to create a TextEdit, use JSTextEdit
	/// Creates a new text with the specified size and position.
	TextEdit(State *state, int width, int height, int x = 0, int y = 0);
	/// Cleans up the text.
	~TextEdit();

	/// Handle focus.
	void handle(Action *action, State *state) override;
#endif

	/// Sets focus on this text edit.
	void setFocus(bool focus, bool modal = true) override;

	/// Sets the text size to big.
	void setBig();
	/// Sets the text size to small.
	void setSmall();

	/// Initializes the text edit's resources.
	void initText(Font *big, Font *small, Language *lang) override;
	/// Sets the text's string.
	void setText(const std::string &text);
	/// Gets the text edit's string.
	std::string getText() const;

	/// Sets the text edit's wordwrap setting.
	void setWordWrap(bool wrap);
	/// Sets the text edit's color invert setting.
	void setInvert(bool invert);
	/// Sets the text edit's high contrast color setting.
	void setHighContrast(bool contrast) override;
	/// Sets the text edit's horizontal alignment.
	void setAlign(TextHAlign align);
	/// Sets the text edit's vertical alignment.
	void setVerticalAlign(TextVAlign valign);
	/// Sets the text edit constraint.
	void setConstraint(TextEditConstraint constraint);
	/// Sets the text edit's color.
	void setColor(Uint8 color) override;
	/// Gets the text edit's color.
	Uint8 getColor() const;
	/// Sets the text edit's secondary color.
	void setSecondaryColor(Uint8 color) override;
	/// Gets the text edit's secondary color.
	Uint8 getSecondaryColor() const;
	/// Sets the text edit's palette.
	void setPalette(const SDL_Color *colors, int firstcolor = 0, int ncolors = 256) override;

#if 0
	/// Handles the timers.
	void think() override;
#endif

	/// Plays the blinking animation.
	void blink();
	/// Draws the text edit.
	void draw() override;

#if 0
	/// Special handling for mouse presses.
	void mousePress(Action *action, State *state) override;
	/// Special handling for keyboard presses.
	void keyboardPress(Action *action, State *state) override;
	/// Hooks an action handler to when the text changes.
	void onChange(ActionHandler handler);
	/// Sets a function to be called every time ENTER is pressed.
	void onEnter(ActionHandler handler);
#endif

	/// Sets the text edit's background drawing setting.
	void setDrawBackground(bool drawBackground) { _drawBackground = drawBackground; }


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "TextEdit@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(TextEdit);

}  /* end of namespace OpenXcom */

