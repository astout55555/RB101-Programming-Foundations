=begin

input: array of numbers
output: array with same number of elements, each the running total of itself plus all previous elements

Examples:

running_total([2, 5, 13]) == [2, 7, 20]
running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
running_total([3]) == [3]
running_total([]) == []

take array, map onto new array
transformed so each element is added to and retrieved from a sum variable

=end

def running_total(array)
  return [] if array.empty? # unnecessary, #map will return an empty array if given an empty array (no elements to put into block)
  sum = 0
  array.map do |element|
    sum += element
    element = sum # unnecessary, #map already turns returned value into the new element
  end
end

## Further Exploration: try solving with Enumerable#each_with_object or Enumerable#inject

def running_total(array)
  sum = 0
  array.each_with_object([]) do |element, new_array|
    new_array << (sum += element)
  end
end

def running_total(array) # solution borrow from another student
  sum = 0
  new_array = array.inject([]) do |array, element| # passing [] as initial operand means the memo starts as an empty array
    array << sum += element # I was getting hung up on thinking I had to limit the memo to serving the role of the sum, an integer
  end # no need to add another line for the return value
end
