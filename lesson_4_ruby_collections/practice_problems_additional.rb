## Problem 1

=begin

# Problem: turn the array into a hash where names are keys and values are the positions
input: flinstones array
output: hash of name => index pairs

create empty hash
iterate through array
for each element, create name => index pairing and insert into hash
return hash

=end

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}

flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

p flintstones_hash

## Problem 2

=begin

#Problem:
input: Munster family hash with name => age pairs
output: sum of ages

initialize sum variable as 0
iterate through hash
sum += age
return sum

=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

age_sum = 0
ages.each { |name, age| age_sum += age }
p age_sum

# or...

ages.values.inject(:+)

## Problem 3

=begin

# Problem:
input: new (smaller) Munster family hash
output: same hash with those age 100 or more removed

=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.reject! { |_, age| age >= 100 }

p ages

## Problem 4

=begin

# Problem: pick out the minimum age from hash
input: new instance of Munster family hash
output: lowest age in the hash, as an integer

take hash values (ages)
sort
return the first in list (lowest value)

=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

p ages.values.sort.first # could also do ages.values.min

## Practice Problem 5

=begin

input: new flintstones array (strings/names)
output: index of the first name that starts with "Be"

use loop to iterate through array
if first two letters of name are "Be", break loop and return index

=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

index = 0
index_of_name = 0
while index_of_name == 0
  break if index >= flintstones.size
  index_of_name = index if flintstones[index].start_with?('Be')
  index += 1
end

p index_of_name

=begin

another way using methods:

create empty array
iterate through each name with index
  push index into array if name starts with "Be"
  break if array is no longer empty
return value of element in array

=end

index_of_name = []
flintstones.each_with_index do |name, index|
  index_of_name << index if name.start_with?("Be")
  break unless index_of_name.empty?
end

puts index_of_name[0]

# Official solution uses #index and substrings to greatly simplify:

flintstones.index { |name| name[0, 2] == "Be" }

## Problem 6

=begin

input: flintstones array of names (strings)
output: same array with names shortened to first 3 characters

map names into new array pulling the substrings of each word

=end

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |name| name[0, 3] }

p flintstones

## Problem 7

=begin

# Problem:
input: string
output: hash with frequency with which each letter occurs

break string into array of characters
narrow to unique list of characters
create empty hash
iterate through letters
  count number of times each appears in original string
  pair each letter with each count (saved in hash)
return hash

=end

statement = "The Flintstones Rock"

chars = statement.chars.uniq
chars.delete(' ')

frequency = {}

chars.each do |letter|
  count = statement.count(letter)
  frequency[letter] = count
end

p frequency

## Problem 8

# What would be output by this code?:

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# => 1
# => 3
# this code will print an element, then remove it, and then it moves on
# to the next index in the array, not necessarily the next element
# if the indexes have shifted after having elements removed.

# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# => 1
# => 2
# again, it prints a number, then removes one, but since it's removing
# from the end, it simply runs out of elements after going through the
# first 2 in order (and popping off the last two).

## Problem 9

=begin

input: string
output: string with first letter of each word capitalized only

break string into words
create empty array
iterate through words
  capitalize each word's first letter
  insert capitalized word into empty array
join array into finalized string

=end

words = "the flintstones rock"

def titleize(string)
  separate_words = string.split
  title = []
  separate_words.each do |word|
    titleized_word = word.capitalize
    title << titleized_word
  end
  title.join(' ')
end

p titleize(words)

# Offical solution is super short!:

# words.split.map { |word| word.capitalize }.join(' ')

## Problem 10

=begin

input: munsters hash (multidimensional hash, age and gender attached to each member)
output: munster hash with added key=>value pair of "age_group" and kid/adult/senior
Rules: kid is 0-17, adult is 18-64, senior is 65+

iterate through hash
  for each name, retrieve the age integer
    insert new key/value pair with appropriate value based on age
return modified hash

=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# names = munsters.keys

# munsters.each do |key, value|
#   if value.values[0] <= 17
#     key['age_group'] = 'kid'
#   elsif value.values[0] >= 65
#     key['age_group'] = 'senior'
#   else
#     key['age_group'] = 'adult'
#   end
# end

# p munsters
