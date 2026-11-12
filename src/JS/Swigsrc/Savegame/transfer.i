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
%echo "Processing Transfer.i"
#endif

namespace OpenXcom
{

class Base;
class Craft;

enum TransferType { TRANSFER_ITEM, TRANSFER_CRAFT, TRANSFER_SOLDIER, TRANSFER_SCIENTIST, TRANSFER_ENGINEER };

class Transfer
{
public:

	/// Gets the type of the transfer.
	TransferType getType() const;
	/// Gets the name of the transfer.
	std::string getName(Language *lang) const;

	/// Sets the soldier of the transfer.
	void setSoldier(Soldier *soldier);
	/// Gets a pointer to the soldier being transferred.
	Soldier *getSoldier();

	/// Sets the craft of the transfer.
	void setCraft(Craft *craft);
	/// Gets the craft of the transfer.
	Craft *getCraft();

	/// Gets the items of the transfer.
	const RuleItem* getItems() const;
	/// Sets the items of the transfer.
	void setItems(const RuleItem* rule, int qty = 1);

	/// Sets the scientists of the transfer.
	void setScientists(int scientists);

	/// Sets the engineers of the transfer.
	void setEngineers(int engineers);

	/// Gets the hours remaining of the transfer.
	int getHours() const;
	/// Gets the quantity of the transfer.
	int getQuantity() const;

	/// Advances the transfer.
	void advance(Base *base);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		static const char *tt[] = {"item", "craft", "soldier", "scientist", "enginner" };
		char buffer[128];
		snprintf(buffer, 128, "Transfer(%s: %d)@%p", tt[self->getType()], self->getQuantity(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Transfer);

}  /* end of namespace OpenXcom */

