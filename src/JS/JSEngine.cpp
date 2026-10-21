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

#include "JSEngine.h"

#include "../Engine/Logger.h"
#include "../Engine/Options.h"
#include "../Engine/LocalizedText.h"
#include "../Savegame/GameTime.h"

#include "../Mod/Mod.h"
#include "../Mod/RuleEvent.h"

#include "../Engine/Game.h"
#include "../Savegame/SavedGame.h"

#include "../Geoscape/GeoscapeState.h"


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

JSEngine::~JSEngine() {
	DisposeEngine();
}


bool JSEngine::InitializeEngine() {
	DisposeEngine();

	Log(LOG_DEBUG) << "JSEngine::InitializeEngine()";
	rt = JS_NewRuntime();
	if (!rt) {
		Log(LOG_ERROR) << "JSEngine: cannot allocate JS runtime";
		return false;
	}

	js_std_set_worker_new_context_func(QuickJS_NewCustomContext);
	js_std_init_handlers(rt);
	ctx = QuickJS_NewCustomContext(rt);
	if (!ctx) {
			Log(LOG_ERROR) << "JSEngine: cannot allocate JS context";
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

	Log(LOG_VERBOSE) << "JSEngine::InitializeEngine(): success";
	return true;
}


bool JSEngine::DisposeEngine() {
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

bool JSEngine::Reset(Game *game) {
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
		Log(LOG_DEBUG) << "JSEngine::Reset: failed to fetch 'openxcom' module";
		js_std_dump_error(ctx);
		return false;
	}
	int r = JS_SetPropertyStr(ctx, oxc, "game", wgame);
	JS_FreeValue(ctx, oxc);
	if (r == -1) {
		Log(LOG_DEBUG) << "JSEngine::Reset: failed to store the 'game' wrapper object";
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

bool JSEngine::BeginModLoad(Mod *mod) {
	_mod = mod;
	JSValue wmod = ConvertModPtr(mod);
	JSValue globalObject = JS_GetGlobalObject(ctx);
	JSValue oxc = JS_GetPropertyStr(ctx, globalObject, "openxcom");
	JS_FreeValue(ctx, globalObject);
	if (JS_IsException(oxc)) {
		Log(LOG_DEBUG) << "JSEngine::BeginModLoad: failed to fetch 'openxcom' module";
		js_std_dump_error(ctx);
		return false;
	}
	int r = JS_SetPropertyStr(ctx, oxc, "mod", wmod);
	JS_FreeValue(ctx, oxc);
	if (r == -1) {
		Log(LOG_DEBUG) << "JSEngine::BeginModLoad: failed to store the 'mod' wrapper object";
		js_std_dump_error(ctx);
		return false;
	}
	return true;
}

JSValue JSEngine::GetObject(const char *oname) {
	Log(LOG_DEBUG) << "JSEngine::GetObject(" << oname << ")";
	if(!ctx) return JS_UNDEFINED;
	JSValueConst g;
	JSValue o;

	g = JS_GetGlobalObject(ctx);
	o = JS_GetPropertyStr(ctx, g, oname);
	if (JS_IsException(o)) {
		Log(LOG_DEBUG) << "JSEngine::GetObject(" << oname << "): exception";
		js_std_dump_error(ctx);
		/* clear the exception and returns undefined */
		JS_FreeValue(ctx, JS_GetException(ctx));
		return JS_UNDEFINED;
	}
    JS_FreeValue(ctx, g);
	Log(LOG_VERBOSE) << "JSEngine::GetObject(" << oname << "): success " << JS_IsObject(o);
    return o;
}


JSValue JSEngine::GetProperty(JSValueConst o, const char *pname) {
	Log(LOG_DEBUG) << "JSEngine::GetProperty(" << pname << ")";
	if(!ctx) return JS_UNDEFINED;
	if(!JS_IsObject(o)) return JS_UNDEFINED;
	JSValue p;

	p = JS_GetPropertyStr(ctx, o, pname);
	if (JS_IsException(p)) {
		Log(LOG_DEBUG) << "JSEngine::GetProperty(" << pname << "): exception";
		js_std_dump_error(ctx);
		/* clear the exception and returns undefined */
		JS_FreeValue(ctx, JS_GetException(ctx));
		return JS_UNDEFINED;
	}
	Log(LOG_VERBOSE) << "JSEngine::GetProperty(" << pname << "): success";
    return p;
}


JSValue JSEngine::GetMethod(JSValueConst o, const char *mname) {
	Log(LOG_DEBUG) << "JSEngine::GetMethod(" << mname << ")";
	if(!ctx) return JS_UNDEFINED;
	if(!JS_IsObject(o)) return JS_UNDEFINED;
	JSValue m;

	m = JS_GetPropertyStr(ctx, o, mname);
	if (JS_IsException(m)) {
		Log(LOG_DEBUG) << "JSEngine::GetMethod(" << mname << "): exception";
		js_std_dump_error(ctx);
		/* clear the exception and returns undefined */
		JS_FreeValue(ctx, JS_GetException(ctx));
		return JS_UNDEFINED;
	}
	Log(LOG_VERBOSE) << "JSEngine::GetMethod(" << mname << "): success " << JS_IsFunction(ctx, m);
    return m;
}


JSValue JSEngine::CallMethod(JSValue m, JSValueConst this_val, int argc, JSValueConst argv[]) {
	Log(LOG_DEBUG) << "JSEngine::CallMethod()";
	if(!ctx) return JS_UNDEFINED;
	if(!JS_IsFunction(ctx, m)) return JS_UNDEFINED;
	if(!JS_IsObject(this_val)) return JS_UNDEFINED;
	JSValue r;

	r = JS_Call(ctx, m, this_val, argc, argv);
	if (JS_IsException(r)) {
		Log(LOG_DEBUG) << "JSEngine::CallMethod(): exception";
		js_std_dump_error(ctx);
		/* clear the exception and returns undefined */
		JS_FreeValue(ctx, JS_GetException(ctx));
		return JS_UNDEFINED;
	}
	Log(LOG_VERBOSE) << "JSEngine::CallMethod(): success";
    return r;
}


JSValue JSEngine::ConvertGamePtr(const Game* ptr) {
	extern JSValue JSConvertGamePtr(JSContext *ctx, const Game *ptr);
	return JSConvertGamePtr(ctx, ptr);
}

JSValue JSEngine::ConvertModPtr(const Mod* ptr) {
	extern JSValue JSConvertModPtr(JSContext *ctx, const Mod *ptr);
	return JSConvertModPtr(ctx, ptr);
}

JSValue JSEngine::ConvertSavedGamePtr(const SavedGame* ptr) {
	extern JSValue JSConvertSavedGamePtr(JSContext *ctx, const SavedGame *ptr);
	return JSConvertSavedGamePtr(ctx, ptr);
}

JSValue JSEngine::ConvertGeoscapeStatePtr(const GeoscapeState* ptr) {
	extern JSValue JSConvertGeoscapeStatePtr(JSContext *ctx, const GeoscapeState *ptr);
	return JSConvertGeoscapeStatePtr(ctx, ptr);
}

JSValue JSEngine::ConvertRuleEventPtr(const RuleEvent* ptr) {
	extern JSValue JSConvertRuleEventPtr(JSContext *ctx, const RuleEvent *ptr);
	return JSConvertRuleEventPtr(ctx, ptr);
}


bool JSEngine::RunScript(const std::string &scriptPath) {
	Log(LOG_DEBUG) << "JSEngine::RunScript(" << scriptPath << ")";
	if (!EvalFile(scriptPath.c_str(), -1))
		return false;

	js_std_loop(ctx);
	Log(LOG_VERBOSE) << "JSEngine::RunScript(" << scriptPath << "): success";
	return true;
}


bool JSEngine::EvalBuffer(const char *buf, int buf_len,
							const char *filename, int eval_flags) {
	JSValue val;
	bool ret;

	Log(LOG_DEBUG) << "JSEngine::EvalBuffer(" << filename << ")";
	if ((eval_flags & JS_EVAL_TYPE_MASK) == JS_EVAL_TYPE_MODULE) {
		/* for the modules, we compile then run to be able to set
			 import.meta */
		val = JS_Eval(ctx, buf, buf_len, filename,
					eval_flags | JS_EVAL_FLAG_COMPILE_ONLY);
		if (!JS_IsException(val)) {
			js_module_set_import_meta(ctx, val, true, true);
			val = JS_EvalFunction(ctx, val);
		}
		val = js_std_await(ctx, val);
	} else {
		val = JS_Eval(ctx, buf, buf_len, filename, eval_flags);
	}
	if (JS_IsException(val)) {
		js_std_dump_error(ctx);
		/* clear the exception and returns false */
		JS_FreeValue(ctx, JS_GetException(ctx));
		ret = false;
	} else {
		JS_FreeValue(ctx, val);
		ret = true;
	}
	if(ret) {
		Log(LOG_VERBOSE) << "JSEngine::EvalBuffer(" << filename << "): success";
	} else {
		Log(LOG_VERBOSE) << "JSEngine::EvalBuffer(" << filename << "): failed";
	}
	return ret;
}

bool JSEngine::EvalFile(const char *filename, int module) {
	char *buf;
	int ret, eval_flags;
	size_t buf_len;

	Log(LOG_DEBUG) << "JSEngine::EvalFile(" << filename  << "," << module << ")";
	buf = (char*)js_load_file(ctx, &buf_len, filename);
	if (!buf) {
		Log(LOG_ERROR) << "JSEngine: Failed to load file " << filename;
		return false;
	}

	if (module < 0) {
		module = JS_DetectModule((const char *)buf, buf_len);
	}
	if (module) {
		eval_flags = JS_EVAL_TYPE_MODULE;
	} else {
		eval_flags = JS_EVAL_TYPE_GLOBAL;
		if (strict)
			eval_flags |= JS_EVAL_FLAG_STRICT;
	}
	ret = EvalBuffer(buf, buf_len, filename, eval_flags);
	js_free(ctx, buf);
	if (ret) {
		Log(LOG_VERBOSE) << "JSEngine::EvalFile(" << filename  << "," << module << "): success";
	}
	return ret;
}

}
