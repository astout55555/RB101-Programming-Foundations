=begin

input: string, including words for numbers zero through nine
output string, with the number words converted to numeric strings (0-9), still separated by spaces

Example:

word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

Algorithm:

create hash constant for word and numeric string key/value pairs

in method
create empty output array
split input into words
iterate through words
  if word is in hash keys list, push value into output array
  if word[0..-2] is in hash keys list
    store the last character (the punctuation) as var
    convert the rest of the word using the hash key/value pairings, store as var
    recombine the word (numeric string + punctuation) and add to output array
  otherwise just push the word into output array
return output array rejoined into string

=end

NUMBER_WORDS = {
  'zero' => '0',
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9'
}

def word_to_digit(string)
  output = []

  string.split.each do |word|
    if NUMBER_WORDS.keys.include?(word)
      output << NUMBER_WORDS[word]
    elsif NUMBER_WORDS.keys.include?(word[0..-2])
      punctuation = word[-1]
      numeric_string = NUMBER_WORDS[word[0..-2]]
      output << (numeric_string + punctuation)
    else
      output << word
    end
  end

  output.join(' ')
end

word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

# LS Solution:

DIGIT_HASH = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}.freeze # `freeze` is just a precaution, as it will raise an error if any attempt is made to alter this constant

def word_to_digit(words)
  DIGIT_HASH.keys.each do |word|
    words.gsub!(/\b#{word}\b/, DIGIT_HASH[word]) # not sure what the second `\b` is for, since the first one is enough to make sure the substitution triggers with words only (not any substring)
  end
  words
end

## Further Exploration:

# Additional Problem 1: What if we also want to replace uppercase and capitalized words?

# Using LS solution...
# Need to 

def word_to_digit(words)
  DIGIT_HASH.keys.each do |word|
    words.gsub!(/\b#{word}\b/i, DIGIT_HASH[word]) # the `/i` after the pattern tells the regex to ignore case
  end
  words
end

# Additional Problem 2: Change solution so that the spaces between consecutive numbers are removed?

# Add conditional after replacement
# create empty output array
# create empty temp array to store consecutive numbers
# break transformed sentence into words
# iterate through words
#   if word is a numeric string, add to temp array
#   if word is not numeric string, push joined temp array (no separation) into output (if not empty)
#     then push current word into output
#     then reassign temp array to empty array (clear it for the next set of numbers) (if it wasn't empty already)
# output the joined array

def word_to_digit(words)
  DIGIT_HASH.keys.each do |numeric_string| # changed the name of the parameter so I don't confuse it with the words from the input
    words.gsub!(/\b#{numeric_string}\b/i, DIGIT_HASH[numeric_string])
  end

  output = []
  numbers = []

  words.split.each do |word|
    if /\b#{word}\b/i.match(DIGIT_HASH.values.join(' ')) # checking for a numeric string match in a way that pulls in any punctuation
      numbers << word
    elsif numbers.empty? # don't want to push or reset the numbers array if it's empty
      output << word
    else
      output << numbers.join
      output << word
      numbers = []
    end
  end

  output.join(' ')
end

# Additional Problem 3: Suppose the string already contains two or more space separated numbers (not words); can you leave those spaces alone, while removing any spaces between numbers that you create?

# To solve this I need to make the initial iteration do the job of clumping the numbers together after/as it transforms them, so that it only targets the numbers which were not preexisting
# instead of iterating through the digit hash keys first, swap value while iterating through the input (broken into words)
#   if word includes a word match for a numeric string already (like '5' or '5.'), push the whole word into the output array like a regular word
#   if a word includes a word match (ignoring case) for a digit hash key (like 'five' or 'FIVE'), push the appropriately associated value of the downcased word into the numbers array
#   continue from there as before

def word_to_digit(words)
  output = []
  numbers = []

  words.split.each do |word|
    if DIGIT_HASH.values.include?(word) # if the word is already a numeric string
      output << word
    elsif /\b#{word}\b/i.match(DIGIT_HASH.keys.join(' ')) # if the word is a number
      if DIGIT_HASH.keys.include?(word.downcase) # if there's no punctuation
        numbers << DIGIT_HASH[word.downcase]
      else
        numbers << (DIGIT_HASH[word.downcase[0..-2]] + word[-1])
      end
    elsif numbers.empty?
      output << word
    else
      output << numbers.join
      output << word
      numbers = []
    end
  end

  output.join(' ')
end

# Final challenge: What about dealing with phone numbers? Is there any easy way to format the result to account for phone numbers?
# For our purposes, assume that any 10 digit number is a phone number, and that the proper format should be "(123) 456-7890".

# For this I can simply add another branch to the (admittedly already unwieldy) if statement within the iteration
# Within the final else branch, I can add a sub if statement which formats the number array before pushing into the output if it has a size of 10 digits

def word_to_digit(words)
  output = []
  numbers = []

  words.split.each do |word|
    if DIGIT_HASH.values.include?(word) # if the word is already a numeric string
      output << word
    elsif /\b#{word}\b/i.match(DIGIT_HASH.keys.join(' ')) # if the word is a number
      if DIGIT_HASH.keys.include?(word.downcase) # if there's no punctuation
        numbers << DIGIT_HASH[word.downcase]
      else
        numbers << (DIGIT_HASH[word.downcase[0..-2]] + word[-1])
      end
    elsif numbers.empty?
      output << word
    else
      if numbers.size == 10
        phone = numbers.join
        output << "(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..10]}"
      else
        output << numbers.join
      end

      output << word
      numbers = []
    end
  end

  output.join(' ')
end

p word_to_digit("Almost done at 6:30! From this height I could see 5 9 year olds at six 2. Please call me at FIVE Five five one two three four five six seven. Thanks times 2!")

# If I were using this code within a larger program I'd want to go back through and employ some helper methods to make it more readable and compliant with rubocop
