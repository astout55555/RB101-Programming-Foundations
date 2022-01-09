# Part 1

def reverse_sentence(sentence)
  words = sentence.split
  reversed_sentence = words.reverse.join(' ')
end # could also just use `string.split.reverse.join(' ')`

# following tests print true
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
puts reverse_sentence('') == ''
puts reverse_sentence('    ') == '' # Any number of spaces results in ''

# Part 2

def reverse_words(sentence) # prints new sentence with words of 5 characters or more reversed
  words = sentence.split
  words.each do |word|
    if word.length >= 5
      word.reverse!
    end
  end
  new_sentence = words.join(' ')
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS