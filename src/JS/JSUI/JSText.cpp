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

#include "JSState.h"
#include "JSText.h"


namespace OpenXcom
{

namespace JSUI
{
JSText::JSText(int width, int height, int x, int y, jsui_event_flag flags) : Text(width, height, x, y)
{
	if(flags & JSUI_EVENT_MOUSE_CLICK)
		onMouseClick((ActionHandler)&JSState::mouseClick);
	if(flags & JSUI_EVENT_MOUSE_PRESS)
		onMousePress((ActionHandler)&JSState::mousePress);
	if(flags & JSUI_EVENT_MOUSE_RELEASE)
		onMouseRelease((ActionHandler)&JSState::mouseRelease);
	if(flags & JSUI_EVENT_MOUSE_IN)
		onMouseIn((ActionHandler)&JSState::mouseIn);
	if(flags & JSUI_EVENT_MOUSE_OVER)
		onMouseOver((ActionHandler)&JSState::mouseOver);
	if(flags & JSUI_EVENT_MOUSE_OUT)
		onMouseOut((ActionHandler)&JSState::mouseOut);
	if(flags & JSUI_EVENT_KEY_PRESS)
		onKeyboardPress((ActionHandler)&JSState::keyboardPress);
	if(flags & JSUI_EVENT_KEY_RELEASE)
		onKeyboardRelease((ActionHandler)&JSState::keyboardRelease);
}

JSText::~JSText()
{
}


}

}
