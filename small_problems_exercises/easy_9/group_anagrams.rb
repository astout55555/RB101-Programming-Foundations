=begin

Problem:

input: array of words (strings)
output: a series of 1 or more arrays, each containing two or more words (strings) that are anagrams for each other

Algorithm:

create an empty array for all outputed anagram group subarrays (complete anagram group array)

iterate through the main word array
  for each word, create an empty anagram group array
  insert current word into current anagram group array
  save current word as variable for comparison
  from there, iterate again through all the words in the main array
    use helper method to check if the comparison word and the current iteration word are anagrams
    if so, move current iteration word into current anagram group array
  move the filled up anagram group array into the complete group list array

remove duplicate arrays from the master list
iterate through master list
  iterating through anagram groups
    remove duplicate words
  print group to the screen 

helper method, is_anagram?(word_one, word_two)
  break each word into chars, sort
  see if they are equivalent, return true or false
  
=end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
  'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
  'flow', 'neon']

def is_anagram?(word_one, word_two)
  word_one.chars.sort == word_two.chars.sort
end

def group_anagrams(words_array)
  master_anagram_array = []

  words_array.each do |word|
    current_anagram_group = []
    current_anagram_group << word
    word_to_compare = word

    words_array.each do |current_word|
      current_anagram_group << current_word if is_anagram?(word_to_compare, current_word)
    end

    master_anagram_array << current_anagram_group
  end

  master_anagram_array.each { |anagram_group| anagram_group.sort!.uniq! }
  master_anagram_array.uniq!.each { |anagram_group| p anagram_group }
end

group_anagrams(words) # output should look like below:
# ["demo", "dome", "mode"]
# ["neon", "none"]
# (etc)

# My solution works! But by trying to work only with arrays, I made more trouble for myself, since I created so many duplicates and had to manage sorting things out afterwards.
# I also was not instructed to create an actual method, so I've got a few extra lines of code from that

# The LS Solution:

result = {} # uses a master hash instead of a master array, allowing for greater organization

words.each do |word|
  key = word.split('').sort.join # uses keys (of the sorted letters for a set of anagrams joined back into a single string)
  if result.has_key?(key)
    result[key].push(word) # if the key is already in the hash, adds the current word to the array values (array of the words for the anagram group tied to a single key)
  else
    result[key] = [word] # if the key is not yet in the hash, create it with a single-element array of the current word as the value
  end
end

result.each_value do |v|
  puts "------"
  p v
end
