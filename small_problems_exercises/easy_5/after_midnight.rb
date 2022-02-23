### Part 1

=begin

input: positive or negative integer, or 0 (minutes away from midnight)
output: time of day in hh:mm format
note that if the integer is greater than the minutes in the day,
output should be the result as this carries into the next day

work with integers

divide total minutes by minutes in a day, remainder is standardized minutes after midnight (less than 1 day away)

divide total by minutes in day to find remainder to calculate new day/time
  divide this remainder to find hours and minutes (remainder is minutes)

format hours and minutes separately
concatenate hours and minutes in format while converting to strings

=end

MINUTES_PER_DAY = 24 * 60

def time_of_day(minutes_from_midnight)  
  minutes_after_most_recent_midnight = minutes_from_midnight.divmod(MINUTES_PER_DAY)[1]
  
  hours, minutes = minutes_after_most_recent_midnight.divmod(60)
  
  hh = hours.to_s.rjust(2, '0')
  mm = minutes.to_s.rjust(2, '0')

  "#{hh}:#{mm}"
end

time_of_day(0) == "00:00"
time_of_day(-3) == "23:57"
time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"
time_of_day(1440) == "00:00"

## Further Exploration:

# Problem one: already solved by my original code above, using % operator to normalize minutes into the 0-1439 range
# This is because the % (modulo) operator, used in #divmod, calls #floor on the result of the division,
# which means that if only one of the operators in the division is negative,
# the quotient will be rounded down to a lower negative number,
# such that the result of the modulo operation would be the opposite of the result of a remainder operation
# after "overshooting" the division, and then needing to go up or down to reach the total with the remainder

# Problem two: how should I approach this problem if I can use Date and Time classes?
# Problem three: ...and include day of week in calculation, assuming starting point is midnight between Sat/Sun

=begin

2 problems: find day of week (new), and find time of day (previously solved using other methods)
new condition: must use Date and Time classes to solve (may need to change old solution)

input: total minutes away from a specific midnight, -/+ to show direction
output: day of week and time of day, formatted

Examples:

time_of_day(0) == "Sunday, 00:00"
time_of_day(-3) == "Saturday, 23:57"
time_of_day(35) == "Sunday, 00:35"
time_of_day(-1437) == "Saturday, 00:03"
time_of_day(3000) == "Tuesday, 02:00"
time_of_day(800) == "Sunday, 13:20"
time_of_day(-4231) == "Thursday, 01:29"
time_of_day(1440) == "Monday, 00:00"

Data/Algorithm:

create a new Time object, matched to Sunday midnight (between Sat/Sun), save as variables
change Time object based on inputted minutes (add them as seconds * 60)
check weekday value, store in variable as string based on value
check hour, minute, store as variables
convert stored variable values to formatted output



=end


def day_of_week_and_time(minutes_from_sat_sun_midnight)
  time_and_day = Time.new(2022, 2, 27, 0, 0)
  time_and_day += (minutes_from_sat_sun_midnight * 60)

  day_of_week = case time_and_day.wday
                when 0 then "Sunday"
                when 1 then "Monday"
                when 2 then "Tuesday"
                when 3 then "Wednesday"
                when 4 then "Thursday"
                when 5 then "Friday"
                else "Saturday"
                end

  hours = time_and_day.hour
  minutes = time_and_day.min
  
  hh = hours.to_s.rjust(2, '0')
  mm = minutes.to_s.rjust(2, '0')

  "#{day_of_week}, #{hh}:#{mm}"
end

day_of_week_and_time(0) == "Sunday, 00:00"
day_of_week_and_time(-3) == "Saturday, 23:57"
day_of_week_and_time(35) == "Sunday, 00:35"
day_of_week_and_time(-1437) == "Saturday, 00:03"
day_of_week_and_time(3000) == "Tuesday, 02:00"
day_of_week_and_time(800) == "Sunday, 13:20"
day_of_week_and_time(-4231) == "Thursday, 01:29"
day_of_week_and_time(1440) == "Monday, 00:00"


### After Midnight (Part 2)

=begin

write two methods, returning either minutes before or after midnight
input: time of day in 24 hour format (string)
output: 0..1439 (for each) (integer)
condition: cannot use Date or Time

Data/Algorithm:

convert inputted string to integers, store in hour and minute variables
0 and 24 for hours need to be equivalent in output, use divmod to ensure
for "after" method, simply convert values to minutes and add together
for "before" method, subtract total from minutes in a day to see difference from midnight
  use divmod to avoid ending up with full day minutes instead of 0
output final integer value

=end

def after_midnight(string_time_24_hr_format)
  hours, minutes = string_time_24_hr_format.split(':') # can chain `.map(&:to_i)` to convert to integers at the same time
  hours = hours.to_i.divmod(24)[1] # can simply use `% 24` if I just want this value, no need to use #divmod
  minutes = minutes.to_i

  (hours * 60) + minutes
end

def before_midnight(string_time_24_hr_format)
  hours, minutes = string_time_24_hr_format.split(':')
  hours = hours.to_i.divmod(24)[1]
  minutes = minutes.to_i

  minutes_after = (hours * 60) + minutes # can simply call #after_midnight(param) instead of repeating all the above lines
  (MINUTES_PER_DAY - minutes_after).divmod(MINUTES_PER_DAY)[1] # use `% MINUTES_PER_DAY` instead of #divmod
end

after_midnight('00:00') == 0
before_midnight('00:00') == 0
after_midnight('12:34') == 754
before_midnight('12:34') == 686
after_midnight('24:00') == 0
before_midnight('24:00') == 0

## Further Exploration: Try again using Date or Time class

=begin

start by splitting input string into hours and minutes integers again
use modulo 24 to normalize value of hours
create new Time object based these values
create a second Time object based on the start of the same day
subtract the second from the first to get the seconds after midnight
convert to minutes and output

for #before method use the #after method to start
then convert using the total minutes in a day like before
  don't forget to use `% MINUTES_PER_DAY` to avoid getting value of 1440 instead of 0

=end

def after_midnight(string_time_24_hr_format)
  hours, minutes = string_time_24_hr_format.split(':').map(&:to_i)
  hours = hours % 24
  given_time = Time.new(2022, 2, 27, hours, minutes)
  start_of_day = Time.new(2022, 2, 27)
  seconds_after_midnight = given_time - start_of_day
  seconds_after_midnight.to_i / 60
end

def before_midnight(string_time_24_hr_format)
  minutes_after = after_midnight(string_time_24_hr_format)
  (MINUTES_PER_DAY - minutes_after) % MINUTES_PER_DAY
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0
