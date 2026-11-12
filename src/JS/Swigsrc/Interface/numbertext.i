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
%echo "Processing NumberText.i"
#endif

namespace OpenXcom
{

class NumberText : public Surface
{
public:

	/// Creates a new number text with the specified size and position.
	NumberText(int width, int height, int x = 0, int y = 0);
	/// Cleans up the number text.
	~NumberText();

	/// Sets the number text's value.
	void setValue(unsigned int value);
	/// Gets the number text's value.
	unsigned int getValue() const;

	/// Sets the number text's color.
	void setColor(Uint8 color) override;
	/// Gets the number text's color.
	Uint8 getColor() const;

	/// Sets the number text's palette.
	void setPalette(const SDL_Color *colors, int firstcolor = 0, int ncolors = 256) override;

#if 0
	/// Draws the number text.
	void draw() override;
#endif

	/// sets this numbertext to have a border or not
	void setBordered(bool bordered);


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "NumberText@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(NumberText);

}  /* end of namespace OpenXcom */

