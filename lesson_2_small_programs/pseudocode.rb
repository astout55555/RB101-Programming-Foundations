# This file is to show the steps to using pseudocode to write a short program, followed by practice examples

=begin

# Informal Pseudocode:

Given a collection of integers.

Iterate through the collection one by one.
  - save the first value as the starting value.
  - for each iteration, compare the saved value with the current value.
  - if the saved value is greater, or it's the same
    - move to the next value in the collection
  - otherwise, if the current value is greater
    - reassign the saved value as the current value

After iterating through the collection, return the saved value.


# Formal Pseudocode:

START

# Given a collection of integers called "numbers"

SET iterator = 1
SET saved_number = value within numbers collection at space 1

WHILE iterator <= length of numbers
  SET current_number = value within numbers collection at space "iterator"
  IF saved_number >= current_number
    go to the next iteration
  ELSE
    saved_number = current_number

  iterator = iterator + 1

PRINT saved_number

END

=end

# Translated to Program Code:

def find_greatest(numbers)
  saved_number = numbers[0]

  numbers.each do |num|
    if saved_number >= num
      next
    else
      saved_number = num
    end
  end

  saved_number
end


### Practice Examples: writing casual and formal pseudocode below ###

=begin

# a method that returns the sum of two integers

take 2 arguments, both integers
add integers together
return this value

START

[unless I'm getting user input this one's really too simple to put more formally than above without more closely approximating actual code]

method(arg1, arg2)
  return arg1 + arg2
end

END


# a method that takes an array of strings, and returns a string that is all those strings concatenated together

given an array of strings

iterate through array of strings
-set a variable to store the end result
-add each string to the result variable
-return the full result

START

# Given an array of strings labeled 'strings'

SET iterator = 0
SET final_string = ''

WHILE iterator <= size of 'strings'
  final_string += value of 'strings' at index[iterator]
  iterator += 1

PRINT final_string

END


# a method that takes an array of integers, and returns a new array with every other element from the original array, starting with the first element:

given an array of integers

create an empty array

iterate through the original array
-if index is odd, copy value to the new array
-if index is even, move to the next iteration

return new array

START

# Given an array of integers called 'integers'

SET every_other_array = []

SET iterator = 0

WHILE iterator <= size of integers
  IF iterator is even
    add value of integers[iterator] to every_other_array
  ELSE
    don't do anything
  iterator += 1

return every_other_array

END


# a method that determines the index of the 3rd occurrence of a given character in a string

given a string and a character to check

break the string into individual characters
collect these characters into an array

iterate through the array
-check for the character provided to the method as an argument
-track the number of times it appears
-on the 3rd time, return the index of this appearance
-if not found 3 times, return nil

START

# Given two arguments, a string and a character to check for

SET letters = the string broken down into individual characters and collected as an array

SET iterator = 0
SET count = 0

WHILE iterator <= size of letters
  IF letters[iterator] == character && count = 2
    PRINT iterator
  ELSIF letters[iterator] == character
    count += 1
    iterator += 1
    go to next iteration
  ELSE
    iterator += 1
    go to next iteration

END


# a method that takes two arrays of numbers and returns the result of merging the arrays,
# with the elements from the first array at even indexes and elements from the 2nd array at odd indexes in the new array
# assume both arrays have same number of elements

given two arrays of numbers

create an empty array

use a loop with a counter to track index independent of a specific array
-alternately add the values of the first then 2nd array to the empty array
-stop when teh counter is more than the combined length of the two arrays

return the new array

START

# Given two arrays of numbers, numbers1 and numbers2

SET combined_array = []

SET counter = 0
SET iterator1 = 0
SET iterator2 = 0

WHILE counter <= length of (numbers1 + numbers2)
  IF counter.even?
    append value of numbers1[iterator1] to combined_array
    iterator1 += 1
  ELSE 
    append value of numbers2[iterator2] to combined_array
    iterator2 += 1
  counter += 1

PRINT combined_array

END


=end
