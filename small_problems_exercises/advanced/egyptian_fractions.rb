=begin

Full Problem: write two methods
  one to find the denominators of egyptian fractions representing a rational number
  one to find the rational number which would be the sum of the egyptian fractions

Problem 1:

input: 2 integers, the first representing the numerator and the second the denominator
output: an array of integers, each representing the denominator of an egyptian fraction
  all the egyptian fractions together must add up to the same value as
    the rational number represented by the 2 arguments provided
  the numerator for egyptian fractions is always 1
  no repeat denominators allowed

Algorithm:

I will apply the "greedy algorithm", repeatedly finding the largest egyptian fraction
available, which is not larger than the remainder after subtracting the last one. i.e.:

keep it clean by using Rational to be exact, no floats

result array = []

initialize `remainder` = arg 1
loop with a counter (starting at 1) which is the potential denominator
  if arg 2/counter <= remainder
    results << counter
    remainder -= arg2/counter
    break once remainder == 0

return result array

Problem 2:

input: an array of integers, each representing the denominator of an egyptian fraction
output: the rational number which would be the result of summing the egyptian fractions

iterate through array with memo, summing all rational numbers formed by 1/e

=end

require 'pry-byebug'

def egyptian(rational_number)
  results = []

  numerator = rational_number.numerator
  denominator = rational_number.denominator

  remainder = numerator
  egyptian_denominator = 0

  loop do
    egyptian_denominator += 1
    division = Rational(denominator, egyptian_denominator)

    if (division <= remainder)
      results << egyptian_denominator
      remainder -= division
      break if remainder == 0
    end
  end

  results
end

def unegyptian(array_of_egyptian_denominators)
  array_of_egyptian_denominators.reduce(0) do |sum, denominator|
    sum += Rational(1, denominator)
  end
end

egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

# These all print true
p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)

## LS Solution: uses clearer labels and math for #egyptian

def egyptian(target_value)
  denominators = [] # labels the output.
  unit_denominator = 1
  until target_value == 0 # builds the break into the loop setup.
    unit_fraction = Rational(1, unit_denominator) # doesn't mess with the original N/D,
    if unit_fraction <= target_value # just subtracts the rational number from the total
      target_value -= unit_fraction # if it's small enough, and then adds the egyptian
      denominators << unit_denominator # denominator to the results array.
    end # my method used more roundabout math because I was initially trying to solve it
# without using `Rational` beyond the initial assignment of the num and denom.
    unit_denominator += 1
  end

  denominators
end

def unegyptian(denominators)
  denominators.inject(Rational(0)) do |accum, denominator|
    accum + Rational(1, denominator)
  end
end
