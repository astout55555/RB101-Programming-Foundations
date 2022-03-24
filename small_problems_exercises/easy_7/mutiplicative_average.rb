=begin

# Problem: 
input: (non-empty) array of integers
output: integer (result of multiplying all integers and then dividing total by size of array)
Rules:
-print results to 3 decimal places

# Algorithm:

initialize result variable at 1.0
iterate through array
  result *= each number to get total multiplicative value
divide result by array size to get end result
format to float with precision of 3 after decimal point

=end

def show_multiplicative_average(array)
  # result = 1.0
  # array.each {|integer| result *= integer}
  # result = (result / array.size)

  result = array.inject(1.0, :*) / array.size # using Enumberable#inject is a powerful way to refactor the above code

  format("%.3f", result)
end

p show_multiplicative_average([3, 5])                # => The result is 7.500
p show_multiplicative_average([6])                   # => The result is 6.000
p show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667
