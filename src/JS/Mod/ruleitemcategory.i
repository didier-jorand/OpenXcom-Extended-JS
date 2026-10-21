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
%echo "Processing RuleItemCategory.i"
#endif

namespace OpenXcom
{

class RuleItemCategory
{
public:

	/// Gets the item category type.
	const std::string &getType() const;
	/// Gets the item category type, which should be used instead of this one.
	const std::string &getReplaceBy() const;
	/// Indicates whether the category is hidden or visible.
	bool isHidden() const;
	/// Get the list weight for this item category.
	int getListOrder() const;
	/// Gets the inventory slot order to be used for auto-equip and ctrl-click-equip.
	const std::vector<std::string>& getInvOrder() const;


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "RuleItemCategory(%s)@%p", self->getType().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(RuleItemCategory);

}  /* end of namespace OpenXcom */

