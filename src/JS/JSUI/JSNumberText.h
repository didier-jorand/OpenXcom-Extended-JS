#pragma once
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenXcom.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "../../Interface/NumberText.h"

namespace OpenXcom
{

namespace JSUI
{

/**
 * JS Proxy class for Interface/NumberText
 */
class JSNumberText : public NumberText
{
public:
	/// Creates a new proxy for a number text with the specified size and position.
	JSNumberText(int width, int height, int x = 0, int y = 0);
	/// Cleans up the number text.
	~JSNumberText();
};

}

}
