=begin

Problem:

read text from a text file and plug in random appropriate words based on type, and prints

input: the text file and the data structure containing the replacement words
output: the madlib with the words swapped out as appropriate

Data:

reading the file into this file will bring it over as one big string

I'll represent the replacement words in a hash
  each part of speech will be a key associated with an array of words

Algorithm:

read the txt file into this file as a string

use a helper method to replace words based on the type, pass the type as an arg
  use #sub! to find any placeholder and replace
  replace with a random word from the appropriate array in the word hash
  repeat until there are no more matches

iterate through all the keys of the word hash, passing them as args to the helper method

=end

REPLACEMENT_WORDS = {
  adjective: ['quick', 'lazy', 'sleepy', 'ugly'],
  noun: ['fox', 'bread', 'human', 'bus'],
  verb: ['kicks', 'eats', 'smooshes', 'levitates'],
  adverb: ['eagerly', 'passively', 'strangely', 'excitedly']
}

def insert_words!(file_text, part_of_speech)
  while file_text.match("%{#{part_of_speech}}")
    file_text.sub!("%{#{part_of_speech}}", REPLACEMENT_WORDS[part_of_speech].sample)
  end
end

def madlib(file)
  file_text = File.read(file)

  REPLACEMENT_WORDS.each do |part_of_speech, _|
    insert_words!(file_text, part_of_speech)
  end

  puts file_text
end

madlib('madlibs_text.txt')
