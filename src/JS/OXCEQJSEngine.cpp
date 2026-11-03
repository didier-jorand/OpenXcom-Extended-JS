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


#include <stdbool.h>
#include <string>

#include "OXCEQJSEngine.h"

#include "../Engine/Logger.h"
#include "../Engine/Options.h"
#include "../Engine/LocalizedText.h"
#include "../Engine/Yaml.h"
#include "../Savegame/GameTime.h"

#include "../Mod/Mod.h"
#include "../Mod/RuleEvent.h"

#include "../Engine/Game.h"
#include "../Savegame/SavedGame.h"

#include "../Geoscape/GeoscapeState.h"

using OpenXcom::SeverityLevel;
using OpenXcom::LOG_ERROR;
using OpenXcom::LOG_WARNING;
using OpenXcom::LOG_INFO;
using OpenXcom::LOG_DEBUG;
using OpenXcom::LOG_VERBOSE;
using OpenXcom::Logger;

extern "C" {
/*
 * "C" functions to interface the QuickJS engine
 */

/* from swig module 'openxcom' */
extern JSModuleDef *js_init_module(JSContext *ctx, const char *module_name);


/* Create a JS context and load the standard modules, also used to initialize the worker context */
static JSContext *QuickJS_NewCustomContext(JSRuntime *rt)
{
    JSContext *ctx;
    ctx = JS_NewContext(rt);
    if (!ctx)
        return NULL;
    /* system modules */
    js_init_module_std(ctx, "std");
    js_init_module_os(ctx, "os");

    /* openxcom module */
	js_init_module(ctx, "openxcom");

    return ctx;
}

} /* extern "C" */

namespace OpenXcom {

extern JSValue JSConvertGamePtr(JSContext *ctx, const Game *ptr);
extern JSValue JSConvertModPtr(JSContext *ctx, const Mod *ptr);
extern JSValue JSConvertSavedGamePtr(JSContext *ctx, const SavedGame *ptr);
extern JSValue JSConvertGeoscapeStatePtr(JSContext *ctx, const GeoscapeState *ptr);
extern JSValue JSConvertRuleEventPtr(JSContext *ctx, const RuleEvent *ptr);

namespace YAML {
extern JSValue JSConvertYamlNodeReaderPtr(JSContext *ctx, const OpenXcom::YAML::YamlNodeReader *ptr);
extern JSValue JSConvertYamlNodeWriterPtr(JSContext *ctx, const OpenXcom::YAML::YamlNodeWriter *ptr);
}
}

namespace JS {

bool OXCEJSEngine::InitializeEngine() {
	DisposeEngine();

	Log(LOG_DEBUG) << "OXCEJSEngine::InitializeEngine()";
	rt = JS_NewRuntime();
	if (!rt) {
		Log(LOG_ERROR) << "OXCEJSEngine: cannot allocate JS runtime";
		return false;
	}

	js_std_set_worker_new_context_func(QuickJS_NewCustomContext);
	js_std_init_handlers(rt);
	ctx = QuickJS_NewCustomContext(rt);
	if (!ctx) {
			Log(LOG_ERROR) << "OXCEJSEngine: cannot allocate JS context";
			return false;
	}

	/* loader for ES6 modules */
	JS_SetModuleLoaderFunc2(rt, NULL, js_module_loader, js_module_check_attributes, NULL);

	JS_SetHostPromiseRejectionTracker(rt, js_std_promise_rejection_tracker, NULL);

	js_std_add_helpers(ctx, 0, NULL);

	// The global variable 'openxcon' is set as the namespace 'OpenXcom', which
	// is included in the openxcom module.
	const char *str = "import * as std from 'std';\n"
            "import * as os from 'os';\n"
            "import * as openxcom from 'openxcom';\n"
            "globalThis.std = std;\n"
            "globalThis.os = os;\n"
            "globalThis.openxcom = openxcom.openxcom;\n"
            "globalThis.OpenXcom = openxcom.openxcom.OpenXcom;\n";
	if (!EvalBuffer(str, strlen(str), "<input>", JS_EVAL_TYPE_MODULE)) {
		return false;
	}

	Log(LOG_VERBOSE) << "OXCEJSEngine::InitializeEngine(): success";
	return true;
}


bool OXCEJSEngine::DisposeEngine() {
	if (ctx) {
		JS_FreeValue(ctx, _jsGame);
		JS_FreeValue(ctx, _jsSavedGame);
		JS_FreeValue(ctx, _jsGeoscapeState);
	}

	if (rt) {
		js_std_free_handlers(rt);
	}
	if (ctx) {
		JS_FreeContext(ctx);
		ctx = NULL;
	}
	if (rt) {
		JS_FreeRuntime(rt);
		rt = NULL;
	}
	return true;
}

bool OXCEJSEngine::Reset(Game *game) {
	// A game is started or its list of mod is reset.
	// We need to recreate the JS context in order to reload only
	// the requested mods.
	if (!InitializeEngine()) return false;

	_game = game;
	JSValue wgame = ConvertGamePtr(game);
	JSValue globalObject = JS_GetGlobalObject(ctx);
	JSValue oxc = JS_GetPropertyStr(ctx, globalObject, "openxcom");
	JS_FreeValue(ctx, globalObject);
	if (JS_IsException(oxc)) {
		Log(LOG_DEBUG) << "OXCEJSEngine::Reset: failed to fetch 'openxcom' module";
		js_std_dump_error(ctx);
		return false;
	}
	int r = JS_SetPropertyStr(ctx, oxc, "game", wgame);
	JS_FreeValue(ctx, oxc);
	if (r == -1) {
		Log(LOG_DEBUG) << "OXCEJSEngine::Reset: failed to store the 'game' wrapper object";
		js_std_dump_error(ctx);
		return false;
	}

	// Load the Javascript "main" file (openxcom.js)
	// It is mod independent, therefore, it is loaded before the mods
	// are loaded, to provide the callback "infrastructure" beforehand.
	Options::setDataFolder(CrossPlatform::dirFilename(CrossPlatform::searchDataFolder("js")));

	Log(LOG_INFO) << "jsengine: loading main script: " << Options::getDataFolder() + "js/openxcom.js";
	RunScript(Options::getDataFolder() + "js/openxcom.js");

	// Get the bridge objects (Game, SaveGame, GeoscapeState...), as these implement the
	// JS methods to be called from the instance triggering an event
	// XXX Should be in openxcom namespace ? (openxcom.jsGame, etc...)
	_jsGame = GetObject("jsGame");
	if (JS_IsUndefined(_jsGame)) { Log(LOG_WARNING) << "jsengine: jsGame object not found"; }
	_jsSavedGame = GetObject("jsSavedGame");
	if (JS_IsUndefined(_jsSavedGame)) { Log(LOG_WARNING) << "jsengine: jsSavedGame object not found"; }
	_jsGeoscapeState = GetObject("jsGeoscapeState");
	if (JS_IsUndefined(_jsGeoscapeState)) { Log(LOG_WARNING) << "jsengine: jsGeoscapeState object not found"; }

	return true;
}

bool OXCEJSEngine::BeginModLoad(Mod *mod) {
	_mod = mod;
	JSValue wmod = ConvertModPtr(mod);
	JSValue globalObject = JS_GetGlobalObject(ctx);
	JSValue oxc = JS_GetPropertyStr(ctx, globalObject, "openxcom");
	JS_FreeValue(ctx, globalObject);
	if (JS_IsException(oxc)) {
		Log(LOG_DEBUG) << "OXCEJSEngine::BeginModLoad: failed to fetch 'openxcom' module";
		js_std_dump_error(ctx);
		return false;
	}
	int r = JS_SetPropertyStr(ctx, oxc, "mod", wmod);
	JS_FreeValue(ctx, oxc);
	if (r == -1) {
		Log(LOG_DEBUG) << "OXCEJSEngine::BeginModLoad: failed to store the 'mod' wrapper object";
		js_std_dump_error(ctx);
		return false;
	}
	return true;
}


JSValue OXCEJSEngine::ConvertGamePtr(const Game* ptr) {
	return OpenXcom::JSConvertGamePtr(ctx, ptr);
}

JSValue OXCEJSEngine::ConvertModPtr(const Mod* ptr) {
	return OpenXcom::JSConvertModPtr(ctx, ptr);
}

JSValue OXCEJSEngine::ConvertSavedGamePtr(const SavedGame* ptr) {
	return OpenXcom::JSConvertSavedGamePtr(ctx, ptr);
}

JSValue OXCEJSEngine::ConvertGeoscapeStatePtr(const GeoscapeState* ptr) {
	return OpenXcom::JSConvertGeoscapeStatePtr(ctx, ptr);
}

JSValue OXCEJSEngine::ConvertRuleEventPtr(const RuleEvent* ptr) {
	return OpenXcom::JSConvertRuleEventPtr(ctx, ptr);
}

JSValue OXCEJSEngine::ConvertYamlNodeReaderPtr(const OpenXcom::YAML::YamlNodeReader* ptr) {
	return OpenXcom::YAML::JSConvertYamlNodeReaderPtr(ctx, ptr);
}

JSValue OXCEJSEngine::ConvertYamlNodeWriterPtr(const OpenXcom::YAML::YamlNodeWriter* ptr) {
	return OpenXcom::YAML::JSConvertYamlNodeWriterPtr(ctx, ptr);
}


}
