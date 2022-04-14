=begin

Problem: 

Write a method that returns a list of all substrings of a string. The returned list should be ordered by where in the string the substring begins.
This means that all substrings that start at position 0 should come first, then all substrings that start at position 1, and so on. Since multiple
substrings will occur at each position, the substrings at a given position should be returned in order from shortest to longest.

You may (and should) use the leading_substrings method you wrote in the previous exercise.

input: string
output: an array of all substrings, ordered first by starting position, then length

Algorithm:

create empty final_results array
create empty substring_seeds array
loop through the string, creating substrings starting at each position and ending at the end of the string ('red' becomes ['red', 'ed', 'd'])
  push them into the substring_seeds array
iterate through the substring_seeds array
  call #leading_substrings on each substring
  push the array it returns into the final results array
flatten and return the final results array

=end

def leading_substrings(string)
  output = []

  slice_length = 1
  while slice_length <= string.length
    output << string.slice(0, slice_length)
    slice_length += 1
  end

  output
end

def all_substrings(string)
  final_results = []
  substring_seeds = []

  index = 0
  while index < string.length
    substring_seeds << string.slice(index, (string.length - index) )
    index += 1
  end

  substring_seeds.each do |seed|
    final_results << leading_substrings(seed)
  end

  final_results.flatten
end

all_substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]

# LS Solution uses #concat, a very useful method for adding elements of one array to another without having to #flatten afterwards

def substrings(string)
  results = []
  (0...string.size).each do |start_index|
    this_substring = string[start_index..-1]
    results.concat(leading_substrings(this_substring)) # just calls #concat with the results of the #leading_substrings method on the substring within the iteration! no need for separate arrays/loops
  end
  results
end
