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
	let game = {
		_ui: null,

		initTest: function (self, testid) {
			//print("(UI) Game.initTest" + testid, self);

			game[testid] = new OpenXcom.JSUI.JSState();
			game[testid]._window = new OpenXcom.JSUI.JSWindow(game[testid], 320, 200, 0, 0, OpenXcom.POPUP_NONE);
			game[testid]._txtInfo = new OpenXcom.JSUI.JSText(256, 40, 32, 20, OpenXcom.JSUI.JSUI_EVENT_NONE);
			game[testid]._btnClose = new OpenXcom.JSUI.JSTextButton(100, 16, 212, 176, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);

			game[testid].setInterface("mainMenu"); // Set palette
			game[testid].add_rs(game[testid]._window, "window", "mainMenu", null);
			game[testid].add_rs(game[testid]._txtInfo, "text", "mainMenu", null);
			game[testid].add_rs(game[testid]._btnClose, "button", "mainMenu", null);
			//game[testid].centerAllSurfaces();

			game[testid].setWindowBackground(game[testid]._window, "mainMenu");

			game[testid]._btnClose.setText(game[testid].tr("STR_OK").std_str());
			game[testid]._btnClose.mouseClick = () => { self.popState(); }

			game[testid]._txtInfo.setAlign(OpenXcom.ALIGN_CENTER);
			game[testid]._txtInfo.setSmall();
			game[testid]._txtInfo.setWordWrap(true);
			game[testid]._txtInfo.setText("UI Test " + testid + ": common part (template)");

			//self.pushState(game[testid]);
			return game[testid];
		},

		onTestButton: function (self) {
			let ui = game.initTest(self, "Button");
			ui._txtInfo.setText("UI Test: demonstrate the different types of buttons");

			ui._count = 0;
			ui._btnCounter = new OpenXcom.JSUI.JSTextButton(100, 16, 10, 60, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);
			ui._btnCounter.setText('Never clicked');
			ui.add_rs(ui._btnCounter, "button", "mainMenu", null);
			ui._btnCounter.mouseClick = () => { ui._btnCounter.setText("Clicked " + ++ui._count + " times"); }

			ui._btnToggle = new OpenXcom.JSUI.JSToggleTextButton(100, 16, 170, 60, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._btnToggle.setText('Toggle me');
			ui.add_rs(ui._btnToggle, "button", "mainMenu", null);

			ui._btnLeft = new OpenXcom.JSUI.JSArrowButton(OpenXcom.ARROW_SMALL_LEFT, 12, 9, 25, 100, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._btnUp = new OpenXcom.JSUI.JSArrowButton(OpenXcom.ARROW_SMALL_UP, 12, 9, 40, 100, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._btnDown = new OpenXcom.JSUI.JSArrowButton(OpenXcom.ARROW_SMALL_DOWN, 12, 9, 55, 100, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._btnRight = new OpenXcom.JSUI.JSArrowButton(OpenXcom.ARROW_SMALL_RIGHT, 12, 9, 70, 100, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui.add_rs(ui._btnLeft, "button", "mainMenu", null);
			ui.add_rs(ui._btnUp, "button", "mainMenu", null);
			ui.add_rs(ui._btnDown, "button", "mainMenu", null);
			ui.add_rs(ui._btnRight, "button", "mainMenu", null);

			ui._btnBigUp = new OpenXcom.JSUI.JSArrowButton(OpenXcom.ARROW_BIG_UP, 12, 16, 25, 160, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._btnBigDown = new OpenXcom.JSUI.JSArrowButton(OpenXcom.ARROW_BIG_DOWN, 12, 16, 40, 160, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui.add_rs(ui._btnBigUp, "button", "mainMenu", null);
			ui.add_rs(ui._btnBigDown, "button", "mainMenu", null);

			// XXX don't work...
			ui._group = ui._btnBigUp.setGroup(null);
			print("Group " + ui._group);
			ui._btnBigDown.setGroup(ui._group);

			ui.centerAllSurfaces();

			self.pushState(ui);
		},

		onTestBar: function (self) {
			let ui = game.initTest(self, "Bar");
			ui._txtInfo.setText("UI Test: demonstrate bars, progress bar and slider...");

			//ui._frame = new OpenXcom.JSUI.JSFrame(...);

			// Change color according to slider1
			ui._bar1 = new OpenXcom.JSUI.JSBar(100, 12, 10, 60);
			ui._bar1.setScale(1.0);
			ui._bar1.setMax(255.0);
			ui._bar1.setValue(80.0);
			ui._bar1.setValue2(33.0);
			ui._bar1.setColor(1);
			ui._bar1.setSecondaryColor(4);
			ui.add(ui._bar1);

			// Display the numeric value of the color in a number text
			ui._numtext1 = new OpenXcom.JSUI.JSNumberText(40, 12, 120, 60);
			ui.add(ui._numtext1);

			ui._slider1 = new OpenXcom.JSUI.JSSlider(100, 12, 10, 80, OpenXcom.JSUI.JSUI_EVENT_CHANGE);
			ui._slider1.setRange(0, 255);
			ui._slider1.setValue(80);
			ui._slider1.setColor(2);
			ui.add(ui._slider1);
			ui._slider1.change = (z) => {
				ui._bar1.setColor(ui._slider1.getValue());
				ui._bar1.setSecondaryColor((ui._slider1.getValue() + 3) % 256);
				ui._numtext1.setValue(ui._slider1.getValue());
			};


			// Change value according to slider2
			ui._bar2 = new OpenXcom.JSUI.JSBar(100, 12, 10, 100);
			ui._bar2.setScale(1.0);
			ui._bar2.setMax(100.0);
			ui._bar2.setValue(80.0);
			ui._bar2.setColor(2);
			ui.add(ui._bar2);

			ui._slider2 = new OpenXcom.JSUI.JSSlider(100, 12, 10, 120, OpenXcom.JSUI.JSUI_EVENT_CHANGE);
			ui._slider2.setRange(0, 100);
			ui._slider2.setValue(80);
			ui._slider2.setColor(2);
			ui.add(ui._slider2);
			ui._slider2.change = (z) => {
				ui._bar2.setValue(ui._slider2.getValue());
				ui._pbar3.setValue(ui._slider2.getValue());
			};

			// Also follows slider2
			ui._pbar3 = new OpenXcom.JSUI.JSProgressBar(100, 12, 10, 140);
			ui._pbar3.setValue(80.0);
			ui._pbar3.setColor(32);
			ui.add(ui._pbar3);

			ui.centerAllSurfaces();

			self.pushState(ui);
		},

		onTestText: function (self) {
			let ui = game.initTest(self, "Text");
			ui._txtInfo.setText("UI Test: demonstrate the JSText, JSNumberText and JSEdit widgets");

			ui._txtTest = new OpenXcom.JSUI.JSText(140, 120, 10, 60, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._editTest = new OpenXcom.JSUI.JSTextEdit(ui, 140, 40, 170, 60, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._txtNumTest = new OpenXcom.JSUI.JSNumberText(140, 60, 170, 90);

			ui.add_rs(ui._txtTest, "text", "mainMenu", null);
			ui.add_rs(ui._editTest, "text", "mainMenu", null);
			ui.add_rs(ui._txtNumTest, "text", "mainMenu", null);
			ui.centerAllSurfaces();

			ui._txtTest.setAlign(OpenXcom.ALIGN_LEFT);
			//ui._txtTest.setBig();
			ui._txtTest.setWordWrap(true);
			ui._txtTest.setText("Text Widget demonstrattion\nLine 1\nLine 2\nQuite a very long line, longer than the others lines (wrapped)\n...");

			ui._editTest.setAlign(OpenXcom.ALIGN_LEFT);
			ui._editTest.setBig();
			ui._editTest.setWordWrap(true);
			ui._editTest.setText("Edit here...");

			ui._txtNumTest.setValue(999);
			//ui._txtNumTest.setBordered(true);

			self.pushState(ui);
		},

		onTestComboBox: function (self) {
			let ui = game.initTest(self, "ComboBox");
			ui._txtInfo.setText("UI Test: demonstrate the JSComboBox widget (in a JSFrame)");

			// add a frame
			ui._frameTest = new OpenXcom.JSUI.JSFrame(220, 30, 5, 55);

			// define the combo box
			ui._comboboxTest = new OpenXcom.JSUI.JSComboBox(ui, 100, 20, 10, 60, OpenXcom.JSUI.JSUI_EVENT_CHANGE);
			// Add a text to display the selected option
			ui._text1 = new OpenXcom.JSUI.JSText(100, 20, 120, 60);

			ui.add(ui._frameTest);
			ui.add_rs(ui._comboboxTest, "text", "mainMenu", null);
			ui.add_rs(ui._text1, "text", "mainMenu", null);
			ui.centerAllSurfaces();

			ui._frameTest.setColor(48);
			ui._frameTest.setSecondaryColor(51);

			ui._comboboxTest.setColor(79);

			v = new openxcom.StringVector();
			v.add("Option 1");
			v.add("Option 2");
			v.add("Option 3");
			v.add("Option 4");
			ui._comboboxTest.setOptions(v);
			ui._comboboxTest.change = () => {
				ui._text1.setText("" + ui._comboboxTest.getSelected() + ": " + v.get(ui._comboboxTest.getSelected()));
			}

			self.pushState(ui);
		},

		onTestTextList: function (self) {
			let ui = game.initTest(self, "TextList");
			ui._txtInfo.setText("UI Test: demonstrate the JSTextList widget");

			// define the text list
			let tl = new OpenXcom.JSUI.JSTextList(310, 120, 5, 50, OpenXcom.JSUI.JSUI_EVENT_NONE);
			ui._textlistTest = tl;

			ui.add_rs(tl, "text", "mainMenu", null);
			ui.centerAllSurfaces();

			tl.setColumns(4, 50, 70, 80, 80);
			tl.setColor(79);
			tl.setDot(true);
			tl.setBackground(ui._window);
			tl.setSelectable(true);

			tl.addRow(4, "Row 1", "ABCD", "EFGH", "OpenXcom");
			tl.addRow(4, "Row 2", "TWO", "IJKL", "TFTD");

			self.pushState(ui);
		},


		onQuit: function (step, self) {
			if (game._ui) {
				// already called once, exit
				return false;
			}

			print("(UI) Game.onQuit ('first')" /*, step, self, OpenXcom.JSUI*/);

			game._ui = new OpenXcom.JSUI.JSState();
			game._ui._window = new OpenXcom.JSUI.JSWindow(game._ui, 256, 160, 32, 20, OpenXcom.POPUP_BOTH);
			game._ui._btnTestText	= new OpenXcom.JSUI.JSTextButton(92, 20, 64, 40, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);
			game._ui._btnTestBar	= new OpenXcom.JSUI.JSTextButton(92, 20, 164, 40, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);
			game._ui._btnTestButton	= new OpenXcom.JSUI.JSTextButton(92, 20, 64, 68, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);
			game._ui._btnTestComboBox= new OpenXcom.JSUI.JSTextButton(92, 20, 164, 68, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);
			game._ui._btnTestTextList= new OpenXcom.JSUI.JSTextButton(92, 20, 64, 96, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);
			game._ui._btnQuit 		= new OpenXcom.JSUI.JSTextButton(92, 20, 164, 146, OpenXcom.JSUI.JSUI_EVENT_MOUSE_CLICK);

			game._ui._btnTestText.mouseClick = () => { game.onTestText(self); }
			game._ui._btnTestBar.mouseClick = () => { game.onTestBar(self); }
			game._ui._btnTestButton.mouseClick = () => { game.onTestButton(self); }
			game._ui._btnTestComboBox.mouseClick = () => { game.onTestComboBox(self); }
			game._ui._btnTestTextList.mouseClick = () => { game.onTestTextList(self); }
			game._ui._btnQuit.mouseClick = () => { self.quit(); }

			// Set palette
			game._ui.setInterface("mainMenu");

			game._ui.add_rs(game._ui._window, "window", "mainMenu", null);
			game._ui.add_rs(game._ui._btnTestText, "button", "mainMenu", null);
			game._ui.add_rs(game._ui._btnTestBar, "button", "mainMenu", null);
			game._ui.add_rs(game._ui._btnTestButton, "button", "mainMenu", null);
			game._ui.add_rs(game._ui._btnTestComboBox, "button", "mainMenu", null);
			game._ui.add_rs(game._ui._btnTestTextList, "button", "mainMenu", null);
			game._ui.add_rs(game._ui._btnQuit, "button", "mainMenu", null);

			game._ui.centerAllSurfaces();

			game._ui.setWindowBackground(game._ui._window, "mainMenu");

			//print("Translation: STR_QUIT=" + game._ui.tr("STR_QUIT"));
			game._ui._btnTestText.setText("UI Test: Texts");
			game._ui._btnTestBar.setText("UI Test: Bars");
			game._ui._btnTestButton.setText("UI Test: Buttons");
			game._ui._btnTestComboBox.setText("UI Test: ComboBox");
			game._ui._btnTestTextList.setText("UI Test: TextList");
			game._ui._btnQuit.setText(game._ui.tr("STR_QUIT").std_str());

			self.setState(game._ui);

			return true;
		},

	}
	// Register the callback(s)
	jsGame.registerCallback("onQuit", 0, game.onQuit);
})();

