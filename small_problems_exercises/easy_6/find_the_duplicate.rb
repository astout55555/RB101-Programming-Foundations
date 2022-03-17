=begin

# Problem:

input: an unordered array with only 1 duplicate value
output: the duplicate value

# Algorithm:

iterate through the array
  for each element, return the count of that element in the array
  if the count is 2, save element to result variable
return result

=end

def find_dup(array_with_1_dup)
  result = "No duplicates found!"
  array_with_1_dup.each do |element|
    count = array_with_1_dup.count(element)
    result = element if count == 2
  end
  result
end

p find_dup([1, 5, 3, 1]) == 1
p find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73

# Official solution uses #find, which returns the first element that meets some condition

def find_dup(array)
  array.find { |element| array.count(element) == 2 }
end
