=begin

# Problem:

input: a single array
output: nested array with half of the elements in one array and half in the other
Rules:
-elements are split down the middle.
-if odd number of elements, middle element placed in the first half array

# Algorithm:

create two empty arrays and a master empty array
iterate through input array
  push element into first array if first array is still less than half input array size
  push element into 2nd array otherwise
push both half arrays into the master array
return master array

=end

def halvsies(array)
  first_half = []
  second_half = []
  result = []

  array.each do |element|
    if first_half.size < (array.size / 2.0) # using float division so it doesn't round down
      first_half << element
    else
      second_half << element
    end
  end

  result << first_half
  result << second_half
  result
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]

# Official Solution uses #slice effectively, and an array literal to form the result

def halvsies(array)
  middle = (array.size / 2.0).ceil
  first_half = array.slice(0, middle) # 1st arg in #slice is starting index, 2nd arg is length
  second_half = array.slice(middle, array.size - middle)
  [first_half, second_half]
end
