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
%echo "Processing Production.i"
#endif

namespace OpenXcom
{

enum productionProgress_e { PROGRESS_NOT_COMPLETE, PROGRESS_COMPLETE, PROGRESS_NOT_ENOUGH_MONEY, PROGRESS_NOT_ENOUGH_MATERIALS, PROGRESS_NOT_ENOUGH_LIVING_SPACE, PROGRESS_MAX, PROGRESS_CONSTRUCTION };

class Production
{
public:
	const RuleManufacture * getRules() const;

	int getAmountTotal() const;
	void setAmountTotal (int);

	bool getInfiniteAmount() const;
	void setInfiniteAmount (bool);

	int getTimeSpent() const;
	void setTimeSpent (int);

	bool isQueuedOnly() const;

	int getAmountProduced() const;

	int getAssignedEngineers() const;
	void setAssignedEngineers (int);

	bool getSellItems() const;
	void setSellItems (bool);

	bool isFallback() const;
	void setFallback(bool newValue);

#if 0
	productionProgress_e step(Base * b, SavedGame * g, const Mod *m, Language *lang);
	void startItem(Base * b, SavedGame * g, const Mod *m) const;
	void refundItem(Base * b, SavedGame * g, const Mod *m) const;
#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		const OpenXcom::RuleManufacture *r = self->getRules();
		snprintf(buffer, 128, "Production(%s)@%p", r->getName().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Production);

}  /* end of namespace OpenXcom */

