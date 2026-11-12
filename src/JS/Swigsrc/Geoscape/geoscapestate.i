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
%echo "Processing GeoscapeState.i"

%{
#include "Mod/RuleInterface.h"
#include "Menu/ErrorMessageState.h"
%}
#endif


namespace OpenXcom
{


class GeoscapeState : public State
{
public:

	void timerReset();
	void popup(State *state);


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "GeoscapeState@%p", self);
		return strdup(buffer);
	}

	/// JS Extension
	void errorMessage(const std::string& message) {
		extern OpenXcom::Game *game;
		self->popup(new OpenXcom::ErrorMessageState(message,
			self->getPalette(),
			game->getMod()->getInterface("geoscape")->getElement("errorMessage")->color,
			"BACK13.SCR",
			game->getMod()->getInterface("geoscape")->getElement("errorPalette")->color));

	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(GeoscapeState);

} /* end of namespace OpenXcom */
