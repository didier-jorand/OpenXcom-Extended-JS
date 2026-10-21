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
%echo "Processing EquipmentLayoutItem.i"
#endif

namespace OpenXcom
{

class RuleInventory;

class EquipmentLayoutItem
{
public:

	/// Gets the item's type which has to be in a slot
	const RuleItem* getItemType() const;
	/// Gets the slot to be occupied
	const RuleInventory* getSlot() const;
	/// Gets the slotX to be occupied
	int getSlotX() const;
	/// Gets the slotY to be occupied
	int getSlotY() const;
	/// Gets the ammo item
	const RuleItem* getAmmoItemForSlot(int i) const;
	/// Gets the turn until explosion
	int getFuseTimer() const;
	/// Is this a fixed weapon entry?
	bool isFixed() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "EquipmentLayoutItem(%s/%d,%d)@%p",
			self->getItemType()->getName().c_str(), self->getSlotX(), self->getSlotY(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(EquipmentLayoutItem);

}  /* end of namespace OpenXcom */

