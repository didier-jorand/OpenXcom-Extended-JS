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
%echo "Processing TextList.i"
#endif

namespace OpenXcom
{

enum ArrowOrientation { ARROW_VERTICAL, ARROW_HORIZONTAL };

class ArrowButton;
class ComboBox;
class ScrollBar;


class TextList : public InteractiveSurface
{
public:
	/// Creates a text list with the specified size and position.
	TextList(int width, int height, int x = 0, int y = 0);
	/// Cleans up the text list.
	~TextList();

	/// Sets the X position of the surface.
	void setX(int x) override;
	/// Sets the Y position of the surface.
	void setY(int y) override;

	/// Gets the arrowsLeftEdge.
	int getArrowsLeftEdge();
	/// Gets the arrowsRightEdge.
	int getArrowsRightEdge();

	/// Unpresses the surface.
	void unpress(State *state) override;

	/// Sets the text color of a certain cell.
	void setCellColor(size_t row, size_t column, Uint8 color);
	/// Sets the text color of a certain row.
	void setRowColor(size_t row, Uint8 color);

	/// Gets the text of a certain cell.
	std::string getCellText(size_t row, size_t column) const;
	/// Sets the text of a certain cell.
	void setCellText(size_t row, size_t column, const std::string &text);

	/// Gets the X position of a certain column.
	int getColumnX(size_t column) const;
	/// Gets the Y position of a certain row.
	int getRowY(size_t row) const;

	/// Gets the height of the row text in pixels
	int getTextHeight(size_t row) const;

	/// Gets the number of lines in the wrapped text for the specified row
	int getNumTextLines(size_t row) const;

	/// Gets the amount of text in the list.
	size_t getTexts() const;
	/// Gets the amount of rows in the list.
	size_t getRowsDoNotUse() const;
	/// Gets the index of the last row in the list.
	int getLastRowIndex() const;
	/// Gets the amount of visible rows in the list.
	size_t getVisibleRows() const;

	/// Adds a new row to the text list.
	/// In JS, max 16 columns
	void addRow(int cols,
		const char *c1, const char *c2=nullptr, const char *c3=nullptr, const char *c4=nullptr,
		const char *c5=nullptr, const char *c6=nullptr, const char *c7=nullptr, const char *c8=nullptr,
		const char *c9=nullptr, const char *c10=nullptr, const char *c11=nullptr, const char *c12=nullptr,
		const char *c13=nullptr, const char *c14=nullptr, const char *c15=nullptr, const char *c16=nullptr);
	/// Removes the last row from the text list.
	void removeLastRow();

	/// Sets the columns in the text list.
	/// In JS, max 16 columns
	void setColumns(int cols,
		int c1, int c2=0, int c3=0, int c4=0, int c5=0, int c6=0, int c7=0, int c8=0,
		int c9=0, int c10=0, int c11=0, int c12=0, int c13=0, int c14=0, int c15=0, int c16=0);

	/// Sets the palette of the text list.
	void setPalette(const SDL_Color *colors, int firstcolor = 0, int ncolors = 256) override;

	/// Initializes the resources for the text list.
	void initText(Font *big, Font *small, Language *lang) override;

	/// Sets the height of the surface.
	void setHeight(int height) override;

	/// Sets the text color of the text list.
	void setColor(Uint8 color) override;
	/// Gets the text color of the text list.
	Uint8 getColor() const;

	/// Sets the secondary color of the text list.
	void setSecondaryColor(Uint8 color) override;
	/// Gets the secondary color of the text list.
	Uint8 getSecondaryColor() const;

	/// Sets the text list's wordwrap setting.
	void setWordWrap(bool wrap);

	/// Sets the text list's high contrast color setting.
	void setHighContrast(bool contrast) override;

	/// Sets the text horizontal alignment of the text list.
	void setAlign(TextHAlign align, int col = -1);
	/// Sets whether to separate columns with dots.
	void setDot(bool dot);

	/// Sets whether the list is selectable.
	void setSelectable(bool selectable);

	/// Sets the text size to big.
	void setBig();
	/// Sets the text size to small.
	void setSmall();
	/// Sets whether to condense columns instead of a table like layout.
	void setCondensed(bool condensed);

	/// Sets the background for the selector.
	void setBackground(Surface *bg);

	/// Gets the selected row in the list.
	unsigned int getSelectedRow() const;

	/// Sets the margin of the text list.
	void setMargin(int margin);
	/// Gets the margin of the text list.
	int getMargin() const;

	/// Sets the no scroll area of the text list.
	void setNoScrollArea(int left, int right);
	/// Checks if a given coordinate is inside of the no scroll area of the text list.
	bool isInsideNoScrollArea(int x);

	/// Sets the arrow color of the text list.
	void setArrowColor(Uint8 color);
	/// Sets the arrow column of the text list.
	void setArrowColumn(int pos, ArrowOrientation type);

#if 0
	/// Hooks an action handler to a mouse click on the left arrows.
	void onLeftArrowClick(ActionHandler handler);
	/// Hooks an action handler to a mouse press over the left arrows.
	void onLeftArrowPress(ActionHandler handler);
	/// Hooks an action handler to a mouse release over the left arrows.
	void onLeftArrowRelease(ActionHandler handler);
	/// Hooks an action handler to a mouse click on the right arrows.
	void onRightArrowClick(ActionHandler handler);
	/// Hooks an action handler to a mouse press over the right arrows.
	void onRightArrowPress(ActionHandler handler);
	/// Hooks an action handler to a mouse release over the right arrows.
	void onRightArrowRelease(ActionHandler handler);
#endif

	/// Clears the list.
	void clearList();

	/// Scrolls the list up.
	void scrollUp(bool toMax, bool scrollByWheel = false, size_t howMany = 1);
	/// Scrolls the list down.
	void scrollDown(bool toMax, bool scrollByWheel = false, size_t howMany = 1);
	/// Sets the list scrolling.
	void setScrolling(bool scrolling, int scrollPos = 4);

#if 0
	/// Draws the text onto the text list.
	void draw() override;
	/// Blits the text list onto another surface.
	void blit(SDL_Surface *surface) override;
	/// Thinks arrow buttons.
	void think() override;
	/// Handles arrow buttons.
	void handle(Action *action, State *state) override;
	bool isMouseCursorOverMe(State* state) const;
	/// Special handling for mouse presses.
	void mousePress(Action *action, State *state) override;
	/// Special handling for mouse releases.
	void mouseRelease(Action *action, State *state) override;
	/// Special handling for mouse clicks.
	void mouseClick(Action *action, State *state) override;
	/// Special handling for mouse hovering.
	void mouseOver(Action *action, State *state) override;
	/// Special handling for mouse hovering out.
	void mouseOut(Action *action, State *state) override;
#endif

	/// get the scroll depth
	size_t getScroll();
	/// set the scroll depth
	void scrollTo(size_t scroll);

	/// Attaches this button to a combobox.
	void setComboBox(ComboBox *comboBox);
	/// Check for a combobox.
	ComboBox *getComboBox() const;

	void setBorderColor(Uint8 color) override;

	int getScrollbarColor();
	bool isScrollbarVisible() const;

	/// Allows the cell to flood into other columns.
	void setFlooding(bool flooding);

	/// Treat separators as spaces (false) or as normal text (true)?
	void setIgnoreSeparators(bool ignoreSeparators);


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "TextList@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(TextList);

}  /* end of namespace OpenXcom */

