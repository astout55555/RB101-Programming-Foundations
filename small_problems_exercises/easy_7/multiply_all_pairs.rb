=begin

# Problem: 

input: two array arguments, may be different lengths but neither is empty
output: one array, elements are the product of every pair of numbers that can be formed between them, sorted by increasing value

# Algorithm:

use #product to produce multi-dimensional array of all pairs
map array onto new array, reducing each pair to its product (a single integer)
sort this new array and return

=end

def multiply_all_pairs(array_1, array_2)
  all_pairs = array_1.product(array_2)
  products = all_pairs.map { |sub_array| sub_array.reduce(:*) }
  products.sort
end

multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]

# First LS Solution Uses layered iteration:

def multiply_all_pairs(array_1, array_2)
  products = []
  array_1.each do |item_1|
    array_2.each do |item_2|
      products << item_1 * item_2
    end
  end
  products.sort
end
# I think mine is cleaner but mine does require the #product method

# Compact solution from LS is really cool:

def multiply_all_pairs(array_1, array_2)
  array_1.product(array_2).map { |num1, num2| num1 * num2 }.sort
end
# I didn't realize you could use |num1, num2| in the #map block to pull from each element in the sub-arrays
