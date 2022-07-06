=begin

Problem:

featured number = an odd number, multiple of 7, with no repeat digits

input: integer
output: integer (the next featured number which is higher than the input)
        -or return an error if there is no possible featured number after the input

Examples:

49 is featured, 97, 98, and 133 are not
there is no possible featured number once we go beyond 10 digits
  and also beyond whatever the last featured number was before that

Data/Algorithm:

in a loop, starting from the argument integer
  increment by 1
  return error if number > 9,999,999,999
  next unless current number is odd
  next unless current number is divisible by 7
  next unless the number of unique digits is equal to the number of digits
  if all conditions were met, return the current number
  
=end

def featured(integer)
  loop do
    integer += 1
    return "Error, no possible featured numbers." if integer.digits.size > 10
    next unless integer.odd?
    next unless integer % 7 == 0
    next unless integer.digits.size == integer.digits.uniq.size
    return integer
  end
end

p featured(12) == 21
p featured(20) == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
p featured(999_999) == 1_023_547
p featured(999_999_987) == 1_023_456_987

p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements

# LS Solution:

# first finds an odd number which is a multiple of 7, which allows them to increment by 14
# this saves a lot of computing time. my own solution took several seconds to return the last one before the error

def featured(number)
  number += 1
  number += 1 until number.odd? && number % 7 == 0

  loop do
    number_chars = number.to_s.split('')
    return number if number_chars.uniq == number_chars
    number += 14
    break if number >= 9_876_543_210 # highest possible number with no repeat digits (not actually featured)
  end

  'There is no possible number that fulfills those requirements.'
end
