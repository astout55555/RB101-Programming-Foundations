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
