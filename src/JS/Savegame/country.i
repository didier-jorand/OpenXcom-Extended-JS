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
 * along with OpenXcom.	If not, see <http:///www.gnu.org/licenses/>.
 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%echo "Processing Country.i"
#endif

namespace OpenXcom
{

class RuleCountry;

class Country
{
public:
	enum class Satisfaction : int { ALIEN_PACT, UNHAPPY, SATISFIED, HAPPY };

	/// Gets the country's ruleset.
	const RuleCountry *getRules() const;

	/// Gets the country's funding.
	std::vector<int> &getFunding();
	/// Sets the country's funding.
	void setFunding(int funding);

	/// get the country's satisfaction level
	Satisfaction getSatisfaction() const;

	/// add xcom activity in this country
	void addActivityXcom(int activity);
	/// add alien activity in this country
	void addActivityAlien(int activity);
	/// get xcom activity to this country
	std::vector<int> &getActivityXcom();
	/// get xcom activity to this country
	std::vector<int> &getActivityAlien();

	/// are we signing a new pact?
	bool getNewPact() const;
	/// sign a pact at the end of this month.
	void setNewPact();
	/// are we cancelling an existing pact?
	bool getCancelPact() const;
	/// cancel or prevent a pact.
	void setCancelPact();
	/// have we signed a pact?
	bool getPact() const;
	/// sign a pact immediately
	void setPact();
	/// can be (re)infiltrated?
	bool canBeInfiltrated();


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "Country@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertPtr(Country);

}  /* end of namespace OpenXcom */

