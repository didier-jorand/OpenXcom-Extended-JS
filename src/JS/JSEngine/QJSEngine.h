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


namespace JS
{

class JSEngine {
public:
	JSEngine() {
		rt = NULL;
		ctx = NULL;
		strict = false;
	}
	virtual ~JSEngine() { DisposeEngine(); };

	virtual bool InitializeEngine();

	bool RunScript(const std::string &scriptPath);
	JSRuntime *get_runtime() const {return rt;}
	JSContext *get_context() const {return ctx;}

	// Wraps many JS API functions
	JSValue GetObject(const char *oname);
	JSValue GetObject(const std::string& oname) { return GetObject(oname.c_str()); }
	JSValue GetProperty(JSValueConst o, const char *pname);
	JSValue GetProperty(JSValueConst o, const std::string& pname) { return GetProperty(o, pname.c_str()); }
	JSValue GetMethod(JSValueConst o, const char *mname);
	JSValue GetMethod(JSValueConst o, const std::string& mname) { return GetMethod(o, mname.c_str()); }
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

protected:
	virtual bool DisposeEngine();

	bool EvalBuffer(const char *buf, int buf_len, const char *filename, int eval_flags);
	bool EvalFile(const char *filename, int module);

	JSRuntime *rt;
	JSContext *ctx;
	bool strict;
};

}

