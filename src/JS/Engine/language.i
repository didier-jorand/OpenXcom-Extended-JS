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
%echo "Processing Language.i"
#endif

namespace OpenXcom
{
enum TextDirection { DIRECTION_LTR, DIRECTION_RTL };
enum TextWrapping { WRAP_AUTO, WRAP_WORDS, WRAP_LETTERS };

enum SoldierGender : char;

class Language
{
public:
	static bool isSupported(const std::string& lang);

	LocalizedText getString(const std::string &id) const;
	LocalizedText getString(const std::string &id, unsigned n) const;
	LocalizedText getString(const std::string &id, SoldierGender gender) const;
	TextDirection getTextDirection() const;
	TextWrapping getTextWrapping() const;
};

JSConvertPtr(Language);

} // End of namespace OpenXcom

