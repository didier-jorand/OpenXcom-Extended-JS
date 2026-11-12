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

#include "JSInteractiveSurface.h"
#include "../../Interface/ImageButton.h"

namespace OpenXcom
{

namespace JSUI
{

/**
 * JS Proxy class for Interface/ImageButton
 */
class JSImageButton : public ImageButton
{
public:
	/// Creates a new proxy for a text button with the specified size and position.
	JSImageButton(int width, int height, int x = 0, int y = 0, jsui_event_flag flags = JSUI_EVENT_ALL);
	/// Cleans up the text button proxy.
	~JSImageButton();

};

}

}
