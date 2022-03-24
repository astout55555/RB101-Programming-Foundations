=begin

# Problem: 

input: string (at least two words)
output: second-to-last word in the string
Rules:
-words are any sequence of non-blank characters

# Algorithm:

break string into words
return second-to-last via index -2

=end

def penultimate(string)
  string.split[-2]
end

penultimate('last word') == 'last'
penultimate('Launch School is great!') == 'is'

## Further Exploration:

=begin

# Problem:

input: string (could have 0, 1, or more words)
output: the middle word
Rules:
-if there is an even number of words, return the one with a higher index value
-if there is one word, return that word
-if there are no words, return an empty string

# Algorithm:

split string into words
use case statement to control flow based on size of the array of words
if array is empty return ''
if array has only 1 word return that word
if array has 2 or more words, return word which is at index -((size/2.0).ceil)

=end

def middle_word(string)
  words = string.split
  case words.size
  when 0 then return ''
  when 1 then return string
  else return words[-((words.size / 2.0).ceil)]
  end
end

p middle_word('hello this sentence has six words') == 'has'
p middle_word('I am only five words') == 'only'
p middle_word('hiya') == 'hiya'
p middle_word('') == ''
