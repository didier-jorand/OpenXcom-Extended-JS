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

(function () {
	// Define the callback function(s)
	let saved_game = {
		onNew: function (step, self) {
			print("(tc) SavedGame.onNew", self);
			return 0;
		},
		onDelete: function (step, self) {
			print("(tc) SavedGame.onDelete", self);
			return 0;
		},
		onLoad: function (step, self, filename) {
			print("(tc) SavedGame.onLoad", step, self, filename);
			return 0;
		},
		onSave: function (step, self, filename) {
			print("(tc) SavedGame.onSave", step, self, filename);
			return 0;
		},
		onSpawnEvent: function (step, self, event) {
			print("(tc) SavedGame.onSpawnEvent", step, self, event, event.getName());
			return 0;
		},
	};

	// Register the callback(s)
	jsSavedGame.registerCallback("onNew", 0, saved_game.onNew);
	jsSavedGame.registerCallback("onDelete", 0, saved_game.onDelete);
	jsSavedGame.registerCallback("onLoad", 0, saved_game.onLoad);
	jsSavedGame.registerCallback("onLoad", 1, saved_game.onLoad);
	jsSavedGame.registerCallback("onSave", 0, saved_game.onSave);
	jsSavedGame.registerCallback("onSave", 1, saved_game.onSave);
	jsSavedGame.registerCallback("onSpawnEvent", 1, saved_game.onSpawnEvent);
})();
