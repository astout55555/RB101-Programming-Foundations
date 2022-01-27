=begin

PEDAC

understand the Problem:

input: 6 numbers from user
output: is 6th found among first 5 numbers (yes, no)

Examples/test case:

[-1, 2, -3, 4, -5, 5] => no

[3, 3, 2, 1, 5, 0] => no

[2, 3, 4, 5, 2, 3] => yes

Data structure:

array for the first 5 numbers

Algorithm:

prompt for input from user 6 times, use loop for first 5
build array by adding first 5 inputs as they are received
test final input against array to check for duplicates
return true and prompt yes if found, else return false prompt no

=end

array_to_check = []

while array_to_check.size < 5
  puts "Please enter number ##{array_to_check.size + 1}:"
  number_input = gets.chomp.to_i
  array_to_check << number_input
end

puts 'Please enter the last number:'
last_number = gets.chomp.to_i

if array_to_check.include?(last_number)
  puts "The number #{last_number} appears in #{array_to_check}."
else
  puts "The number #{last_number} does not appear in #{array_to_check}."
end
