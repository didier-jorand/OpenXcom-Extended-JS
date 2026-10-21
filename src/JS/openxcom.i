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

 /* Implementation note:
  * To make a new class available to JS scripts, it must:
  * - have a wrapper newclass.i (in src/JS folder), included from openxcom.i
  *   and its header must be added to the header section in openxcom.i
  * - have a js counterpart defined in the file openxcom.js (in bin/)
  *   that implement the required callbacks
  * - have its source code updated (src/.../newclass.cpp) to add
  *   the code that will trigger the callback
  * - have its javascript instance loaded and made available in
  *   the JSEngine (JSEngine.h and JSEngine.cpp, is src/JS):
  *   JSValue js<NewClass>, JSValue get<NewClass>Object and
  *   JSValue Convert<Newclass>Ptr and freed in the destructor.
  * - have the callbacks triggered in the example JSTraceCalls, by
  *   creating a new file newclass_cb.js (testing)
  * Need to be careful on the consistency of parameters sent to the
  * callback from the C++ code and the expected one in the javascript
  * counterpart.
  */

/// \mainpage
/// This part of the documentation describes the class, methods and
/// attributes made available to JS script writers when dealing with
/// a given class instance.
///
/// The OpenXcom development documentation actually describes in detail
/// each class and property and is the reference for the definition of
/// their features.
///
/// This document lists the subset that is wrapped (using `swig`).
///
///
/// Note that the namespace feature of C++ is translated into an
/// object hierarchy in javascript.
///
/// - openxcom = module
/// - openxcom.openxcom = module namespace
/// - openxcom.openxcom.OpenXcom = namespace OpenXcom
/// - openxcom.openxcom.OpenXcom.Options = namespace OpenXcom.Options
///  -openxcom.openxcom.std = namespace std
///
/// From the scripts point of view, 2 global variables are provided
/// - openxcom => access to the module namespace
/// - OpenXcom => access to the OpenXcom namespace

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%module openxcom

%include "typemaps.i"
%include "std_string.i"
%include "std_vector.i"
%include "std_map.i"

%{
#include <stdint.h>

#include "Engine/Logger.h"
#include "Engine/LocalizedText.h"
#include "Engine/Language.h"
#include "Engine/OptionInfo.h"
#include "Engine/Options.h"
#include "Savegame/GameTime.h"

#include "Mod/Mod.h"
#include "Mod/RuleEvent.h"
#include "Mod/RuleCountry.h"
#include "Mod/RuleRegion.h"
#include "Mod/RuleItemCategory.h"
#include "Mod/RuleItem.h"
#include "Mod/RuleInventory.h"
#include "Mod/RuleResearch.h"
#include "Mod/Unit.h"
#include "Mod/Armor.h"
#include "Mod/RuleCraft.h"
#include "Mod/RuleCraftWeapon.h"
#include "Mod/RuleUfo.h"
#include "Mod/RuleManufacture.h"
#include "Mod/RuleSoldier.h"
#include "Mod/RuleBaseFacility.h"

#include "Battlescape/InfoboxState.h"
#include "Battlescape/InfoboxOKState.h"

#include "Engine/Game.h"
#include "Savegame/Country.h"
#include "Savegame/Region.h"
#include "Savegame/ResearchProject.h"
#include "Savegame/ItemContainer.h"
#include "Savegame/Production.h"
#include "Savegame/EquipmentLayoutItem.h"
#include "Savegame/Soldier.h"
#include "Savegame/Target.h"
#include "Savegame/MovingTarget.h"
#include "Savegame/Craft.h"
#include "Savegame/CraftWeapon.h"
#include "Savegame/Ufo.h"
#include "Savegame/Transfer.h"
#include "Savegame/BaseFacility.h"
#include "Savegame/Base.h"
#include "Savegame/SavedGame.h"

#include "Geoscape/UfoLostState.h"
#include "Geoscape/GeoscapeState.h"
%}

%echo "Processing openxcom.i"

// ---------------------------------------------------------
// Macros
// ---------------------------------------------------------
// The JSConvertPtr macros implements a function for a given class that
// convert a C++ instance into its wrapping JSValue.
// This function is used in the code to create the `self` parameter
// in callbacks from the `this` pointer.
// The JSValue needs to be freed after use (JS_FreeValue).
%define JSConvertPtr(type)
%wrapper %{
namespace OpenXcom {
JSValue JSConvert ## type ## Ptr(JSContext *ctx, const OpenXcom::type* ptr) {
	return SWIG_QuickJS_NewPointerObj(ctx, (void*)ptr, SWIGTYPE_p_OpenXcom__ ## type, 0);
}
}
%}
%enddef
#endif // DOXYGEN_SHOULD_SKIP_THIS

// ---------------------------------------------------------
// Common Templates
// ---------------------------------------------------------
#ifndef DOXYGEN_SHOULD_SKIP_THIS
typedef signed char Sint8;
typedef unsigned char Uint8;
typedef short int Sint16;
typedef unsigned short int Uint16;
typedef long long int64_t;
typedef unsigned long long uint64_t;


%template(StringVector) std::vector<std::string>;
%template(StringIntMap) std::map<std::string, int>;
%template(IntVector) std::vector<int>;
%template(DoubleVector) std::vector<double>;
#endif // DOXYGEN_SHOULD_SKIP_THIS

%nspace;

namespace OpenXcom {

// ---------------------------------------------------------
// Logger 1
// ---------------------------------------------------------
enum SeverityLevel {
	LOG_FATAL,
	LOG_ERROR,
	LOG_WARNING,
	LOG_INFO,
	LOG_DEBUG,
	LOG_VERBOSE,
};

} // end of namespace OpenXcom

// ---------------------------------------------------------
// Logger 2
// ---------------------------------------------------------
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%inline %{
namespace OpenXcom {
void JSLog(SeverityLevel level, const char* message) {
	Log(level) << "JSEngine: " << message;
}
}
%}
#endif /* DOXYGEN_SHOULD_SKIP_THIS */

%{
extern OpenXcom::Game *game; // global defined in main.cpp
%}

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%include "Engine/localizedtext.i"
%include "Engine/language.i"
%include "Engine/options.i"

%include "Mod/ruleevent.i"
%include "Mod/rulecountry.i"
%include "Mod/ruleregion.i"
%include "Mod/ruleitemcategory.i"
%include "Mod/ruleitem.i"
%include "Mod/ruleinventory.i"
%include "Mod/ruleresearch.i"
%include "Mod/unit.i"
%include "Mod/rulesoldier.i"
%include "Mod/armor.i"
%include "Mod/rulecraft.i"
%include "Mod/rulecraftweapon.i"
%include "Mod/ruleufo.i"
%include "Mod/rulemanufacture.i"
%include "Mod/rulebasefacility.i"
%include "Mod/mod.i"

%include "Engine/state.i"

%include "Battlescape/infoboxstate.i"
%include "Battlescape/infoboxokstate.i"

%include "Engine/game.i"

%include "Savegame/gametime.i"
%include "Savegame/country.i"
%include "Savegame/region.i"
%include "Savegame/researchproject.i"
%include "Savegame/itemcontainer.i"
%include "Savegame/production.i"
%include "Savegame/equipmentlayoutitem.i"
%include "Savegame/soldier.i"
%include "Savegame/target.i"
%include "Savegame/movingtarget.i"
%include "Savegame/craft.i"
%include "Savegame/craftweapon.i"
%include "Savegame/ufo.i"
%include "Savegame/transfer.i"
%include "Savegame/basefacility.i"
%include "Savegame/base.i"
%include "Savegame/savedgame.i"

%include "Geoscape/ufoloststate.i"
%include "Geoscape/geoscapestate.i"

#endif
