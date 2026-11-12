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
%echo "Processing ItemContainer.i"

%template(RuleItemPIntMap) std::map<const OpenXcom::RuleItem*, int>;
%template(RuleItemPVector) std::vector<const OpenXcom::RuleItem*>;
#endif


namespace OpenXcom
{

class ItemContainer
{
public:
	/// Adds an item to the container.
	void addItem(const std::string &id, int qty = 1) = delete;
	/// Adds an item to the container.
	void addItem(const RuleItem* item, int qty = 1);

	/// Removes an item from the container.
	void removeItem(const std::string &id, int qty = 1);
	/// Removes an item from the container.
	void removeItem(const RuleItem* item, int qty = 1);

	/// Gets an item in the container.
	int getItem(const std::string &id) const;
	/// Gets an item in the container.
	int getItem(const RuleItem* item) const;

	/// Gets the total quantity of items in the container.
	int getTotalQuantity() const;
	/// Gets the total size of items in the container.
	double getTotalSize() const;

	/// Check if have any item
	bool empty() const { return _qty.empty(); }

	/// Clear all content.
	void clear();

	/// Gets all the items in the container.
	const std::map<const RuleItem*, int> *getContents() const;


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "ItemContainer@%p", self);
		return strdup(buffer);
	}

	const std::vector<const OpenXcom::RuleItem*> getItems() const {
		std::vector<const OpenXcom::RuleItem*> v;
		const std::map<const OpenXcom::RuleItem*, int> *contents = self->getContents();

		for (auto it = contents->begin(); it != contents->end(); it++) {
			v.push_back((*it).first);
		}
		return v;
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ItemContainer);

}  /* end of namespace OpenXcom */

