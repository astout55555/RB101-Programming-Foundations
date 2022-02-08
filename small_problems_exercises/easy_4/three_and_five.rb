=begin

input: integer greater than 1
output: sum of all multiples of 3 or 5 between 1 and the input

Examples:

multisum(3) == 3
multisum(5) == 8
multisum(10) == 33
multisum(1000) == 234168

use input to provide counter limit for loop
iterate through numbers, build array out of multiples of 3 or 5
sum the array

=end

def multisum(positive_integer)
  multiples = []
  while positive_integer > 1
    if positive_integer % 3 == 0 || positive_integer % 5 == 0
      multiples << positive_integer
    end
    positive_integer -= 1
  end
  multiples.sum
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168

## Further Exploration: use Enumberable.inject to write another solution

def multisum_alt(positive_integer)
  multiples = []
  (1..positive_integer).select do |num|
    multiples << num if num % 3 == 0 || num % 5 == 0
  end
  multiples.inject(:+)
end

# great solution for this part from another student:

def multisum(num)
  (0..num).inject do |sum, n|
    (n % 3 == 0 || n % 5 == 0) ? sum += n : sum += 0
  end
end
