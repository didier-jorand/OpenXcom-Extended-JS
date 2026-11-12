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
%echo "Processing Timer.i"
#endif

namespace OpenXcom
{
class State;
class Surface;

class Timer
{
public:
	/// Creates a stopped timer.
	Timer(Uint32 interval, bool frameSkipping = false);
	/// Cleans up the timer.
	~Timer();

	/// Starts the timer.
	void start();
	/// Stops the timer.
	void stop();

	/// Gets the current time interval.
	Uint32 getTime() const;
	/// Gets if the timer's running.
	bool isRunning() const;

	/// Advances the timer.
	void think(State* state, Surface* surface);

	/// Sets the timer's interval.
	void setInterval(Uint32 interval);

#if 0
	// XXX (todo): callback
	/// Hooks a state action handler to the timer interval.
	void onTimer(StateHandler handler);
	/// Hooks a surface action handler to the timer interval.
	void onTimer(SurfaceHandler handler);
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Timer@%p (running:%d)", self, self->isRunning());
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Timer);

}  /* end of namespace OpenXcom */

