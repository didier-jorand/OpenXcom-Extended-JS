# README for OpenXcom-Extended-JS

This is the 'README' for OpenXcom-Extended-JS, fork of OpenXcom-Extended.


## Introduction

**Warning**: This is **work in progress**, development is on-going and
is tested only on Linux for the time being. See [status](#status).

OpenXcom-Extended-JS (OXCEJS in short) enhances the game by introducing
a new type of extensions that can be written in Javascript.

These extensions can be mod by themselves or scripts can be added
to existing mod.
A script implements callback functions that are called when predefined
events occur in the game (like loading a saved game).


## Prerequisites and Configuration

OXCEJS requires the following developer libraries:

- [SDL](https://www.libsdl.org) (libsdl1.2)
- [SDL\_mixer](https://www.libsdl.org/projects/SDL_mixer/) (libsdl-mixer1.2)
- [SDL\_gfx](https://www.ferzkopp.net/wordpress/2016/01/02/sdl_gfx-sdl2_gfx/) (libsdl-gfx1.2), version 2.0.22 or later
- [SDL\_image](https://www.libsdl.org/projects/SDL_image/) (libsdl-image1.2)
- [yaml-cpp](https://github.com/jbeder/yaml-cpp)
- [QuickJS](https://bellard.org/quickjs/) , version 2025-09-13 or above
- [SWIG-QuickJS](https://github.com/didier-jorand/swig-quickjs.git), fork of SWIG that includes the code generation for QuickJS

[SWIG-QuickJS] needs to be installed manually from a git clone.

OXCEJS needs to be installed from source, no binaries are provided yet.

The [git repository](https://github.com/didier-jorand/OpenXcom-Extended-JS.git)
needs to be cloned, then use `cmake` to build the executable.

Additional cmake options:

- `QUICKJS_INC`: path to quickjs.h and other includes (default: /usr/include/quickjs)
- `QUICKJS_LIB`: path to libquickjs.a (default: /usr/lib64/quickjs)
- `SWIG_EXECUTABLE`: path to the swig (swig-quickjs) executable
- `SWIG_DIR`: path to the swig libraries


## Principles

### JS Scripts Mods

Scripting is added to the game in mods, like any other module.

A Mod can be made of scripts only or scripts can be integrated
in existing mods with rulesets, resources, units, etc...

When the mod is loaded, the scripts (any file with extension "js") will be run.
Most of the time, it is expected that these scripts register functions to
be called at some event in the execution of the game (see below).

### Callbacks and Proxy Objects

During the executation of the game, JS scripts are executed when some event occurs,
provided the corresponding callback function has been registered.

In these scripts, many functionalities of the game are made available through JS objects,
that are proxy to the C++ instances in the main program.

Example of a callback when a game is loaded from file

```javascript
	function onLoadCompleted(step, self, filename) {
		print("Saved game " + self.getName() + " has been loaded from " + filename);
		return 0;
	}

	jsSavedGame.registerCallback("onLoad", 1, onLoadCompleted);
```

In the function onLoadCompleted (it can have any name), we have:

- **step**: describe when the callback was triggered,

  - 0=before the event is processed (or "at start of the method") or default
  - 1=after the event is processed (or "at end of the method")

- **self**: the proxy object, in this case, the current instance of class  `SavedGame`
in the program

- **filename**: the name of the file the game is loaded from

The function has to be registered into the object that make the bridge between
the program classes and the proxy object ; in this case, it is the "jsSavedGame" object.

Logic


| -------------------------- | --------------------- | -------------------- |
| Main program               | Bridge object         | Script               |
| -------------------------- | --------------------- | -------------------- |
| SavedGame::load  {         |                       |                      |
|	// call the bridge object | | |
|	js->getObject(..."jsSavedGame"|...) |||
|	js->getMethod(..."onLoad"...) |||
|	js->callMethod(...args=[1, this, filename]...) |||
| ...                          | iterate on onLoad, step 1 | |
| }                          | register method | |
|                            | ... call(...onLoadCompleted... 1, this, filename) | |
|                            |    |  runs 'onLoadCompleted(...)' |
| -------------------------- | --------------------- | -------------------- |



## Status


1. JS engine: in src/JS, created from Game constructor (src/Engine/Game.cpp), initialized when
mod are loaded (src/Engine/Mod.cpp) and, propagated to SavedGame (src/Savegame/SavedGame.cpp).
1. Mod loading: Mod implementation enhanced to load the JS scripts (src/Mod/Mod.cpp: in loadAll + loadJS)
1. Trigger for events:

	- Game::OnQuit
	- SavedGame::load
	- SavedGame::save
	- GeoscapeState::onTime5Seconds
	- GeoscapeState::onTime10Minutes
	- GeoscapeState::onTime30Minutes
	- GeoscapeState::onTime1Hour
	- GeoscapeState::onTime1Day
	- GeoscapeState::onTime1Month
	- ...

1. Proxy classes (see src/JS): wrappers generated with swig-quickjs

	- Game
	- SavedGame
	- GameTime
	- Country + rule
	- Region + rule
	- Base (work in progress)
		- BaseFacility + rule
		- Craft + rule (and Target, MovingTarget)
		- CraftWeapon + rule
		- ResearchProject + rule
		- Production + rule (RuleManufacture, RuleItem, RuleItemCategory)
		- Soldier + rule
		- Transfer
	- GeoscapeState
	- ...


1. Bridge classes (see bin/JS/openxcom.js): bridge object for classes that
trigger events:

	- jsGame (onQuit)
	- jsSavedGame (onNew, onDelete, onLoad, onQuit, onSpawnEvent)
	- jsGeoscapeState (onTime5Seconds (and 10Minutes, 30Minutes, 1Hour, 1Day, 1Month)

1. Examples and Demos (in bin/js/...)

	- JSExample1: just print a message (validate the initialization of
	the JS Engine and the loading of JS Mods)
	- JSTraceCalls: callbacks that print a message (validate that
	all callbacks can be reached in the chain C++&nbsp;instance&nbsp;->&nbsp;Bridge&nbsp;->&nbsp;Script)

1. Tests (in bin/js/...)

	- JSTW{class}: test the wrappers of this class
	- JSTU{test}: unit test, can be on any functionality


1. Documentation

	- Wrappers are documented in docs/JSWrappers.
	- Bridge objects are documented in docs/JSScripts.
	- Example and demo mods are in bin/js/; they need
	to be manually added in the user `mods` directory and then activated.
