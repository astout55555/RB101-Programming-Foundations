=begin

input: integer (year)
output: true or false (depending on if it is a leap year)

Examples:

leap_year?(2016) == true
leap_year?(2015) == false
leap_year?(2100) == false
leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == false
leap_year?(1) == false
leap_year?(100) == false
leap_year?(400) == true

work with integers
follow conditional flow matched to gregorian calendar rules
return true if all conditions met, false if otherwise

=end

def first_attempt_leap_year?(year)
  if year % 4 == 0
    if year % 100 == 0 && year % 400 != 0
      return false
    end
    true
  else
    false
  end
end

=begin

# official solutions, utilize Ruby's automatic evaluation to save code
# also starts with least common cases first, allows a more straight-forward progression
# since if the former is true then the latter would have been true too

def leap_year?(year)
  if year % 400 == 0
    true
  elsif year % 100 == 0
    false
  else
    year % 4 == 0
  end
end

# even shorter:

def leap_year?(year)
  (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
end

=end

## Further Exploration: for what years will leap_year? fail if we use:

def bad_leap_year?(year)
  if year % 100 == 0 # we've swapped order of 100 and 400
    false
  elsif year % 400 == 0 # this never evaluates because the 100 check triggers
    true
  else
    year % 4 == 0
  end
end # in the end, this will fail for years divisible by 400

# solution with the reverse order of official solution:
# this is basically what I did, except combine steps 2 and 3
# more complicated than starting with the least common and most overlapping condition (400)


### Leap Years Part 2

# update previous solution to account for Julian Calendar before 1752

def leap_year?(year)
  return true if year < 1752 && year % 4 == 0 # could also include as a first clause of the main if/else statement
  if year % 400 == 0
    true
  elsif year % 100 == 0
    false
  else
    year % 4 == 0
  end
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == true
p leap_year?(1) == false
p leap_year?(100) == true
p leap_year?(400) == true
# all return true
