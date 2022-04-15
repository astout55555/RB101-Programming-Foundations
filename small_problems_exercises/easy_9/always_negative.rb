=begin

Problem: 

input: integer (positive or negative or 0)
output: the negative of that number (or 0)

Algorithm:

return the negative of the absolute value of the number

=end

def negative(num)
  -num.abs
end

p negative(5) == -5
p negative(-3) == -3
p negative(0) == 0      # There's no such thing as -0 in ruby
