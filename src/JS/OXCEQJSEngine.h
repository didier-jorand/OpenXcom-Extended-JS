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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenXcom.	If not, see <http://www.gnu.org/licenses/>.
 */

#include "QJSEngine.h"

namespace OpenXcom {
class Game;
class Mod;
class SavedGame;
class GeoscapeState;
class RuleEvent;

namespace YAML {
	class YamlNodeReader;
	class YamlNodeWriter;
}
}

namespace JS
{
using namespace OpenXcom;

class OXCEJSEngine : public JSEngine {
public:
	OXCEJSEngine(): JSEngine() {
		_game = nullptr;
		_mod = nullptr;

		_jsGame = JS_UNDEFINED;
		_jsSavedGame = JS_UNDEFINED;
		_jsGeoscapeState = JS_UNDEFINED;
	}
	virtual ~OXCEJSEngine() { DisposeEngine(); };

	virtual bool InitializeEngine() override;

	// OpenXcom related initialization and methods
	bool Reset(Game *game); // Initialization of the JSEngine when the modules are loaded/refreshed
	bool BeginModLoad(Mod *mod);

	// Get bridge objects to be used in methods triggering callbacks
	JSValueConst GetGameObject() const { return _jsGame; };
	JSValueConst GetSavedGameObject() const { return _jsSavedGame; };
	JSValueConst GetGeoscapeStateObject() const { return _jsGeoscapeState; };

	// Object conversion, to use as 'self' parameter in callbacks
	JSValue ConvertGamePtr(const Game* ptr);
	JSValue ConvertModPtr(const Mod* ptr);
	JSValue ConvertSavedGamePtr(const SavedGame* ptr);
	JSValue ConvertGeoscapeStatePtr(const GeoscapeState* ptr);
	JSValue ConvertRuleEventPtr(const RuleEvent* ptr);
	JSValue ConvertYamlNodeReaderPtr(const OpenXcom::YAML::YamlNodeReader *ptr);
	JSValue ConvertYamlNodeWriterPtr(const OpenXcom::YAML::YamlNodeWriter *ptr);

protected:
	virtual bool DisposeEngine() override;

private:
	// Global
	Game *_game;
	Mod *_mod;

	// Reference to the JS bridge objects for callbacks (Game, SavedGame, etc...)
	JSValue _jsGame;
	JSValue _jsSavedGame;
	JSValue _jsGeoscapeState;

};

}

