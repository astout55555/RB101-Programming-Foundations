=begin

Problem:

input: array of sub-arrays with two elements each, string and integer
output: flat array with each string appearing according to value of paired integer

Algorithm:

create empty output array
iterate through the array
  for each sub-array, insert the string into the output array according to associated integer


=end

def buy_fruit(organized_list)
  output = []
  organized_list.each do |sub_array|
    sub_array[1].times { output << sub_array[0] }
  end
  output
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]

# LS Solution 1: like mine, but more descriptive:

def buy_fruit(list)
  expanded_list = []

  list.each do |item|
    fruit, quantity = item[0], item[1]
    quantity.times { expanded_list << fruit }
  end

  expanded_list
end

# Note that we can also use block parameters to access each element of a sub array:
# list.each do |fruit, quantity|
#   quantity.times { expanded_list << fruit }
# end

# LS Solution 2: something I tried, but didn't know how to make work:

def buy_fruit(list)
  list.map { |fruit, quantity| [fruit] * quantity }.flatten
end

# fruit * quantity => "applesapplesapples"
# what I was doing before changing strategy, multiplying a string

# [fruit] * quantity => ["apples", "apples", "apples"]
# multiplying [fruit] as an array, though, multiplies the number of elements in the array!
