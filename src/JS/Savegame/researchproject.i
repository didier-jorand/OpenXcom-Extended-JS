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
%echo "Processing ResearchProject.i"
#endif

namespace OpenXcom
{


class ResearchProject
{
public:
	/// get the ResearchProject Mod
	const RuleResearch * getRules() const;

	/// Game logic. Called every new day to compute time spent.
	bool step();

	/// gets state of project.
	bool isFinished() const;

	/// set the number of scientist assigned to this ResearchProject
	void setAssigned (int nb);
	/// get the number of scientist assigned to this ResearchProject
	int getAssigned() const;

	/// get time already spent on this ResearchProject
	int getSpent() const;
	/// set time already spent on this ResearchProject
	void setSpent (int spent);
	/// get time cost of this ResearchProject

	int getCost() const;
	/// set time cost of this ResearchProject
	void setCost(int f);

	/// Get a string describing current progress.
	std::string getResearchProgress() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		const OpenXcom::RuleResearch *r = self->getRules();
		snprintf(buffer, 128, "ResearchProject(%s)@%p", r->getName().c_str(), self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(ResearchProject);

}  /* end of namespace OpenXcom */

