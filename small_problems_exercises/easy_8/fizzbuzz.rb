=begin

Problem:
input: two arguments (integers)
output: print all numbers between/including the two provided, replacing those divisible by 3 with 'Fizz', those divisible by 5 with 'Buzz', and those divisible by both 3 and 5 with 'FizzBuzz'

Algorithm: 

use inputted integers to create a range and iterate through it
  use conditional statement starting with divisibility by 3 and 5, followed by other conditions (3 or 5 only)
    else print the current integer itself
  also print ', ' unless it's the last iteration
  if it is the last iteration, print a newline

=end

def fizzbuzz(start_int, end_int)
  start_int.upto(end_int) do |current_int|
    if current_int % (3 * 5) == 0
      print 'FizzBuzz'
    elsif current_int % 3 == 0
      print 'Fizz'
    elsif current_int % 5 == 0
      print 'Buzz'
    else
      print current_int
    end

    print ', ' unless current_int == end_int
    puts '' if current_int == end_int
  end
end

fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz
