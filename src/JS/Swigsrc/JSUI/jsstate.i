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

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%echo "Processing JSState.i"
#endif

%{
#include "JS/JSUI/JSState.h"
%}

%{
// Implementation of the '%extend' method "add" and "add_rs" in JSState
// The trick here is to be able to store the JS Object, which is argv[0] in the
// generated code; This may be doable with a typemap as well.
#define OpenXcom_JSUI_OpenXcom_JSUI_JSState_add(state, surface) state->add(argv[0], surface)
#define OpenXcom_JSUI_OpenXcom_JSUI_JSState_add_rs(state, surface, id, category, parent) state->add(argv[0], surface, id, category, parent)
%}

namespace OpenXcom
{

namespace JSUI
{
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%apply SWIGTYPE *DISOWN {Surface *transfer_surface};
#endif


/// JSState: specific class for UI interaction from JS
///
/// The JSState class allows to create UI State from scratch and
/// and manage their dynamic behavior.

class JSState : public State
{
public:
	JSState();
	~JSState();


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "JSState@%p", self);
		return strdup(buffer);
	}

	/// Add and register widgets (as JSValue and as Surface*) in the JSState
	void add(Surface *transfer_surface);
	/// Add and register widgets (as JSValue and as Surface*) in the JSState, defined from a ruleset
	void add_rs(Surface *transfer_surface, const std::string &id, const std::string &category, Surface *parent);
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertJSUIPtr(JSState);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%clear Surface *transfer_surface;
#endif

}  /* end of namespase JSUI */

}  /* end of namespace OpenXcom */

