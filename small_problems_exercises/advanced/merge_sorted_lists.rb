=begin

Problem:

Write a method that takes two sorted Arrays as arguments,
and returns a new Array that contains all elements from both arguments in sorted order.

You may not provide any solution that requires you to sort the result array.
You must build the result array one element at a time in the proper order.

Your solution should not mutate the input arrays.

input: two sorted Arrays
output: one merged Array which is pre-sorted

Algorithm:

create empty results array
duplicate the arrays, combine and flatten them

until combined array is empty,
repeatedly find the lowest value and push it into the results array

return results array

=end

def merge(array_1, array_2)
  results = []

  all_elements = (array_1.dup + array_2.dup).flatten

  loop do
    tied_for_lowest = all_elements.count(all_elements.min)

    lowest_element = all_elements.delete(all_elements.min)
    
    tied_for_lowest.times do
      results << lowest_element
    end

    break if all_elements.empty?
  end

  results
end

p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) #== [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]

## LS Solution:

def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

## Notes:

# My solution was sort of cheating--I wasn't supposed to mutate the input arrays,
# and it's true that I didn't mutate the arrays that were passed in as arguments,
# because I did duplicate them first. However, the solution is definitely easier if
# you're allowed to mutate these duplicates. Instead, the LS solution iterated through
# array1 while also counting up with another variable for index2 (for array2). It still
# requires that you be careful not to try to add any values that aren't in array2, and
# it requires that you add at the end any values from array2 that were missed because
# array1 was smaller than array2.
