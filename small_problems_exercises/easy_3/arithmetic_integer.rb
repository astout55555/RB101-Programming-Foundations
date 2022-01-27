=begin

PEDAC

understand the Problem:

input: two positive integers from user
output: series of computations using the input:
  addition, subtraction, product, quotient, remainder, power

Examples/test cases:

# first example from the exercise
==> Enter the first number:
23
==> Enter the second number:
17
==> 23 + 17 = 40
==> 23 - 17 = 6
==> 23 * 17 = 391
==> 23 / 17 = 1
==> 23 % 17 = 6
==> 23 ** 17 = 141050039560662968926103

first number 1, second number 2
=> 1 + 2 = 3
=> 1 - 2 = -1
=> 1 * 2 = 2
=> 1 / 2 = 0   # we are using integer division
=> 1 % 2 = 1   # this is modulo `%`, same as remainder for positive integers
=> 1 ** 2 = 1

Data structure:

convert inputs to integers, save as variables

Algorithm:

obtain user inputs, convert to integers and save as two variables
save results of each computation with both integers as a results variable
display series of computations interpolating the variables

=end

puts 'Enter the first number:'
first_num = gets.chomp.to_i

puts 'Enter the second number:'
second_num = gets.chomp.to_i

sum = first_num + second_num
difference = first_num - second_num
product = first_num * second_num
integer_division = first_num / second_num
modulo_remainder = first_num % second_num
power_result = first_num ** second_num

puts "#{first_num} + #{second_num} = #{sum}"
puts "#{first_num} - #{second_num} = #{difference}"
puts "#{first_num} * #{second_num} = #{product}"
puts "#{first_num} / #{second_num} = #{integer_division}"
puts "#{first_num} % #{second_num} = #{modulo_remainder}"
puts "#{first_num} ** #{second_num} = #{power_result}"
