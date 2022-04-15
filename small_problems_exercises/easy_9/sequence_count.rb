=begin

Problem:

input: two integers (count, starting value in sequence of multiples)
output: array (starting from starting value, proceeding through multiples until count is reached)
note: if count is 0, array should be empty
-count will always be 0 or more

Algorithm:

create empty output array
return empty array if count is 0, end method execution

use count to execute code block a number of times (1 up to count)
  multiply current counter by starting value
  move product into the output array
return output array

=end

def sequence(count, starting_value)
  output = []
  return [] if count == 0

  1.upto(count) do |counter|
    output << counter * starting_value
  end

  output
end

sequence(5, 1) == [1, 2, 3, 4, 5]
sequence(4, -7) == [-7, -14, -21, -28]
sequence(3, 0) == [0, 0, 0]
sequence(0, 1000000) == []

# LS Solution 1: very similar, just uses `count.times` and increments by the starting value

def sequence(count, first)
  sequence = []
  number = first

  count.times do
    sequence << number
    number += first
  end

  sequence
end

# LS Solution 2: uses a range to map to an array

def sequence(count, first)
  (1..count).map { |value| value * first }
end
