=begin

Problem:

input: integer representing a year after 1752
output: integer representing total number of Friday the 13ths in that year

Data/Algorithm:

start by calling a new Date object using the provided year, for Jan 1st, save to date var
also initialize var at 0 to count F13ths

then, in a loop
  break if it is Friday
  otherwise reassign the date var to the next day

now that we're on a Friday, in a loop
  increment the date var by 7 days
  check if the year is still the original year (break if not)
  check if it's a F13th, and increment the F13th count if so

return the value of the F13th counter var

=end

require 'date'

def friday_13th(year)
  friday_13ths = 0
  date = Date.new(year, 1, 1)

  date = date.next until date.friday?

  while date.year == year
    friday_13ths += 1 if date.mday == 13
    date = date.next_day(7)
  end

  friday_13ths
end

p friday_13th(2015) == 3
p friday_13th(1986) == 1
p friday_13th(2019) == 2

# LS Solution: only checks the 13ths instead of every Friday, simpler

require 'date'

def friday_13th(year)
  unlucky_count = 0
  thirteenth = Date.civil(year, 1, 13)
  12.times do
    unlucky_count += 1 if thirteenth.friday?
    thirteenth = thirteenth.next_month
  end
  unlucky_count
end

## Further Exploration: count the number of months with 5 Fridays

# for this, I can start the same way, with a counter at 0, and finding the first Friday
# I can set up a loop like before, moving through all the Fridays of the year
#   in this loop, I should increment the counter only when a Friday occurs on day 29-31
# I then end by returning the counter

def fifth_fridays(year)
  fifth_fridays = 0
  date = Date.new(year, 1, 1)
  date = date.next until date.friday?

  while date.year == year
    fifth_fridays += 1 if date.mday >= 29
    date = date.next_day(7)
  end

  fifth_fridays
end

p fifth_fridays(2020) == 4
p fifth_fridays(2021) == 5
p fifth_fridays(2036) == 4 # leap year with 5 Fridays in Feb
