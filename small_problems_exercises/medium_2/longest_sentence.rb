=begin

Problem:

write program that reads a text file (.txt) and prints the longest sentence (sentences determined/ended by '.', '?', or '!') along with the total number of words in that sentence

input: file.txt
output: string (longest sentence from the file), and integer (total words in that sentence)

Algorithm:

(high level)
1. method must somehow access the file referenced by the argument it is passed and retrieve the contents, store in a variable
2. break text into sentences based on punctuation
3. iterate through all sentences, breaking them into words
  determine total words of each and store string value and total words integer value of the longest one as it goes
4. print the stored string value and the stored length

=end

require 'yaml'
example_text = YAML.load_file('example.yml') # this is one previously seen method for loading files, and it works just fine for the example text (the Gettysburg Address) 

frankenstein = File.read('frankenstein') # the YAML parser 'Psych' doesn't like the syntax in this file, so instead we're just "reading in" the text of the file as a long string
# this is better for our purposes here since we just want the string, and don't actually need to manipulate the file or keep special syntax

def find_longest_sentence(text_file)
  sentences = text_file.split(/[\.\?!]/)

  longest_sentence = ''
  longest_word_count = 0

  sentences.each do |sentence|
    current_sentence_words = sentence.split.size
    if current_sentence_words >= longest_word_count
      longest_sentence = sentence
      longest_word_count = current_sentence_words
    end
  end

  puts "This is the longest sentence I found, clocking in at #{longest_word_count} words."
  puts longest_sentence
end

# find_longest_sentence(example_text)
find_longest_sentence(frankenstein)

# LS Solution:

# text = File.read('sample_text.txt')
# sentences = text.split(/\.|\?|!/) # alternate syntax but does the same thing
# largest_sentence = sentences.max_by { |sentence| sentence.split.size } # this is especially useful, makes a lot of other code I used unnecessary (iteration with an if statement)
# largest_sentence = largest_sentence.strip # this gets rid of the extra whitespace at the beginning of the sentence
# number_of_words = largest_sentence.split.size

# puts "#{largest_sentence}"
# puts "Containing #{number_of_words} words"
