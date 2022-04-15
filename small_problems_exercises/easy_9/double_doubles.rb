=begin

Problem:

A double number is a number with an even number of digits whose left-side digits are exactly the same as its right-side digits.
For example, 44, 3333, 103103, 7676 are all double numbers. 444, 334433, and 107 are not.

Write a method that returns 2 times the number provided as an argument, unless the argument is a double number; double numbers should be returned as-is.

input: integer
output: doubled integer, unless it meets conditions for being a 'double number', in which case return original integer

Algorithm:

convert integer to string

if string length is even then break into array of chars
  create empty left half and right half arrays
  iterate through chars with index
    push into left or right arrays based on index
  compare left and right arrays
    if equal, return original integer
    otherwise return doubled integer
if not even then return doubled integer

=end

def twice(num)
  output = num
  string = num.to_s

  if string.length.even?
    digits = string.chars
    left_half = []
    right_half = []

    digits.each_with_index do |digit, index|
      if index < string.length / 2
        left_half << digit
      else
        right_half << digit
      end
    end

    if left_half != right_half
      output *= 2
    end
  
  else
    output *= 2
  end

  output
end

twice(37) == 74
twice(44) == 44
twice(334433) == 668866
twice(444) == 888
twice(107) == 214
twice(103103) == 103103
twice(3333) == 3333
twice(7676) == 7676
twice(123_456_789_123_456_789) == 123_456_789_123_456_789
twice(5) == 10

# LS Solution - I thought mine was overly complicating things somehow with all the conditional branching!

def twice(number)
  string_number = number.to_s
  center = string_number.size / 2 # first, find the center point of the string, then you can use it to create a range for the substrings for left and right sides!
  left_side = center.zero? ? '' : string_number[0..center - 1] # just make sure to check that the string isn't a single character. this works because with integer division, 1 / 2 == 0
  right_side = string_number[center..-1] # (I also didn't know about the #zero? method, to be fair)

  return number if left_side == right_side # if we use this method, we don't have to check if the number has an even number of digits--the sides won't match anyway if it doesn't!
  return number * 2 # using an explicit return in the line above means that the method will terminate early before it gets here if the condition is met
end
