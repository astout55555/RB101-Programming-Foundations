=begin

# Problem: 

input: two array arguments, each containing an equal number of integers
output: a single array, formed by multiplying each pair of integers

# Algorithm:

create empty final array
use loop with counter to match index
multiply each element from the index at this current counter value to get result
push result to final array
increment counter
return final array

=end

def multiply_list(array1, array2)
  final_array = []
  counter = 0
  loop do
    product = array1[counter] * array2[counter]
    final_array << product
    counter += 1
    break if final_array.size >= array1.size
  end
  final_array
end

multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

# LS Solution skips the counter and uses #each_with_index instead of #loop

def multiply_list(list_1, list_2)
  products = []
  list_1.each_with_index do |item, index|
    products << item * list_2[index]
  end
  products
end

## Further Exploration: use Array#zip for a one line solution (inside method defintion)

def multiply_list(list_1, list_2) # first you #zip them together, getting [[3, 9], [5, 10], [7, 11]]
  list_1.zip(list_2).map { |e| e = e[0] * e[1] } # then you chain #map to it
end # returned array is transformed by the block, which turns each sub array into a single value (the product of its two elements)

multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

# Student solution, more flexible: 

def multiply_list(arr1, arr2) # using #reduce allows it to scale with more than 2 arrays, and it's a bit more concise
  result = arr1.zip(arr2).map{|num_arr| num_arr.reduce(:*)}
end
