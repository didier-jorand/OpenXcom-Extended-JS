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

#include <quickjs.h>
#include <quickjs-libc.h>


namespace OpenXcom
{
class Game;
class Mod;
class SavedGame;
class GeoscapeState;
class RuleEvent;

namespace YAML {
	class YamlNodeReader;
	class YamlNodeWriter;
}

class JSEngine {
public:
	JSEngine() {
		rt = NULL;
		ctx = NULL;
		strict = false;

		_game = nullptr;
		_mod = nullptr;

		_jsGame = JS_UNDEFINED;
		_jsSavedGame = JS_UNDEFINED;
		_jsGeoscapeState = JS_UNDEFINED;
	}
	~JSEngine();
	bool InitializeEngine();
	bool RunScript(const std::string &scriptPath);
	JSRuntime *get_runtime() const {return rt;}
	JSContext *get_context() const {return ctx;}

	// Wraps many JS API functions
	JSValue GetObject(const char *oname);
	JSValue GetProperty(JSValueConst o, const char *pname);
	JSValue GetMethod(JSValueConst o, const char *mname);
	JSValue CallMethod(JSValue m, JSValueConst this_val, int argc, JSValueConst argv[]);
	JSValue NewString(const char* v) { return JS_NewString(ctx, v); }
	JSValue NewString(const std::string& v) { return JS_NewString(ctx, v.c_str()); }
	JSValue NewBool(bool v) { return JS_NewBool(ctx, v); }
	JSValue NewInt(int v) { return JS_NewInt32(ctx, v); }
	JSValue NewDouble(double v) { return JS_NewFloat64(ctx, v); }
	JSValue NewNull() { return JS_NULL; }
	JSValue NewUndefined() { return JS_UNDEFINED; }
	JSValue NewObject() { return JS_NewObject(ctx); }
	JSValue NewArray() { return JS_NewArray(ctx); }
	JSValue DupValue(JSValue v) { return JS_DupValue(ctx, v); }
	void FreeValue(JSValue v) { JS_FreeValue(ctx, v); }

	bool IsString(JSValueConst v) const { return JS_IsString(v); }
	bool IsArray(JSValueConst v) const { return JS_IsArray(ctx, v); }
	bool IsObject(JSValueConst v) const { return JS_IsObject(v); }
	bool IsNull(JSValueConst v) const { return JS_IsNull(v); }
	bool IsUndefined(JSValueConst v) const { return JS_IsUndefined(v); }
	bool IsBool(JSValueConst v) const { return JS_IsBool(v); }
	bool IsNumber(JSValueConst v) const { return JS_IsNumber(v); }


	bool ToBool(JSValueConst v) const { return JS_ToBool(ctx, v); }
	int ToInt(JSValueConst v) const;
	double ToDouble(JSValueConst v) const;
	const char *ToCString(JSValueConst v) const { return JS_ToCString(ctx, v); }
	void FreeCString(const char *p) { JS_FreeCString(ctx, p); }

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
	JSValue ConvertYamlNodeReaderPtr(const YAML::YamlNodeReader *ptr);
	JSValue ConvertYamlNodeWriterPtr(const YAML::YamlNodeWriter *ptr);

protected:
	bool DisposeEngine();

private:
	bool EvalBuffer(const char *buf, int buf_len, const char *filename, int eval_flags);
	bool EvalFile(const char *filename, int module);

	JSRuntime *rt;
	JSContext *ctx;
	bool strict;

	// Global
	Game *_game;
	Mod *_mod;

	// Reference to the JS values for "call exits" (Game, SavedGame, etc...)
	JSValue _jsGame;
	JSValue _jsSavedGame;
	JSValue _jsGeoscapeState;

};

}

