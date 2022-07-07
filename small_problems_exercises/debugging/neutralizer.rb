## Original Code:

def neutralize(sentence)
  words = sentence.split(' ')
  words.each do |word| # attempts to iterate through the array while modifying it, a no-no
    words.delete(word) if negative?(word) # misses 'boring' because once 'dull' is deleted,
  end # the next word, at index 2, is 'cards', since 'boring' is now at index 1

  words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.

## Debugged Code:

def neutralize(sentence)
  words = sentence.split(' ')
  neutral_words = [] # added a place to store the neutral words as we go
  words.each do |word|
    neutral_words << word unless negative?(word) # simply skips the negative words
  end

  neutral_words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected/Actual: These cards are part of a board game.

## LS Solution:

def neutralize(sentence)
  words = sentence.split(' ')
  words.reject! { |word| negative?(word) } # #reject! technically does mutate while iterating,
  words.join(' ') # but it functions in a way to account for that, only excludes negative words
end # in general, we can consider #reject! a mutating method rather than one we'd use to iterate

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
#=> These cards are part of a board game.

## Further Exploration: an implementation of #reject! in ruby

def mutating_reject(array)
  i = 0
  loop do
    break if i == array.length

    if yield(array[i]) # if array[i] meets the condition checked by the block
      array.delete_at(i)
    else
      i += 1
    end
  end

  array
end
