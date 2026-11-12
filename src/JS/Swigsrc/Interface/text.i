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
%echo "Processing Text.i"
#endif

namespace OpenXcom
{

class Font;
class Language;
class State;

enum TextHAlign { ALIGN_LEFT, ALIGN_CENTER, ALIGN_RIGHT };
enum TextVAlign { ALIGN_TOP, ALIGN_MIDDLE, ALIGN_BOTTOM };


class Text : public InteractiveSurface
{
public:

	/// Creates a new text with the specified size and position.
	Text(int width, int height, int x = 0, int y = 0);
	/// Cleans up the text.
	~Text();

	/// Sets the text size to big.
	void setBig();
	/// Sets the text size to small.
	void setSmall();

	/// Gets the text's current font.
	Font *getFont() const;

	/// Initializes the resources for the text.
	void initText(Font *big, Font *small, Language *lang) override;
	/// Sets the text's string.
	void setText(const std::string &text);
	/// Gets the text's string.
	std::string getText() const;
	/// Sets the text's wordwrap setting.
	void setWordWrap(bool wrap, bool indent = false, bool ignoreSeparators = false);
	/// Sets the text's color invert setting.
	void setInvert(bool invert);
	/// Sets the text's high contrast color setting.
	void setHighContrast(bool contrast) override;
	/// Sets the text's horizontal alignment.
	void setAlign(TextHAlign align);
	/// Gets the text's horizontal alignment.
	TextHAlign getAlign() const;
	/// Sets the text's vertical alignment.
	void setVerticalAlign(TextVAlign valign);
	/// Gets the text's vertical alignment.
	TextVAlign getVerticalAlign() const;
	/// Sets the text's color.
	void setColor(Uint8 color) override;
	/// Gets the text's color.
	Uint8 getColor() const;
	/// Sets the text's secondary color.
	void setSecondaryColor(Uint8 color) override;
	/// Gets the text's secondary color.
	Uint8 getSecondaryColor() const;
	/// Gets the number of lines in the (wrapped, if wrapping is enabled) text
	int getNumLines() const;
	/// Gets the rendered text's width.
	int getTextWidth(int line = -1) const;
	/// Gets the rendered text's height.
	int getTextHeight(int line = -1) const;

	/// Draws the text.
	void draw() override;

	/// Sets the text's scrollable setting.
	void setScrollable(bool scroll);

#if 0
	/// Special handling for mouse presses.
	void mousePress(Action* action, State* state) override;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Text@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Text);

}  /* end of namespace OpenXcom */

