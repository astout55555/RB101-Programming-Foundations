### Multiply Two Numbers:

def multiply(num1, num2)
  num1 * num2
end

puts multiply(5, 3) == 15 # should print true

## Further Exploration:

p multiply([1, 2, 'hi'], 2) # prints [1, 2, 'hi', 1, 2, 'hi']
# multiplying an array by a number seems to append additional copies onto the original

p multiply([2, 'hi', 'test'], 'hello') # prints '2hellohihellotest'
# mutliplying by a string seems to insert the string between every element
# converting all elements into one single big string


### Squaring an Argument:

def square(num)
  multiply(num, num)
end

# these return true
square(5) == 25
square(-8) == 64

## Further Exploration (use multiply method in power method):

def to_power_of(number, power)
  result = 1
  power.times {result = multiply(result, number)}
  result
end

# these return true
to_power_of(2, 3) == 8
to_power_of(3, 2) == 9
to_power_of(4, 0) == 1 # edge case still works with result intialized as 1
