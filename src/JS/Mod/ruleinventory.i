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
%echo "Processing RuleInventory.i"
#endif

namespace OpenXcom
{

struct RuleSlot
{
	int x, y;
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleSlot(%d,%d)@%p", self->x, self->y, self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif
};

enum InventoryType { INV_SLOT, INV_HAND, INV_GROUND };


class RuleInventory
{
public:

	/// Gets the inventory's id.
	const std::string& getId() const;
	/// Gets the X position of the inventory.
	int getX() const;
	/// Gets the Y position of the inventory.
	int getY() const;
	/// Gets the inventory type.
	InventoryType getType() const;
	/// Gets if this slot is right hand;
	bool isRightHand() const;
	/// Gets if this slot is left hand;
	bool isLeftHand() const;
	/// Gets all the slots in the inventory.
	const std::vector<struct RuleSlot> *getSlots() const;
	/// Checks for a slot in a certain position.
	bool checkSlotInPosition(int *x, int *y) const;
	/// Checks if an item fits in a slot.
	bool fitItemInSlot(const RuleItem *item, int x, int y) const;
	/// Gets a certain cost in the inventory.
	int getCost(const RuleInventory *slot) const;
	int getListOrder() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleInventory(%s/(%d,%d)@%p",
			self->getId().c_str(), self->getX(), self->getY(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleInventory);

}  /* end of namespace OpenXcom */

