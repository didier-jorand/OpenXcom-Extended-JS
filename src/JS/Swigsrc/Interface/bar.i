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
%echo "Processing Bar.i"
#endif

namespace OpenXcom
{

class Bar : public Surface
{
public:

	/// Creates a new bar with the specified size and position.
	Bar(int width, int height, int x = 0, int y = 0);
	/// Cleans up the bar.
	~Bar();

	/// Sets the bar's color.
	void setColor(Uint8 color) override;
	/// Gets the bar's color.
	Uint8 getColor() const;

	/// Sets the bar's second color.
	void setSecondaryColor(Uint8 color) override;
	/// Gets the bar's second color.
	Uint8 getSecondaryColor() const;

	/// Sets the bar's scale.
	void setScale(double scale);
	/// Gets the bar's scale.
	double getScale() const;

	/// Sets the bar's maximum value.
	void setMax(double max);
	/// Gets the bar's maximum value.
	double getMax() const;

	/// Sets the bar's current value.
	void setValue(double value);
	/// Gets the bar's current value.
	double getValue() const;

	/// Sets the bar's second current value.
	void setValue2(double value);
	/// Gets the bar's second current value.
	double getValue2() const;
	/// Defines whether the second value should be drawn on top.
	void setSecondValueOnTop(bool onTop);

	/// Draws the bar.
	void draw() override;

	/// set the outline color for the bar.
	void setBorderColor(Uint8 bc) override;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Bar@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Bar);

}  /* end of namespace OpenXcom */

