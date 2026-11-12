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
%echo "Processing Font.i"

struct SDL_Color;
#endif


namespace OpenXcom
{

class Font
{
public:
	/// Default palette for terminal text.
	static const SDL_Color TerminalColors[2];


	/// Creates a blank font.
	Font();
	/// Cleans up the font.
	~Font();

#if 0
	/// Loads the font from YAML.
	void load(const YAML::YamlNodeReader& reader);
#endif

	/// Generate the terminal font.
	void loadTerminal();

#if 0
	/// Gets a particular character from the font, with its real size.
	SurfaceCrop getChar(UCode c) const;
#endif
	/// Gets the font's character width.
	int getWidth() const;
	/// Gets the font's character height.
	int getHeight() const;
	/// Gets the spacing between characters.
	int getSpacing() const;

#if 0
	/// Gets the size of a particular character;
	SDL_Rect getCharSize(UCode c) const;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Font@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Font);

}  /* end of namespace OpenXcom */

