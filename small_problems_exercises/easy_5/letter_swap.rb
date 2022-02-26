=begin

input: string, at least one word, at least one letter per word, no punctuation
output: string with first/last letters swapped for each word

break string into words
iterate through each word
  break word into chars
  swap first/last letter
  return modified word
build new string with these modified words
 
=end

def swap(string)
  words = string.split
  words.map! do |word|
    letters = word.chars # can use `word[0], word[-1] = word[-1], word[0]`
    first_letter = letters.shift # this swaps the letters, then just use `word` to return new value
    last_letter = letters.pop # `a, b = b, a` is a common "idiom" 
    letters.prepend(last_letter).append(first_letter)
    letters.join
  end
  words.join(' ')
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'

## Further exploration:

=begin
No, we cannot use the following implementation, reassignment doesn't mutate!


def swap_first_last_characters(a, b)
  a, b = b, a
end

swap_first_last_characters(word[0], word[-1])

=end
