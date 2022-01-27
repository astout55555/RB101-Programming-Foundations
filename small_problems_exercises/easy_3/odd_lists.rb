=begin

understand the Problem:

create a method that returns an array made up of
the odd elements of another array passed as an argument to it
input: array
output: array of every other element only [1st, 3rd, 5th, etc]

Examples/test cases:

oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
oddities(['abc', 'def']) == ['abc']
oddities([123]) == [123]
oddities([]) == []

Data structure / Algorithm:

working with arrays
build new array starting with empty
iterate through original array, pushing every other element
-use even index only (first element starts at 0)
will return empty array if no elements

=end

# Coding with intent:

def oddities(array)
  new_array = []
  array.each_with_index { |val, idx| (new_array << val) if idx.even? }
  new_array
end

# Further Exploration (write method that does same for evens, and solve 2 more ways):

# take original array as arg
# select only the elements with an odd index (to get the 2nd, 4th, 6th etc elements)
# -combine #select with conditional using #index

def evenities(array)
  array.select { |element| array.index(element).odd? }
end

# these all return true
evenities([2, 3, 4, 5, 6]) == [3, 5]
evenities([1, 2, 3, 4, 5, 6]) == [2, 4, 6]
evenities(['abc', 'def']) == ['def']
evenities([123]) == []
evenities([]) == []

# one last way to solve it:

def another_oddities(array)
  array.delete_if { |element| array.index(element).odd? }
end

# #select and #delete_if can be used as alternatives
# #select returns new array with only elements for which the block returns true
# #delete_if is the opposite, returning the array with only the false ones
# however, #delete_if is a destructive method, mutates the original array
# #select is better if you just want to return a selection, rather than
# permanently alter the original array

# these all return true as well
another_oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
another_oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
another_oddities(['abc', 'def']) == ['abc']
another_oddities([123]) == [123]
another_oddities([]) == []
