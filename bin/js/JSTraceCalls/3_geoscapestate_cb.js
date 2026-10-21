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
	let geo = {
		onTime5Seconds: function (step, self, saved_game) {
			print("(tc) GeoscapeState.onTime5Seconds " + self + " " + saved_game + " (" + step + ")");
			return 0;
		},
		onTime10Minutes: function (step, self, saved_game) {
			print("(tc) GeoscapeState.onTime10Minutes " + self + " " + saved_game + " (" + step + ") " + saved_game.getTime());
			return 0;
		},
		onTime30Minutes: function (step, self, saved_game) {
			print("(tc) GeoscapeState.onTime30Minutes " + self + " " + saved_game + " (" + step + ")");
			return 0;
		},
		onTime1Hour: function (step, self, saved_game) {
			print("(tc) GeoscapeState.onTime1Hour " + self + " " + saved_game + " (" + step + ")");
			return 0;
		},
		onTime1Day: function (step, self, saved_game) {
			print("(tc) GeoscapeState.onTime1Day " + self + " " + saved_game + " (" + step + ")");
			return 0;
		},
		onTime1Month: function (step, self, saved_game) {
			print("(tc) GeoscapeState.onTime1Month " + self + " " + saved_game + " (" + step + ")");
			return 0;
		},
	};

	// Register the callback(s)
	////jsGeoscapeState.registerCallback("onTime5Seconds", 0, JSTraceCalls_GeoscapeState.onTime5Seconds);
	////jsGeoscapeState.registerCallback("onTime10Minutes", 0, geo.onTime10Minutes);
	////jsGeoscapeState.registerCallback("onTime10Minutes", 1, geo.onTime10Minutes);
	////jsGeoscapeState.registerCallback("onTime30Minutes", 0, geo.onTime30Minutes);
	////jsGeoscapeState.registerCallback("onTime1Hour", 0, geo.onTime1Hour);
	////jsGeoscapeState.registerCallback("onTime1Hour", 1, geo.onTime1Hour);
	jsGeoscapeState.registerCallback("onTime1Day", 0, geo.onTime1Day);
	jsGeoscapeState.registerCallback("onTime1Month", 0, geo.onTime1Month);
})();
