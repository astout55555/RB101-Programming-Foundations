=begin

Problem: rotate array without modifying it, move first position to last position

select all positions except first one, and then add the first position (in an array) to it

# rotating strings

break into characters
pass char array into rotate_array to return rotated array of chars
join back into string, return value

# rotating integers

break into digits (this reverses order)
  reverse array of digits back to normal
pass digit array into rotate_array to return rotated array of digits
map array onto new array of numeric string characters
join this new array into a single string
convert to integer, return value

=end

def rotate_array(array)
  array[(1..(array.size-1))] + [array[0]]
end

rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true

# LS Solution:

def rotate_array(array)
  array[1..-1] + [array[0]] # I can just create the range without finding the array size
end

## Further Exploration: now do the same for rotating letters of strings, and digits of integers

def rotate_digits(integer)
  rotate_array(integer.digits.reverse).map { |digit| digit.to_s }.join.to_i
end

rotate_digits(1234) == 2341

def rotate_string(string)
  rotate_array(string.chars).join
end

rotate_string('happy day') == 'appy dayh'

=begin

Problem: write method that rotates only the last n digits of an integer

break integer into digits and reverse to get ordered array of digits, save to variable
initialize two more variables, the unchanging first part and the last part to be manipulated
  using the second arg, define the first variable using positions 0 to -(arg + 1) # to avoid overlap
  define second variable from -arg to -1 (last position)
add the first var (sub-array) to the return of rotate_array(2nd var) (2nd sub-array), flatten and save to var
for final return value, map fully reordered array of digits onto new array of numeric string chars, join, and convert to integer

=end

def rotate_rightmost_digits(integer, ending_digits)
  all_digits = integer.digits.reverse
  left_digits = all_digits[0..-(ending_digits + 1)]
  right_digits = all_digits[-ending_digits..-1]

  rotated_digits = ([left_digits] + [rotate_array(right_digits)]).flatten
  rotated_digits.map { |digit| digit.to_s }.join.to_i
end

rotate_rightmost_digits(735291, 1) == 735291
rotate_rightmost_digits(735291, 2) == 735219
rotate_rightmost_digits(735291, 3) == 735912
rotate_rightmost_digits(735291, 4) == 732915
rotate_rightmost_digits(735291, 5) == 752913
rotate_rightmost_digits(735291, 6) == 352917

# LS Solution:

def rotate_rightmost_digits(number, n)
  all_digits = number.to_s.chars # saves code, no need to reverse
  all_digits[-n..-1] = rotate_array(all_digits[-n..-1]) # brilliant! didn't think of simply mutating that portion of the numeric string
  all_digits.join.to_i
end

=begin

Problem:

maximally rotate an integer, first rotating as normal, then rotating with the first digit fixed in place, then first two, etc., until rotating with only the last two digits unfixed

input: integer
output: maximally rotated integer (with any leading 0s dropped from the final integer as normal)

Algorithm:

I need to repeatedly feed the integer into the `rotate_rightmost_digits` method, changing `n` as I go
  from n = size of digit array (all digits) to n = 2 or n = 1 (n = 1 results in no change)

use while loop with counter, starting at size of digit array (#down_to method makes this easy)
  each loop, call `rotate_rightmost_digits` and pass it the updated integer and the value of counter for n
  save return value of this method to integer variable to update and accumulate changes
  increment counter down by 1
  break when the counter == 1

=end

def max_rotation(integer)
  (integer.digits.size).downto(2) do |i|
    integer = rotate_rightmost_digits(integer, i)
  end

  integer
end

max_rotation(735291) == 321579
max_rotation(3) == 3
max_rotation(35) == 53
max_rotation(105) == 15 # the leading zero gets dropped
max_rotation(8_703_529_146) == 7_321_609_845

## Further Exploration

=begin

Problem: solve the max_rotation problem without using the prior 2 helper methods
(would I approach it differently? does this make it easier or harder to solve?)

Additional problem: solve it in a way that can account for multiple consecutive 0s

Example:

max_rotation(100) should have a return value of 10
  100 => 001 => 010 => 10 # leading 0 dropped
however, it returns an error when it tries to run the code rotate_rightmost_digits(001, 2)
  because that means within this method we're trying to rotate `01`,
  but `01` as an integer is just `1`, which means by the time it is passed as an array to `rotate_array` it has a size of 1,
  and yet we are trying to then run the code `array[1..-1] +...` and so we end up trying to run `nil + 1`

to fix this, I'll need to do what would be more natural to me if I were just trying to solve the problem directly, rather than in stages, and solve both problems together

Algorithm:

The problem is that we're trying to change something from an integer to a string or array, manipulate this mutable object, and then convert back to an integer between steps.
Instead, we need to only convert it back to an integer at the end, after we've finished manipulating the data.

start by converting the integer into a string and then breaking into chars, save to a var (then we can manipulate the array of chars destructively)
initialize a new_num_array var as empty array
using #times based on the size of the starting array
  remove the starting element of the starting array and readd it to the end (reordering the digits)
  permanently remove the new starting element and push it into the new_num_array (saving its place as the first fixed digit)
join the new array and convert to an integer for the final return value

=end

def max_rotation(integer)
  digits = integer.to_s.chars
  new_num_array = []

  digits.size.times do
    digits << digits.shift
    new_num_array << digits.shift
  end

  new_num_array.join.to_i
end

max_rotation(100) == 10
max_rotation(1002) == 201
