# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

=begin

input: string
output: array (of substrings)

Rules:
  Explicit:
    -name method 'palindrome_substrings'
    -method must take a string as arg, return all the substrings which are palindromes
    -palindromes are case sensitive
  Implicit:
    -return 1 or more qualifying palindromes as strings within an array
    -if no palindromes are found, return an empty array
    -if given an empty string, return an empty array

=end

### Pedac Process Video Examples

=begin

Imagine a sequence of consecuive even integers beginning with 2. The integers are grouped in
rows, with the first row containing one integer, the second row two integers, the third row three
integers, and so on. Given an integer representing the number of a particular row, return an
integer representing the sum of all the integers in that row.

# I'm skipping the typing out of all the steps because I didn't think to start at first and I don't want to rewatch the vids

Examples:

row number: 1 --> sum of integers in row: 2
row number: 2 --> sum of integers in row: 10
row number: 4 --> sum of integers in row: 68

start: 2, length: 1 --> [2]
start: 4, length: 2 --> [4, 6]
start: 8, length: 3 --> [8, 10, 12]

# Calculating the start integer:
Rule: First integer of row == last integer of preceding row + 2
Algorithm:
  -Get the last row of the rows array
  -Get the last integer of that row
  -add 2 to the integer

=end

## Coding along with the video below:

def sum_even_number_row(row_number)
  rows = []
  start_integer = 2
  (1..row_number).each do |current_row_number|
    rows << create_row(start_integer, current_row_number)
    start_integer = rows.last.last + 2
  end
  rows.last.sum
end

def create_row(start_integer, row_length)
  row = []
  current_integer = start_integer
  loop do
    row << current_integer
    current_integer += 2
    break if row.length == row_length
  end
  row
end

p create_row(2, 1) == [2] # should print true
p create_row(4, 2) == [4, 6]
p create_row(8, 3) == [8, 10, 12]

p sum_even_number_row(1) == 2 # these should print true, too
p sum_even_number_row(2) == 10
p sum_even_number_row(4) == 68

## Final Thoughts

# - Not a completely linear process
# - Move back and forth between the steps
# - Switch from implementation mode to abstract problem solving mode when necessary
# - Don't try to problem solve at the code level (at the same time)
