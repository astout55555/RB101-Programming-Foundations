=begin

Problem:

input: non-empty string
output: 1 or 2 chars from the center, depending on if string length is odd or even

Algorithm:

use conditional
  if string length is odd, return char from index of length / 2 (integer division)
  if string length is even, return char from index of length / 2 - 1 and also from length / 2

=end

def center_of(string)
  midpoint = string.length / 2

  if string.length.even?
    string[midpoint - 1] + string[midpoint] # LS Solution uses `string[midpoint - 1, 2]` because you can specify the length of the substring after the starting index
  else
    string[midpoint]
  end
end

center_of('I love ruby') == 'e'
center_of('Launch School') == ' '
center_of('Launch') == 'un'
center_of('Launchschool') == 'hs'
center_of('x') == 'x'
