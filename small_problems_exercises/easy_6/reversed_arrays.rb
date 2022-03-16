=begin

# Problem: reverse an array (mutate it) without using #reverse or #reverse!

input: array
output: same array reversed
should also work with empty array (return empty array)

# Algorithm:

for each element in array
  delete element
  prepend it to temporary storage array
  stop when main array is empty
iterate through temp array
  push elements into main array (now in reversed order)
return altered main array

=end

def switcheroo!(array)
  temp_array = []
  
  array.length.times do
    temp_element = array.shift
    temp_array.prepend(temp_element)
  end

  temp_array.each do |temp_element|
    array << temp_element
  end

  array
end

list = [1,2,3,4]
result = switcheroo!(list)
p result == [4, 3, 2, 1] # true
p list == [4, 3, 2, 1] # true
p list.object_id == result.object_id # true

list = %w(a b e d c)
p switcheroo!(list) == ["c", "d", "e", "b", "a"] # true
p list == ["c", "d", "e", "b", "a"] # true

list = ['abc']
p switcheroo!(list) == ["abc"] # true
p list == ["abc"] # true

list = []
p switcheroo!(list) == [] # true
p list == [] # true

# Official solution shows how to swap in place without a placeholder variable:

def reverse!(array)
  left_index = 0
  right_index = -1

  while left_index < array.size / 2 # integer division means that e.g. 5/2 == 2
    array[left_index], array[right_index] = array[right_index], array[left_index] # swap values of beginning and end as we move inward
    left_index += 1
    right_index -= 1
  end

  array
end

### Part 2

=begin

# Problem:

this time don't mutate the array, but still return reversed array
input: array
output: new array in reverse order
Rules:
-don't modify the original list
-don't reuse the previous method
-don't use #reverse or #reverse!

# Algorithm:

make empty new array
iterate through old array
  copy each element and prepend to new array
return new array

=end

def switcheroo(array)
  reversed_array = []

  array.each do |element|
    reversed_array.prepend(element)
  end

  reversed_array
end

p switcheroo([1,2,3,4]) == [4,3,2,1]          # => true
p switcheroo(%w(a b e d c)) == %w(c d e b a)  # => true
p switcheroo(['abc']) == ['abc']              # => true
p switcheroo([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = switcheroo(list)              # => [2, 3, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 3, 2]                     # => true
p new_list == [2, 3, 1]                 # => true

## Further Exploration:

# Solve problem even shorter with either #inject or #each_with_object

def switcheroo_two(array)
  array.each_with_object([]) { |e, arr| arr.prepend(e) }
end

p switcheroo_two([1,2,3,4]) == [4,3,2,1]          # => true
p switcheroo_two(%w(a b e d c)) == %w(c d e b a)  # => true
p switcheroo_two(['abc']) == ['abc']              # => true
p switcheroo_two([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = switcheroo_two(list)              # => [2, 3, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 3, 2]                     # => true
p new_list == [2, 3, 1]                 # => true

# and for fun, now with #inject, which is even shorter!

def switcheroo_three(array)
  array.inject([], :prepend)
end

p switcheroo_three([1,2,3,4]) == [4,3,2,1]          # => true
p switcheroo_three(%w(a b e d c)) == %w(c d e b a)  # => true
p switcheroo_three(['abc']) == ['abc']              # => true
p switcheroo_three([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = switcheroo_three(list)              # => [2, 3, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 3, 2]                     # => true
p new_list == [2, 3, 1]                 # => true
