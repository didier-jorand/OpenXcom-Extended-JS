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
%echo "Processing State.i"
#endif

struct SDL_Color;


namespace OpenXcom
{

#ifdef JS_WITH_UI_WRAPPERS
class Surface;
class InteractiveSurface;
class Window;
class Game;
class SavedBattleGame;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%apply SWIGTYPE *DISOWN {Surface *transfer_surface};
#endif
#endif

class State
{
public:

#ifdef JS_WITH_UI_WRAPPERS
	/// Set interface rules.
	void setInterface(const std::string &s, bool alterPal = false, SavedBattleGame *battleGame = 0);
	/// Set window background.
	void setWindowBackground(Window *window, const std::string &s);
	/// Set window background by image name (instead of by interface name).
	void setWindowBackgroundImage(Window* window, const std::string& bgImageName);

	/// Add a optional child element but it will not be displayed.
	void preAdd(Surface *transfer_surface);
	/// Adds a child element to the state.
	void add(Surface *transfer_surface);
	/// Adds a child element to the state.
	void add(Surface *transfer_surface, const std::string &id, const std::string &category, Surface *parent = 0);

	/// Gets whether the state is a full-screen.
	bool isScreen() const;
	/// Toggles whether the state is a full-screen.
	void toggleScreen();

#if 0
	/// Initializes the state.
	virtual void init();
	/// Handles any events.
	virtual void handle(Action *action);
	/// Runs state functionality every cycle.
	virtual void think();
	/// Blits the state to the screen.
	virtual void blit();
#endif

	/// Hides all the state surfaces.
	void hideAll();
	/// Shows all the state surfaces.
	void showAll();
	/// Resets all the state surfaces.
	void resetAll();

#endif

	/// Get the localized text.
	LocalizedText tr(const std::string &id) const;
	/// Get the localized text.
	LocalizedText trAlt(const std::string &id, int alt) const;
	/// Get the localized text.
	LocalizedText tr(const std::string &id, unsigned n) const;
	///Get the localized text.
	//LocalizedText tr(const std::string &id, SoldierGender gender) const;

#ifdef JS_WITH_UI_WRAPPERS
	/// redraw all the text-type surfaces.
	void redrawText();

	/// does the state only have one text list (to scroll)?
	bool hasOnlyOneScrollableTextList() const;

	/// center all surfaces relative to the screen.
	void centerAllSurfaces();

	/// lower all surfaces by half the screen height.
	void lowerAllSurfaces();

	/// switch the colours to use the battlescape palette.
	void applyBattlescapeTheme(const std::string& category);

#if 0
	/// Sets game object pointer
	static void setGamePtr(Game* game);
#endif

	/// Sets a modal surface.
	void setModal(InteractiveSurface *surface);
#endif

	/// Changes a set of colors on the state's 8bpp palette.
	void setStatePalette(const SDL_Color *colors, int firstcolor = 0, int ncolors = 256);
	/// Changes a set of colors on the state's 8bpp palette of helper surfaces.
	void setModPalette();

	/// Changes the state's 8bpp palette with certain resources.
	void setStandardPalette(const std::string &palette, int backpals = -1);
	/// Changes the state's 8bpp palette with certain resources.
	void setCustomPalette(SDL_Color *colors, int cursorColor);

	/// Gets the state's 8bpp palette.
	SDL_Color *getPalette();

#ifdef JS_WITH_UI_WRAPPERS
	/// Let the state know the window has been resized.
	virtual void resize(int &dX, int &dY);
	/// Re-orients all the surfaces in the state.
	virtual void recenter(int dX, int dY);

	/// Gets cursor X coordinate.
	int getCursorX() const;
	/// Gets cursor Y coordinate.
	int getCursorY() const;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "State@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

#ifdef JS_WITH_UI_WRAPPERS
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%clear Surface *transfer_surface;
#endif
#endif


JSConvertPtr(State);

}  /* end of namespace OpenXcom */

