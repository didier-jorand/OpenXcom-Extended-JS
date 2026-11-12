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
%echo "Processing ImageButton.i"
#endif

namespace OpenXcom
{

class ImageButton : public InteractiveSurface
{
public:
	/// Creates a new image button with the specified size and position.
	ImageButton(int width, int height, int x = 0, int y = 0);
	/// Cleans up the image button.
	virtual ~ImageButton();

	/// Sets the image button's color.
	void setColor(Uint8 color) override;
	/// Gets the image button's color.
	Uint8 getColor() const;

	%extend {
	/// Sets the image button's group.
	%newobject setGroup;
	ImageButton **setGroup(ImageButton **group) {
		printf("ImageButton::setGroup: %p (%p)\n", group, self);
		if (group == nullptr) {
			group = (OpenXcom::ImageButton**)malloc(sizeof(OpenXcom::ImageButton*));
			printf("\t1: group=%p, *group=%p\n", group, *group);
			self->setGroup(group);
		} else {
			*group = self;
			printf("\t2: group=%p, *group=%p\n", group, *group);
			self->setGroup(group);
		}
		return group;
	}
	}

#if 0
	/// Special handling for mouse presses.
	void mousePress(Action *action, State *state) override;
	/// Special handling for mouse releases.
	void mouseRelease(Action *action, State *state) override;
#endif

	/// Invert a button explicitly either ON or OFF.
	void toggle(bool invert);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "ImageButton@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ImageButton);

}  /* end of namespace OpenXcom */

