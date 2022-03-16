=begin

# Problem:

write method that calculates and returns index of first Fibonacci number
with the number of digits specified by an argument

input: integer (greater than or equal to 2)
output: integer

Algorithm:

use loop to increment by appropriate value to follow Fibonacci sequence
  use counter to count index on each loop
  each loop store the resulting value
  each loop count the digits in the value
  break if it is equal to the input
return value of counter before break

=end

def find_fibonacci_index_by_length(specified_length)
  first_value = 1
  second_value = 1
  fibonacci_index = 3

  loop do
    fibonacci_value = first_value + second_value
    length = fibonacci_value.digits.size
    break if length >= specified_length
    
    first_value = second_value
    second_value = fibonacci_value
    fibonacci_index += 1
  end

  fibonacci_index
end

p find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
p find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
p find_fibonacci_index_by_length(10) == 45
p find_fibonacci_index_by_length(100) == 476
p find_fibonacci_index_by_length(1000) == 4782
p find_fibonacci_index_by_length(10000) == 47847
