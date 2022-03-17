=begin

# Problem: combine two arrays, alternating elements
input: two arrays, non-empty, same number of elements
output: a single array, elements alternating from the two source arrays

# Algorithm:

create empty results array
use loop with counter that serves as general index
  copy over element from array 1
  copy over element from array 2
  increment counter
  break at input array size
return results array

=end

def interleave(array1, array2)
  results = []
  index = 0

  until index == array1.size
    results << array1[index]
    results << array2[index]
    index += 1
  end

  results
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

# LS solution stacks `<<` and uses #each_with_index for more concise code:

def interleave(array1, array2)
  result = []
  array1.each_with_index do |element, index|
    result << element << array2[index]
  end
  result
end

## Further Exploration: rewrite solution to use Array#zip

def interleave(array1, array2)
  array1.zip(array2).flatten
end

p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']
