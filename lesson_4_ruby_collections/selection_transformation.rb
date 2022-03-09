=begin

# Problem:
create method that selects only the fruit from the hash
input: produce hash above
output: key value pairs with value of fruit, as a hash
implicit rules: use a loop to perform the selection (not #select)
notes:
-because it is a hash I cannot simply iterate through based on index
-

# Algorithm:
create empty hash
get array of keys from hash
iterate over keys, retreiving values
-if value is 'Fruit' then move into new hash
return new hash

=end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(hash)
  selected_fruit = {}
  keys = hash.keys
  counter = 0

  loop do
    break if counter == hash.keys.size # at top in case hash is empty

    current_key = keys[counter]

    if hash[current_key] == 'Fruit'
      selected_fruit[current_key] = hash[current_key]
    end

    counter += 1
  end

  selected_fruit
end

# Example/Test case:
select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}


=begin

# Problem:
create a double_numbers! method that mutates its argument
input: array of integers
output: the same array, transformed by doubling every element

Example:
my_numbers = [1, 4, 3, 7, 2, 6]
double_numbers(my_numbers) # => [2, 8, 6, 14, 4, 12]

=end

my_numbers = [1, 4, 3, 7, 2, 6]

def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] *= 2

    counter += 1
  end

  numbers
end

double_numbers!(my_numbers)
my_numbers

=begin

# Problem
input: array of numbers
output: array with the elements with odd indices doubled
Rules:
-double only the numbers that have odd indices
-don't mutate

# Algorithm:
use same looping structure as before
change selection criteria to check if index is odd, not value

=end

def double_odd_indices(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd? # only changed this line
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
double_odd_indices(my_numbers)  # => [1, 8, 3, 14, 2, 12]
my_numbers                      # not mutated, => [1, 4, 3, 7, 2, 6]

=begin

# Problem
create method #multiply which and transform based on given arg instead of only doubling
input: array of numbers, multiplier
output: new array transformed by multiplier

=end

def multiply(numbers, multiplier)
  multiplied_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    transformed_number = current_number * multiplier
    multiplied_numbers << transformed_number

    counter += 1
  end

  multiplied_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) == [3, 12, 9, 21, 6, 18] # prints true

=begin

# Problem:
write method #select_letter that takes a string and returns only the letter we specified
input: string to examine, selection letter (string)
output: substring of all instances of the specified letter (if found)
-output is empty string if letter not found
-output is concatenated string of multiple instances of the letter if more than one

# Examples:

question = 'How many times does a particular character appear in this sentence?'
select_letter(question, 'a') # => "aaaaaaaa"
select_letter(question, 't') # => "ttttt"
select_letter(question, 'z') # => ""

# Solution:

def select_letter(sentence, character)
  selected_chars = ''
  counter = 0

  loop do
    break if counter == sentence.size
    current_char = sentence[counter]

    if current_char == character
      selected_chars << current_char
    end

    counter += 1
  end

  selected_chars
end

=end


# Ending Notes:

# arrays and hashes are common collections. strings can be treated like
# collections, but each character is not actually its own object!
# 3 actions allow almost limitless manipulation of collections:
# iteration, selection, transformation.
# make sure to be aware of when an original collection is mutated
# vs when the method returns a new collection.
# Understand how methods can be made more generic by allowing additional parameters
# to specify some criteria for selection or transformation.
# pay attention to the return value when chaining methods on collections,
# especially if the return value is nil or an empty collection.
# This can often break the code.
