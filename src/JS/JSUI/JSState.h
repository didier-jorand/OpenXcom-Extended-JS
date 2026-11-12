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

#include <map>

#include "../../Engine/Action.h"
#include "../../Engine/InteractiveSurface.h"
#include "../../Engine/State.h"
#include "../JSEngine/OXCEQJSEngine.h"

namespace OpenXcom
{
class Surface;

namespace JSUI
{


class JSState : public State
{
protected:
	JSValue _self;

	std::map<const Surface*, JSValue> _widget_map;

	void forward(Action *action, const std::string& handler_name);

public:
	JSState();
	~JSState();

	/// Add a widget and register it in widget map
	void add(JSValue jssurface, Surface *surface);
	void add(JSValue jssurface, Surface *surface, const std::string &id, const std::string &category, Surface *parent = 0);

	/// Event handler: mouseClick
	void mouseClick(Action *action);
	/// Event handler: mousePress
	void mousePress(Action *action);
	/// Event handler: mouseRelease
	void mouseRelease(Action *action);
	/// Event handler: mouseIn
	void mouseIn(Action *action);
	/// Event handler: mouseOver
	void mouseOver(Action *action);
	/// Event handler: mouseOut
	void mouseOut(Action *action);
	/// Event handler: keyboardPress
	void keyboardPress(Action *action);
	/// Event handler: keyboardRelease
	void keyboardRelease(Action *action);
	/// Event handler: change
	void change(Action *action);

};

}

}
