
// ---------------------------------------------------------
// Macros
// ---------------------------------------------------------
// The JSConvertPtr macros implements a function for a given class that
// convert a C++ instance into its wrapping JSValue.
// This function is used in the code to create the `self` parameter
// in callbacks from the `this` pointer.
// The JSValue needs to be freed after use (JS_FreeValue).
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%define JSConvertJSUIPtr(type)
%wrapper %{
namespace OpenXcom {
namespace JSUI {
JSValue JSConvert ## type ## Ptr(JSContext *ctx, const OpenXcom::JSUI::type* ptr) {
	return SWIG_QuickJS_NewPointerObj(ctx, (void*)ptr, SWIGTYPE_p_OpenXcom__JSUI__ ## type, 0);
}
}
}
%}
%enddef
#endif

%include "JSUI/jsbar.i"
%include "JSUI/jscursor.i"
%include "JSUI/jsframe.i"
%include "JSUI/jsprogressbar.i"
%include "JSUI/jsnumbertext.i"
%include "JSUI/jsinteractivesurface.i"
%include "JSUI/jsimagebutton.i"
%include "JSUI/jsarrowbutton.i"
%include "JSUI/jsscrollbar.i"
%include "JSUI/jscombobox.i"
%include "JSUI/jstext.i"
%include "JSUI/jstextedit.i"
%include "JSUI/jstextlist.i"
%include "JSUI/jstextbutton.i"
%include "JSUI/jstoggletextbutton.i"
%include "JSUI/jsslider.i"
%include "JSUI/jswindow.i"

%include "JSUI/jsstate.i"
