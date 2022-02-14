### Convert a Number to a String

=begin

input: integer
rules: don't use any standard conversion method
output: numeric string

use hash with key value pairs of digits and string equivalents
break number into digits array
reverse to match written order
iterate over array, matching digit to character, adding to output variable
output numeric string

=end

NUMERIC_CHARACTERS = {
  0 => '0', 1 => '1', 2 => '2', 3 => '3',
  4 => '4', 5 => '5', 6 => '6',
  7 => '7', 8 => '8', 9 => '9'
}

def integer_to_string(integer)
  digits = integer.digits.reverse
  string = ''
  digits.each do |digit|
    string << NUMERIC_CHARACTERS[digit]
  end
  string
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'


### Convert a Signed Number to a String

=begin

input: positive or negative integer (or 0)
rules: may use #integer_to_string from above
output: numeric string with '+' or '-' sign

account for negatives or 0 first
use conditional flow to return '+' + result
  '-' + absolute value of result
  or 0

=end

def signed_integer_to_string(integer)
  if integer > 0
    '+' + integer_to_string(integer)
  elsif integer < 0
    '-' + integer_to_string(-integer)
  else
    '0'
  end
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'

# Official Solution uses case statement and <=> operator

def signed_integer_to_string(number)
  case number <=> 0
  when -1 then "-#{integer_to_string(-number)}"
  when +1 then "+#{integer_to_string(number)}"
  else         integer_to_string(number)
  end
end

## Further Exploration: Refactor this to just call integer_to_string once

def signed_integer_to_string(number)
  case number <=> 0
  when -1 then sign = '-'
  when +1 then sign = '+'
  else         return '0'
  end
  absolute_number = number.abs
  sign + integer_to_string(absolute_number)
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'
# still works, all print true
