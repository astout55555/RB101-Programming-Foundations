### Practice Problem 1

# Problem: order this array by descending numeric value

arr = ['10', '11', '9', '7', '8']

# algorithm:
# use #map to transform array, store new array in variable
#   change each element to the numeric equivalent
# sort the new array and then reverse order
# transform array back into strings to get final result

def reorder_to_descending_numeric(array_of_strings)
  numeric_array = array_of_strings.map { |element| element.to_i }

  numeric_array.sort!.reverse!

  numeric_array.map { |num| num.to_s }
end

reorder_to_descending_numeric(arr)

# LS Solution: uses a block with #sort for concise reordering

arr.sort do |a,b|
  b.to_i <=> a.to_i
end
# => ["11", "10", "9", "8", "7"]

### Practice Problem 2

# Problem: sort this array of hashes based on year of publication, earliest to latest

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

# Data: this is an array of hashes
# Algorithm:
# sort array by value of the :published key

books.sort_by { |hash| hash[:published] } # note that we can only do this so simply because the years are strings of the same length; otherwise we'd have to convert to integers first

### Practice Problem 3

# Problem: for each collection object show how I'd reference the letter 'g'

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

arr1[2][1][3] == 'g' # true

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

arr2[1][:third][0] == 'g'

arr3 = [['abc'], ['def'], {third: ['ghi']}]

arr3[2][:third][0][0] == 'g'

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

hsh1['b'][1] == 'g'

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

hsh2[:third].key(0) == 'g' # could also have done `hsh2[:third].keys[0]` to retrieve the first key from the hash, rather than the first key with the corresponding value of 0

### Practice Problem 4

# Problem: for each collection object, where 3 occurs, demonstrate how to change it to 4

arr1 = [1, [2, 3], 4]

arr1[1][1] = 4

arr1 == [1, [2, 4], 4] # true

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

arr2[2] = 4

arr2 == [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 4]

hsh1 = {first: [1, 2, [3]]}

hsh1[:first][2][0] = 4

hsh1 == {first: [1, 2, [4]]}

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

hsh2[['a']][:a][2] = 4

hsh2 == {['a'] => {a: ['1', :two, 4], b: 4}, 'b' => 5}

### Practice Problem 5

# Problem: how can I find the total age of just the male members of the family in the following hash?

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Data: a hash which has a hash for the value of each key/value pair
# Algorithm:
# obtain an array of the values of the hash (the sub-hashes)
# select only the sub-hashes which have a value of 'male' for the key of 'gender'
# iterate through the remaining sub-hashes
#   sum up the values of the 'age' keys
# return the result

munster_men = munsters.values.select { |details| details['gender'] == 'male' }

total_age = 0

munster_men.each do |man|
  total_age += man['age']
end

total_age

# LS Solution uses #each_value and a conditional within the block to simplify into single method call

total_male_age = 0
munsters.each_value do |details|
  total_male_age += details["age"] if details["gender"] == "male"
end

total_male_age # => 444

### Practice Problem 6

# Problem: given this hash, print out the name, age, and gender of each family member, using the following format:
# (Name) is a (age)-year-old (male or female).

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Algorithm:
# iterate through each key (name) and value (sub-hash)
#   print a concatenated string with the needed values

munsters.each do |name, details|
  age = details['age']
  gender = details['gender']
  puts "#{name} is a #{age}-year-old #{gender}."
end

### Practice Problem 7

# Given this code, what are the final values of `a` and `b`?

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2 # reassigns the element at index 0 of the `arr` variable. does not reference variable `a`
arr[1][0] -= a # arr[1] returns variable `b`, which is an array, which is then changed by having its element at index 0 reassigned (thus mutating `b`)

p a == 2 
p b == [3, 8]

### Practice Problem 8

# Problem: use #each to output all the vowels from the strings in this hash

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |key, value|
  value.each do |string|
    string.chars.each { |letter| puts letter if letter.match?(/['aeiou']/) }
  end
end

### Practice Problem 9

# Problem: return a new array of the same structure but with the sub-arrays being ordered in descending order

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |sub_array|
  sub_array.sort.reverse
end

### Practice Problem 10

# without modifying the original array, use #map to a new array with same structure but each integer increased by 1

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# Data: array with 3 hashes (of various sizes) as elements
# Algorithm: start with #map...
#   call #map on each hash
#     increment values by 1

original_array = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_array = original_array.map do |hash|
              new_hash = {}
              hash.each do |key, value|
                new_hash[key] = value + 1 # need to create key with incremented value for a new hash or else it'd change the original
              end
              new_hash # need to include the new hash at the end, otherwise #each simply returns the original hash it was called on
            end

### Practice Problem 11

# use a combination of methods including #select or #reject to return a new array, same structure, but only containing multiples of 3

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

# Data: array with 4 sub-arrays, 1-3 elements in each sub-array
# Algorithm: 
# use #map for transformation
#   call #select on each sub-array, filter out anything not divisible by 3

arr.map do |sub_array|
  sub_array.select { |num| num % 3 == 0 }
end

### Practice Problem 12

# without using #to_h, turn the following array into a hash

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

# Data: array with sub-arrays, each with 2 elements
# Algorithm:
# iterate through the array with results_hash object
#   create key and value variables, assigning sub-array elements  
#   create new key/value pair from each pair of elements in the sub-array

arr.each_with_object({}) do |array, results_hash|
  key, value = array[0], array[1]
  results_hash[key] = value
end

### Practice Problem 13

=begin

Problem:
input:  [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]
output: [[1, 8, 3], [1, 5, 9], [6, 1, 7], [1, 6, 9]]
take input array, sort based on the odd numbers only, in ascending order

Algorithm:
use #sort_by so I can sort by the results of a block instead of the values of the sub-arrays themselves
compare based on selection of odd elements/integers only

=end

arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

arr.sort_by do |sub_array|
  sub_array.select { |num| num.odd? }
end

### Practice Problem 14

# Problem: given the following hash, return an array with colors of the fruits and sizes of the vegetables, sizes upcased and colors capitalized

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

=begin

end result should look like this: [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

Data: hash
composed of key/value pairs where the keys are strings and values are sub-hashes
sub-hashes are composed of key/value pairs where the keys are symbols and the values are either strings or arrays of one or two strings

Algorithm:
create end result array (empty)
iterate through hash values (no need to refer to names of produce / keys)
  use conditional to determine which code to run, depending on if type is a fruit or vegetable
    if fruit then return value of colors after iterating through and capitalizing elements
    if vegetable then return upcased value of size
    either way push this value into the results array
return results array

=end

results_array = []

hsh.each_value do |produce_details|
  if produce_details[:type] == 'fruit'
    results_array << produce_details[:colors].map { |color| color.capitalize }
  elsif produce_details[:type] == 'vegetable'
    results_array << produce_details[:size].upcase
  end
end

results_array

# LS Solution: use #map since we want to end up with an array with the same number of elements anyway

hsh.map do |_, value|
  if value[:type] == 'fruit'
    value[:colors].map do |color|
      color.capitalize
    end
  elsif value[:type] == 'vegetable'
    value[:size].upcase
  end
end
# => [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

### Practice Problem 15

# Problem: given this array return an array with only the hashes where the integers are all even

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

=begin

should only return: [{e: [8], f: [6, 10]}]

Data: array
3 elements, all hashes
each hash contains one or more key/value pairs, keys are symbols, values are arrays of integers

Algorithm:
use selection on original array
...
if value (sub-array within the element/hash) contains any odd numbers, reject it ...too complex for one step
...

=end

p (
arr.reject do |hash|
  hash.values.any? # not quite what I need, this calls #any? on an array of all the arrays for the hash...
)
