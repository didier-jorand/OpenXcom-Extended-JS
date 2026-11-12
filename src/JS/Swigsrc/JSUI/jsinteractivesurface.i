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
%echo "Processing JSInteractiveSurface.i"
#endif

%{
#include "JS/JSUI/JSInteractiveSurface.h"
%}


namespace OpenXcom
{

namespace JSUI
{

enum jsui_event_flag {
JSUI_EVENT_NONE = 0,
JSUI_EVENT_ALL = 0xFF,
JSUI_EVENT_MOUSE_CLICK = (1 << 0),
JSUI_EVENT_MOUSE_PRESS = (1 << 1),
JSUI_EVENT_MOUSE_RELEASE = (1 << 2),
JSUI_EVENT_MOUSE_IN = (1 << 3),
JSUI_EVENT_MOUSE_OVER = (1 << 4),
JSUI_EVENT_MOUSE_OUT = (1 << 5),
JSUI_EVENT_KEY_PRESS = (1 << 6),
JSUI_EVENT_KEY_RELEASE = (1 << 7),
JSUI_EVENT_CHANGE = (1 << 8),
};

class JSInteractiveSurface : public OpenXcom::InteractiveSurface
{
public:
	JSInteractiveSurface(int width, int height, int x = 0, int y = 0, jsui_event_flag flags = JSUI_EVENT_ALL);
	~JSInteractiveSurface();


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "JSInteractiveSurface@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

}  /* end of namespase JSUI */

}  /* end of namespace OpenXcom */

