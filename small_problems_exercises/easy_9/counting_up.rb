=begin

Problem:

input: positive integer
output: array of all integers between (and including) 1 and the integer provided, in order

Algorithm:

create empty results array
use #upto to count from 1 to the provided integer
  push each current integer into the array
return the array

=end

def sequence(int)
  result = []

  1.upto(int) { |current_int| result << current_int }

  result
end

sequence(5) == [1, 2, 3, 4, 5]
sequence(3) == [1, 2, 3]
sequence(1) == [1]

# LS Solution:

def sequence(number)
  (1..number).to_a # I forgot about #to_a, this is definitely simpler
end

## Further Exploration: alter method to account for when we are given a number 0 or less

def sequence(number)
  if number > 0
    (1..number).to_a
  elsif number < 0
    (number..-1).to_a
  else
    [0]
  end
end

sequence(5) == [1, 2, 3, 4, 5]
sequence(-3) == [-3, -2, -1]
sequence(0) == [0]
sequence(1) == [1]
sequence(-1) == [-1]
