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
%echo "Processing State.i"
#endif

struct SDL_Color;

namespace OpenXcom
{

class State
{
public:

	SDL_Color *getPalette();

	/// Get the localized text.
	LocalizedText tr(const std::string &id) const;
	/// Get the localized text.
	LocalizedText trAlt(const std::string &id, int alt) const;
	/// Get the localized text.
	LocalizedText tr(const std::string &id, unsigned n) const;
	///Get the localized text.
	//LocalizedText tr(const std::string &id, SoldierGender gender) const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "State@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(State);

}  /* end of namespace OpenXcom */

