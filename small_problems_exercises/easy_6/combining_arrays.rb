=begin

# Problem:

input: two arrays (may include duplicate elements)
output: one array with all elements from other arrays (but no duplicates)

# Algorithm:

iterate through both arrays, inputting values into new array
remove duplicates
return new array

=end

def merge(array1, array2)
  merged_array = []

  array1.each { |e| merged_array << e }

  array2.each { |e| merged_array << e }

  merged_array.uniq
end

p merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9] # true

# Official solution: uses Array#| method to combine arrays without duplicates

def merge(array_1, array_2)
  array_1 | array_2
end
