=begin

Problem: 
Write a method that returns a list of all substrings of a string that start
at the beginning of the original string. The return value should be arranged
in order from shortest to longest substring.

input: string
output: array of substrings, from a single character to the full string

Algorithm:
create empty results array
start loop with counter
  create a slice with starting index 0 and length equal to counter
  add slice to array
  increment counter
output array

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

leading_substrings('abc') == ['a', 'ab', 'abc']
leading_substrings('a') == ['a']
leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']
