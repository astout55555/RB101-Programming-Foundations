=begin

input: string (empty or one or more words)
output: hash showing number of words of each size found (empty hash for empty string)

break string into array of words
create empty hash
iterate through words
  if key doesn't yet exist,
    create key of word.length with value of 1
  else
    key's value += 1
output hash

=end

def word_sizes(string)
  words = string.split(' ')
  sizes_hash = {}
  words.each do |word|
    size = word.length
    if sizes_hash.key?(size)
      sizes_hash[size] += 1
    else
      sizes_hash[size] = 1
    end
  end
  sizes_hash
end

word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
word_sizes('') == {}

# Official Solution:

def word_sizes(words_string)
  counts = Hash.new(0) # ensures that if the key does not yet exist, the value is 0, allowing you to add 1 to it
  words_string.split.each do |word| # chains together to shorten
    counts[word.size] += 1 # because of the way the hash was initialized, no need for conditionals
  end
  counts
end

### Part 2 (modify to exclude non-letter characters)

# a simple #delete would do it

def word_sizes(words_string)
  counts = Hash.new(0)
  words_letters_only = words_string.delete("^a-z", "^A-Z", "^ ") # also saved to new variable, so I don't have "side-effects" with this method
  words_letters_only.split.each do |word|
    counts[word.size] += 1
  end
  counts
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
p word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
p word_sizes('') == {}

# Official Solution below:

def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    clean_word = word.delete('^A-Za-z') # if done within the iteration I don't need to avoid deleting spaces. also note, can group conditions together, don't always need separate strings for #delete
    counts[clean_word.size] += 1
  end
  counts
end
