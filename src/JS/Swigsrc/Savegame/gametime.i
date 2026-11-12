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
%echo "Processing GameTime.i"
#endif

namespace OpenXcom {

class Language;

enum TimeTrigger { TIME_5SEC, TIME_10MIN, TIME_30MIN, TIME_1HOUR, TIME_1DAY, TIME_1MONTH };

class GameTime
{
public:
	GameTime(int weekday, int day, int month, int year, int hour, int minute, int second);
	~GameTime();

	bool isLastDayOfMonth();
	int getSecond() const;
	int getMinute() const;
	int getHour() const;
	int getWeekday() const;

	std::string getWeekdayString() const;
	int getDay() const;
	std::string getDayString(Language *lang) const;
	int getMonth() const;
	std::string getMonthString() const;
	int getYear() const;
	std::string getFullString() const;
	double getDaylight() const;

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		return strdup(self->getFullString().c_str());
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif
};

JSConvertPtr(GameTime);

}
