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
%echo "Processing Action.i"
#endif

namespace OpenXcom
{
class InteractiveSurface;

class Action
{
public:
#if 0
	/// Creates an action with given event data.
	Action(SDL_Event *ev, double scaleX, double scaleY, int topBlackBand, int leftBlackBand);
	/// Cleans up the action.
	~Action();
#endif

	/// Gets the screen's X scale.
	double getXScale() const;
	/// Gets the screen's Y scale.
	double getYScale() const;

	/// Sets the action as a mouse action.
	void setMouseAction(int mouseX, int mouseY, int surfaceX, int surfaceY);
	/// Gets if the action is a mouse action.
	bool isMouseAction() const;

	/// Gets the top black band height.
	int getTopBlackBand() const;
	/// Gets the left black band width.
	int getLeftBlackBand() const;
	/// Gets the mouse's X position.
	int getXMouse() const;
	/// Gets the mouse's Y position.
	int getYMouse() const;
	/// Gets the mouse's absolute X position.
	double getAbsoluteXMouse() const;
	/// Gets the mouse's absolute Y position.
	double getAbsoluteYMouse() const;
	/// Gets the mouse's relative X position.
	double getRelativeXMouse() const;
	/// Gets the mouse's relative Y position.
	double getRelativeYMouse() const;

	/// Gets the sender of the action.
	InteractiveSurface *getSender() const;
	/// Sets the sender of the action.
	void setSender(InteractiveSurface *sender);

#if 0
	/// Gets the details of the action.
	SDL_Event *getDetails() const;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Action@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Action);

}  /* end of namespace OpenXcom */

