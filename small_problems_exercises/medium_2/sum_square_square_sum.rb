=begin

Problem:

find the difference between the square of sums and sum of sqaures of the first n positive integers
  i.e. the square of the sum of the first n positive integers minus the sum of the squares of the first n positive integers

input: positive integer
output: positive integer or 0

Example:

sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)

Data/Algorithm:

calculate the square of sum, save to var
calculate the sum of squares, save to var

subtract sum of squares from the square of sums to get final value

=end

def sum_square_difference(integer)
  square_of_sum = (1..integer).sum**2
  sum_of_squares = (1..integer).reduce {|sum, n| sum + n*n} # works because 1*1 would be 1 anyway

  square_of_sum - sum_of_squares
end

p sum_square_difference(3) == 22
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150

# LS Solution: could be applied to a different range without issue, not starting at 1

def sum_square_difference(n)
  sum = 0
  sum_of_squares = 0

  1.upto(n) do |value|
    sum += value # both values are calculated as the iteration occurs
    sum_of_squares += value**2
  end

  sum**2 - sum_of_squares # sum is squared at the end before subtracting sum_of_squares
end
