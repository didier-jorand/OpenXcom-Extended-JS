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
#include "JSInteractiveSurface.h"

#include "../../Engine/Action.h"
#include "../../Engine/Game.h"


namespace OpenXcom
{

namespace JSUI
{

JSState::JSState() : State()
{
	// store the JSValue matching the JSState instance. _self does not own
	// the instance, its life cycle is managed in the JS application.
	_self = _game->getJSEngine()->ConvertStatePtr(this);
}


JSState::~JSState()
{
	// Decrement the reference counter on the JSWidget instances.
	for (auto const& x : _widget_map) {
		_game->getJSEngine()->FreeValue(x.second);
	}
	_game->getJSEngine()->FreeValue(_self);
}

void JSState::add(JSValue jssurface, Surface *surface)
{
	State::add(surface);
	// Store the JSWidget instance, incrementing the reference counter.
	_widget_map[surface] = _game->getJSEngine()->DupValue(jssurface);
}

void JSState::add(JSValue jssurface, Surface *surface, const std::string &id, const std::string &category, Surface *parent)
{
	State::add(surface, id, category, parent);
	// Store the JSWidget instance, incrementing the reference counter.
	_widget_map[surface] = _game->getJSEngine()->DupValue(jssurface);
}

/**
 * forward common event handler: forward the event to the JS instance.
 *
 * @param action: action to be transmitted
 * @param handler_name: name of the JS method to be activated
 *
 * The JS method is called with parameters: action, state
 */
void JSState::forward(Action *action, const std::string& handler_name)
{
	InteractiveSurface *is = dynamic_cast<InteractiveSurface*>(action->getSender());
	JSValue w = _widget_map[is];
	JSValueConst jsm = _game->getJSEngine()->GetMethod(w, handler_name);

	if (!JS_IsUndefined(jsm)) {
		JSValue jsargs[2];

		jsargs[0] = _game->getJSEngine()->ConvertActionPtr(action);
		jsargs[1] = _self;

		(void)_game->getJSEngine()->CallMethod(jsm, w, 2, jsargs);
		// don't free the state itself ((_game->getJSEngine()->FreeValue(jsargs[1]);))
		_game->getJSEngine()->FreeValue(jsargs[0]);
		_game->getJSEngine()->FreeValue(jsm);
	}
}


/**
 * mouseClick event handler: forward the event to the JS instance.
 */
void JSState::mouseClick(Action *action)
{
	forward(action, "mouseClick");
}

/**
 * mousePress event handler: forward the event to the JS instance.
 */
void JSState::mousePress(Action *action)
{
	forward(action, "mousePress");
}

/**
 * mouseRelease event handler: forward the event to the JS instance.
 */
void JSState::mouseRelease(Action *action)
{
	forward(action, "mouseRelease");
}

/**
 * mouseIn event handler: forward the event to the JS instance.
 */
void JSState::mouseIn(Action *action)
{
	forward(action, "mouseIn");
}

/**
 * mouseOver event handler: forward the event to the JS instance.
 */
void JSState::mouseOver(Action *action)
{
	forward(action, "mouseOver");
}

/**
 * mouseOut event handler: forward the event to the JS instance.
 */
void JSState::mouseOut(Action *action)
{
	forward(action, "mouseOut");
}

/**
 * keyboardPress event handler: forward the event to the JS instance.
 */
void JSState::keyboardPress(Action *action)
{
	forward(action, "keyboardPress");
}

/**
 * keyboardRelease event handler: forward the event to the JS instance.
 */
void JSState::keyboardRelease(Action *action)
{
	forward(action, "keyboardRelease");
}

/**
 * change event handler: forward the event to the JS instance.
 */
void JSState::change(Action *action)
{
	forward(action, "change");
}

}

}

