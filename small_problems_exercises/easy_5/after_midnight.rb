### Part 1

=begin

input: positive or negative integer, or 0 (minutes away from midnight)
output: time of day in hh:mm format
note that if the integer is greater than the minutes in the day,
output should be the result as this carries into the next day

work with integers
return 00:00 if integer is 0

find total value of minutes from midnight minus minutes in day
  this is the minutes away from the most recent midnight

divide total by minutes in day to find remainder to calculate new day/time
  divide this remainder to find hours and minutes (remainder is minutes)

format hours and minutes separately
concatenate hours and minutes in format while converting to strings

=end

def time_of_day(minutes_from_midnight)  
  minutes_in_day = 1440
  minutes_from_closest_midnight = minutes_from_midnight.divmod(1440)[1]
  
  hours, minutes = minutes_from_closest_midnight.divmod(60)
  
  hh = hours.to_s.rjust(2, '0')
  mm = minutes.to_s.rjust(2, '0')

  "#{hh}:#{mm}"
end

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"
p time_of_day(1440) == "00:00"
