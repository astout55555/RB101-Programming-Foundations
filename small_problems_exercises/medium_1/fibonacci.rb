### Part 1: Recursion

=begin

Problem: write a method using recursion that computes the nth fibonacci number, where n is the argument to the method

the fibonacci sequence can be represented by the following:

F(1) = 1
F(2) = 1
F(n) = F(n - 1) + F(n - 2) where n > 2

(F can be replaced with the method I need to write)

input: positive integer
output: positive integer (matching number from the fibonacci sequence)

Algorithm:

(high level)
since recursion is required, I need to:
1. modify the argument provided and pass it on to the same method called within itself
2. establish a condition which stops the recursion, but otherwise continue the cycle
3. use each result of calling itself to calculate the total and return the fibonacci number (integer)

establish return condition for when the argument provided (n) is 1 or 2
  return 1 if n is 1 or 2
otherwise (if n > 2)
  use recursion to calculate result, finding F(n-1) + F(n-2)

=end

def fibonacci(int)
  return 1 if int <= 2
  fibonacci(int - 1) + fibonacci(int - 2)
end

fibonacci(1) == 1
fibonacci(2) == 1
fibonacci(3) == 2
fibonacci(4) == 3
fibonacci(5) == 5
fibonacci(12) == 144
fibonacci(20) == 6765

### Part 2: Procedural

=begin

Ruby is not designed for heavy recursion, and even a more advanced method of recursion fails after about 8200

Problem: Rewrite the recursive solution so that it computes its results without recursion

input: positive integer
output: positive integer (the fibonacci sequence number at nth position)

Algorithm:

create an empty array to hold fibonacci numbers as we count up to nth
use a loop that uses a counter and goes through the provided arg (nth)
  if the counter is at 1 or 2, push counter into array, increment counter
  if counter is at 3 or higher, push the sum of the two most recent array elements into the array, increment counter
return the final element in the array

=end

def fibonacci(nth)
  fib_numbers = []

  counter = 0
  while counter < nth
    if counter < 2
      fib_numbers << 1
      counter += 1
    else
      fib_numbers << (fib_numbers[counter - 1] + fib_numbers[counter - 2])
      counter += 1
    end
  end

  fib_numbers.last
end

fibonacci(20) == 6765
fibonacci(100) == 354224848179261915075
fibonacci(100_001) # => 4202692702.....8285979669707537501

# LS Solution:

def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do # doesn't run unless nth is >= 3
    first, last = [last, first + last] # use multiple assignment to update the array for every integer after 2
  end

  last
end

### Part 3: Last Digit

=begin

Problem: write method that returns the last digit of the fibonacci number

Algorithm:

very simple if we call the old method within this one
call #fibonacci and break its return value into digits, then return the first digit in the array (the last in the number)

Problem 2: rewrite the solution to calculate the last digit in a reasonable timeframe (a few seconds or less)

the solution takes too long to calculate as we get up into the higher numbers (several seconds for 1_000_007 and several minutes--or more?-- for 123456789)
this means I will have to find the last digit without finding the full fibonacci number, and so without calling #fibonacci within #fibonacci_last

first, I should take a look at the last digit for when nth is between 1 and 100, look for a pattern...
results: the last digit is always the last digit of the sum of the previous two last digits
  fibonacci_last(24) => 8; fibonacci_last(25) => 5; fibonacci_last(26) => 3 -- (8 + 5 = 13, last digit 3)
    (this is because it's simply how addition works, any extra carries over to other places in the number)
  not seeing any other pattern I can make use of though, e.g. the last digit in nth doesn't yield any consistent final digit in the output

Algorithm 2:

simply modify the old fibonacci method so that we take the remainder after % 10 rather than the full number as we calculate
however, even though this prevents us from having to work with large numbers, it still adds an additional operation, and still takes a little while to calculate

=end

def fibonacci_last(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, (first + last) % 10]
  end

  last
end

# fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
# fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
# fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
# fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
# fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
# fibonacci_last(123456789) # -> 4 (calculates after several seconds)

## Further Exploration:

# Problem: how can we modify the solution further so that it is even more efficient, capable of calculating the last digit of 123,456,789,987,745 => 5 ?

# I wasn't sure how to figure this one out and eventually looked at other student solutions. This one was well explained:

# "
# The key to computing the last digit quickly is knowing that the sequence of last digits will repeat at a set interval.
# Then all you need to do is determine how long it takes until the sequence repeats, and use that knowledge to compute the last digit for any number.
# It's possible to solve this, though, without any knowledge of how long it takes until the sequence repeats (every 60 #s).
# Instead, I computed the repeating sequence with a helper method, and then used this repeating slice to determine the last digit for any number (with a bit of modulus work):

def fibonacci_last_fast(n)
  fibonacci_repeating_sequence = determine_fibonacci_repeating_sequence
  index = (n - 1) % fibonacci_repeating_sequence.length # [my note] the length is 60, since the sequence last digits repeat after 60 instances
  fibonacci_repeating_sequence[index]
end

# Determine the repeated pattern in the fibonacci sequence
def determine_fibonacci_repeating_sequence
  last_digits = [1, 1]
  loop do
    next_last_digit = (last_digits[-2] + last_digits[-1]) % 10

    # If this condition is met, we know that the pattern will begin repeating # [my note] this is because once we get to [1, 1] again, the sequence has to proceed the same way as we add them up again
    if last_digits[-1] == last_digits[0] && next_last_digit == last_digits[1]
      return last_digits[0..-2]
    else
      last_digits << next_last_digit
    end
  end
end
# "

# Additionally, once the sequence is known, we can do what I saw another student do and extract that array to a constant, thus saving more calculation time when calling the method
