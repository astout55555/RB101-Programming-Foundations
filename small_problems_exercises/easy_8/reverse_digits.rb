=begin

Problem: method that reverses integer's digits, removing leading zeros
input: positive integer
output: integer, digits reversed, any leading zeros removed

Algorithm:

convert integer to string
reverse string
convert back to integer
output

=end

def reversed_number(num)
  num.to_s.reverse.to_i
end

p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21 # No leading zeros in return value!
p reversed_number(12003) == 30021
p reversed_number(1) == 1
