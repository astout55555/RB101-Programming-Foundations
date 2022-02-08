=begin

input: numberic string
output: integer
cannot use Integer() or #to_i

Examples:

string_to_integer('4321') == 4321
string_to_integer('570') == 570

break string into characters
iterate through array of characters
  use case statement to map string digits onto integer digits
  return integer equivalents in new array
iterate through new array, adding components together modified by decimal position
return sum

=end

def string_to_integer(numeric_string)
  string_array = numeric_string.chars
  integer_array = string_array.map do |char|
    case char
    when '0' then 0
    when '1' then 1
    when '2' then 2
    when '3' then 3
    when '4' then 4
    when '5' then 5
    when '6' then 6
    when '7' then 7
    when '8' then 8
    when '9' then 9
    end
  end

  integer_equivalent = 0
  integer_array.reverse.each_with_index do |digit, index|
    integer_equivalent += digit * 10**index
  end
  integer_equivalent
end

## Further Exploration

=begin

input: hexadecimal formatted string
output: integer value
i.e. create a method that does what String#hex does

hexadecimal is base 16, using 0-9 plus A-F to represent 16 possible digits
e.g. F = decimal 15

Example:

hexadecimal_to_integer('4D9f') == 19871

I can expand the previous solution to include translations for
A-F (i.e. 10-15) in addition to the other options, because even though
'A' gets swapped with 10, which has two digits,
my use of #each_with_index is operating with each element, not actually
each digit (as if I were to join them like a string).
however, I will also need to change the digit value adjustment
so that it is going up by base 16 instead of base 10,
which I think can be done with `16**index`

=end

def hexadecimal_to_integer(hexadecimal_string)
  string_array = hexadecimal_string.chars
  integer_array = string_array.map do |char|
    char.upcase! # added to make sure lower case letters don't raise an error
    case char
    when '0' then 0
    when '1' then 1
    when '2' then 2
    when '3' then 3
    when '4' then 4
    when '5' then 5
    when '6' then 6
    when '7' then 7
    when '8' then 8
    when '9' then 9
    when 'A' then 10
    when 'B' then 11
    when 'C' then 12
    when 'D' then 13
    when 'E' then 14
    when 'F' then 15
    end
  end

  decimal_equivalent = 0
  integer_array.reverse.each_with_index do |integer, index|
    decimal_equivalent += integer * 16**index
  end
  decimal_equivalent
end

# the above works but I have to include the whole case statement within the method definition
# official solution recommends working with a separate hash with mapped values instead

DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, 
  '4' => 4, '5' => 5, '6' => 6, '7' => 7,
  '8' => 8, '9' => 9, 'A' => 10, 'B' => 11,
  'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15 # added the hex letter options here
}

def dec_or_hex_string_to_integer(string, base=10) # I'm modifying to work for both types
  return nil if base != 10 && base != 16

  digits = string.chars.map { |char| DIGITS[char.upcase] } # updated to work with letters

  value = 0
  digits.each { |digit| value = base * value + digit } # slight modification to work for either hex or dec
  value
end

p dec_or_hex_string_to_integer('4D9f', 16) == 19871
p dec_or_hex_string_to_integer('4321') == 4321
p dec_or_hex_string_to_integer('234', 12) == nil
puts 'End of part 1 exercises/tests.'


### Convert a String to a Signed Number!

