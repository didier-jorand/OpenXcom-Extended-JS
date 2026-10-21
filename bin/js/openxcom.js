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

/// \file

/// \mainpage
/// openxcom.js defines the objects and their methods that are used from the main program
/// as callbacks when some actions or events occur.
///
/// For script writers, predefined "mirror" objects are defined (jsGame,
/// jsSavedGame, etc...) and the script just needs to register callbacks on
/// the event it want to act on.
///
/// Script:
///
/// `function doSomethingWhenASavedFileIsLoaded(step, self, filename) {...}`
///
/// `savedGame.registerCallback("onLoad", 0, doSomethingWhenASavedFileIsLoaded);`
///

/// The class CBObject specifies a JS object that registers the
/// callbacks to be triggered by the corresponding instance in
/// the application.
///
/// The callbacks are defined by a trigger (the method name in the
/// mirrored class, for instance SavedGame::load => onLoad), a step
/// which is either 0 (unique or call at method start) or 1, for
/// a call at method end (if there is also a call at method start).
///
/// When activated, the callback receives parameters from
/// the caller, that always includes the runtime instance (called 'self') and
/// "relevant" parameter(s). For instance, SavedGame::load adds
/// the filename to the callback.
///
class CBObject {
	constructor() {
		this._callbacks = {};
	}

	/// \public
	/// This is the _public_ interface for script writers, to
	/// register the functions they want to be called when the "triggered"
	/// event occur in the game.
	/// @param trigger Name of the triggering event, like onNew, onLoad
	/// @param step at which the callback would be activated
	/// - 0 for default or start of the function
	/// - 1 for end of the function
	/// @param cb Javascript function to be called when the event occurs
	registerCallback(trigger, step, cb) {
		//OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "CBObject::registerCallback " + this.constructor.name + "." + trigger + "@" + step + " " + cb);
		if (typeof(cb) != "function") {
			OpenXcom.JSLog(OpenXcom.LOG_WARNING, "CBObject::registerCallback: not a function: " + cb + " in " + this.constructor.name);
			return;
		}
		if (typeof(step) != "number") {
			step = 0;
		} else {
			step = Math.round(step);
		}
		if (!this._callbacks[trigger]) this._callbacks[trigger] = {};
		if (!this._callbacks[trigger][step]) this._callbacks[trigger][step] = [];
		this._callbacks[trigger][step].push(cb);
	}

	/// \public
	/// This is the _public_ interface for script writers, to
	/// unregister a function that was previously registered as
	/// a callback.
	/// @param trigger Name of the triggering event, like onNew, onLoad
	/// @param step at which the callback would be activated
	/// - 0 for default or start of the function
	/// - 1 for end of the function
	/// @param cb Javascript function to be called when the event occurs
	/// Note: if there is no match for trigger, trigger+step or trigger+step+cb
	/// the function just does nothing (no error reported)
	///
	unregisterCallback(trigger, step, cb) {
		//OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "CBObject::unregisterCallback " + this.constructor.name + "." + trigger + "@" + step + " " + cb);
		if (typeof(cb) != "function") {
			OpenXcom.JSLog(OpenXcom.LOG_WARNING, "CBObject::unregisterCallback: not a function: " + cb + " in " + this.constructor.name);
			return;
		}
		if (typeof(step) != "number") {
			step = 0;
		} else {
			step = Math.round(step);
		}
		if (!this._callbacks[trigger]) {
			OpenXcom.JSLog(OpenXcom.LOG_WARNING, "CBObject::unregisterCallback: unknown trigger '" + trigger + "' in " + this.constructor.name);
			return;
		}
		if (!this._callbacks[trigger][step]) {
			OpenXcom.JSLog(OpenXcom.LOG_WARNING, "CBObject::unregisterCallback: unknown trigger step '" + trigger + "." + step + "' in " + this.constructor.name);
			return;
		}
		let cbs = this._callbacks[trigger][step];
		let idx = cbs.indexOf(cb);
		if (idx >= 0) {
			cbs.splice(idx, 1);
		} else {
			OpenXcom.JSLog(OpenXcom.LOG_WARNING, "CBObject::unregisterCallback: unknown callback for '" + trigger + "." + step + "' in " + this.constructor.name);
		}
	}

	/// \protected
	/// This is the internal method that perform the call to the callback
	/// when the monitored event occurs.
	callCallbacks(trigger, ...args) {
		//OpenXcom.JSLog(OpenXcom.LOG_VERBOSE,  "callCallbacks: " + this.constructor.name + "."  + trigger + " " + args);
		let step = args[0];
		if (this._callbacks[trigger] && this._callbacks[trigger][step]) {
			let cbs = this._callbacks[trigger][step];
			for (let i in cbs) {
				cbs[i].apply(this, args);
			}
		}
	}
}

/// This class implements the mirror of the
/// [Game](https://github.com/didier-jorand/OpenXcom-Extended-JS/blob/oxce-plus/src/Engine/Game.h) class
/// It implements the following events:
/// - onQuit: triggered when the game is about to quit.
class Game extends CBObject {
	constructor() {
		super();
	}

	/// \public
	/// This method is called from Game::quit (end of), no code returned.
	///
	/// It is triggered when the game (as application) is about to exit.
	///
	/// `step` is 0 and `self` is the Game instance.
	/// No other parameter.
	///
	/// It triggers all callbacks registered in object jsGame with trigger="onQuit"
	/// and step=0.
	onQuit(step, self) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "Game::onQuit");
		this.callCallbacks("onQuit", step, self);
		return 0;
	}
};

var jsGame = new Game();
///< Instance of the Game class made available to script writers
///< to register their callbacks on the Game class.

/// This class implements the mirror of the
/// [SavedGame](https://github.com/didier-jorand/OpenXcom-Extended-JS/blob/oxce-plus/src/Savegame/SavedGame.h) class
/// It implements the following events:
/// - onNew: triggered when a new game is created (at end).
/// - onDelete: triggered when the game is deleted (at start).
/// - onLoad: triggered when a game is loaded (at start and at end).
/// - onSave: triggered when the game is saved (at start and at end).
class SavedGame extends CBObject {
	constructor() {
		super();
	}

	/// \public
	/// This method is called from SavedGame::SavedGame (end of), no code returned.
	///
	/// It is triggered when a new game is created.
	///
	/// `step` is 0 and `self` is the SavedGame instance.
	/// No other parameter.
	///
	/// It triggers all callbacks registered in object jsSavedGame with trigger="onNew"
	/// and step=0.
	onNew(step, self) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "SavedGame:onNew");
		this.callCallbacks("onNew", step, self);
		return 0;
	}

	/// \public
	/// This method is called from SavedGame::~SavedGame (start of), no code returned.
	///
	/// It is triggered when the current game is deleted.
	///
	/// `step` is 0 and `self` is the SavedGame instance.
	/// No other parameter.
	///
	/// It triggers all callbacks registered in object jsSavedGame with trigger="onDelete"
	/// and step=0.
	onDelete(step, self) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "SavedGame:onDelete");
		this.callCallbacks("onDelete", step, self);
		return 0;
	}

	/// \public
	/// This method is called from SavedGame::load (start of and end of), no code returned.
	///
	/// It is triggered when a saved game is loaded from disk.
	///
	/// @param step Step in the calling method: 0=start of the load or 1=load is complete
	/// @param self the SavedGame instance
	/// @param filename Full path of the file to be loaded
	///
	/// It triggers all callbacks registered in object jsSavedGame with trigger="onLoad"
	/// and step=0 or 1.
	onLoad(step, self, filename) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "SavedGame:onLoad");
		this.callCallbacks("onLoad", step, self, filename);
		return 0;
	}

	/// \public
	/// This method is called from SavedGame::save (start of and end of), no code returned.
	///
	/// It is triggered when a saved game is saved to disk.
	///
	/// @param step Step in the calling method: 0=start of the load or 1=load is complete
	/// @param self the SavedGame instance
	/// @param filename Full path of the file to save into
	///
	/// It triggers all callbacks registered in object jsSavedGame with trigger="onSave"
	/// and step=0 or 1.
	onSave(step, self, filename) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "SavedGame:onSave");
		this.callCallbacks("onSave", step, self, filename);
		return 0;
	}

	/// \public
	/// This method is called from SavedGame::spawnEvent (start of and end of), no code returned.
	///
	/// It is triggered when a geoscape event is triggered on the game.
	///
	/// @param step Step in the calling method: 0=start of the load or 1=load is complete
	/// @param self the SavedGame instance
	/// @param event the rule RuleEvent instance
	///
	/// It triggers all callbacks registered in object jsSavedGame with trigger="onSpawnEvent"
	/// and step=0 or 1.
	onSpawnEvent(step, self, event) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "SavedGame:onSpawnEvent");
		print("######################################## onSpawnEvent");
		this.callCallbacks("onSpawnEvent", step, self, event);
		return 0;
	}

};
var jsSavedGame = new SavedGame();
///< Instance of the SavedGame class made available to script writers
///< to register their callbacks on the SavedGame class.


/// This class implements the mirror of the
/// [GeoscapeState](https://github.com/didier-jorand/OpenXcom-Extended-JS/blob/oxce-plus/src/Geoscape/GeoscapeState.h) class
/// It implements the following events:
/// - onNew: triggered when a new game is created (at end).
/// - onDelete: triggered when the game is deleted (at start).
/// - onLoad: triggered when a game is loaded (at start and at end).
/// - onSave: triggered when the game is saved (at start and at end).
/// - onTime10Minutes(): triggered every 10 minutes
/// - onTime30Minutes() : triggered every 30 minutes
/// - onTime1Hour(): triggered every hour
/// - onTime1Day(): triggered every day
/// - onTime1Month(): triggered every month (on day 1)
class GeoscapeState extends CBObject {
	constructor() {
		super();
	}

	/// \public
	/// This method is called from GeoscapeState::time5Seconds (start of), no code returned.
	///
	/// It is triggered when 5 'virtual' seconds have passed.
	///
	/// @param step Step in the calling method: 0=start of the method or 1=end of the method
	/// @param self The GeoscapeState instance
	/// @param saved_game The current SavedGame object
	///
	/// It triggers all callbacks registered in object jsGeoscapeState with trigger="onTime5Seconds"
	/// and step=0.
	onTime5Seconds(step, self, saved_game) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "GeoscapeState:onTime5Seconds");
		this.callCallbacks("onTime5Seconds", step, self, saved_game);
		return 0;
	}

	/// \public
	/// This method is called from GeoscapeState::time10Minutes (start of and end of), no code returned.
	///
	/// It is triggered when 10 'virtual' minutes have passed.
	///
	/// @param step Step in the calling method: 0=start of the method or 1=end of the method
	/// @param self The GeoscapeState instance
	/// @param saved_game The current SavedGame object
	///
	/// It triggers all callbacks registered in object jsGeoscapeState with trigger="onTime10Minutes"
	/// and step=0 or 1.
	onTime10Minutes(step, self, saved_game) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "GeoscapeState:onTime10Minutes");
		this.callCallbacks("onTime10Minutes", step, self, saved_game);
		return 0;
	}

	/// \public
	/// This method is called from GeoscapeState::time30Minutes (start of and end of), no code returned.
	///
	/// It is triggered when 30 'virtual' minutes have passed.
	///
	/// @param step Step in the calling method: 0=start of the method or 1=end of the method
	/// @param self The GeoscapeState instance
	/// @param saved_game The current SavedGame object
	///
	/// It triggers all callbacks registered in object jsGeoscapeState with trigger="onTime30Minutes"
	/// and step=0 or 1.
	onTime30Minutes(step, self, saved_game) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "GeoscapeState:onTime30Minutes");
		this.callCallbacks("onTime30Minutes", step, self, saved_game);
		return 0;
	}

	/// \public
	/// This method is called from GeoscapeState::time1Hour (start of and end of), no code returned.
	///
	/// It is triggered when 1 'virtual' hour has passed.
	///
	/// @param step Step in the calling method: 0=start of the method or 1=end of the method
	/// @param self The GeoscapeState instance
	/// @param saved_game The current SavedGame object
	///
	/// It triggers all callbacks registered in object jsGeoscapeState with trigger="onTime1Hour"
	/// and step=0 or 1.
	onTime1Hour(step, self, saved_game) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "GeoscapeState:onTime1Hour");
		this.callCallbacks("onTime1Hour", step, self, saved_game);
		return 0;
	}

	/// \public
	/// This method is called from GeoscapeState::time1Day (start of and end of), no code returned.
	///
	/// It is triggered when 1 'virtual' day has passed.
	///
	/// @param step Step in the calling method: 0=start of the method or 1=end of the method
	/// @param self The GeoscapeState instance
	/// @param saved_game The current SavedGame object
	///
	/// It triggers all callbacks registered in object jsGeoscapeState with trigger="onTime1Day"
	/// and step=0 or 1.
	onTime1Day(step, self, saved_game) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "GeoscapeState:onTime1Day");
		this.callCallbacks("onTime1Day", step, self, saved_game);
		return 0;
	}

	/// \public
	/// This method is called from GeoscapeState::time1Month (start of and end of), no code returned.
	///
	/// It is triggered when 1 'virtual' month has passed.
	///
	/// @param step Step in the calling method: 0=start of the method or 1=end of the method
	/// @param self The GeoscapeState instance
	/// @param saved_game The current SavedGame object
	///
	/// It triggers all callbacks registered in object jsGeoscapeState with trigger="onTime1Month"
	/// and step=0 or 1.
	onTime1Month(step, self, saved_game) {
		OpenXcom.JSLog(OpenXcom.LOG_VERBOSE, "GeoscapeState:onTime1Month");
		this.callCallbacks("onTime1Month", step, self, saved_game);
		return 0;
	}
};
var jsGeoscapeState = new GeoscapeState();
///< Instance of the GeoscapeState class made available to script writers
///< to register their callbacks on the GeoscapeState class.
