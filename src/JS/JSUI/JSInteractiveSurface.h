#pragma once
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenXcom.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "../../Engine/InteractiveSurface.h"
#include "JSSurface.h"

namespace OpenXcom
{

namespace JSUI
{

/// Flags to define what events should be transmitted to the JS instance
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

/**
 * JS Proxy class for Engine/InteractiveSurface
 */
class JSInteractiveSurface : public InteractiveSurface
{
protected:

public:
	/// Creates a new proxy for an interactive surface with the specified size and position.
	JSInteractiveSurface(int width, int height, int x = 0, int y = 0, jsui_event_flag flags = JSUI_EVENT_ALL);
	/// Cleans up the interactive surface proxy.
	virtual ~JSInteractiveSurface();

};

}

}
