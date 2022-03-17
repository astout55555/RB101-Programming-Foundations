=begin

# Problem: 

input: string
output: new string, first character of every word capitalized, all others lowercase
Rules:
-first character, not first letter
-spaces denote new words
-lowercase letters that aren't supposed to be capitalized

# Algorithm:

break string into words
iterate through each word
  #downcase! the word
  #capitalize! it (uppercase the first char)
rejoin words into new string

=end

def word_cap(string)
  words = string.split
  words.each do |word|
    word.downcase! # don't need this. #capitalize already downcases other letters
    word.capitalize!
  end
  words.join(' ')
end

p word_cap('four score and seven') == 'Four Score And Seven'
p word_cap('the javaScript language') == 'The Javascript Language'
p word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

# LS solution uses #map, since this is an issue of transformation

def word_cap(words)
  words_array = words.split.map do |word|
    word.capitalize
  end
  words_array.join(' ')
end

# extra concise version:

def word_cap(words)
  words.split.map(&:capitalize).join(' ')
end

# (&:method_name) is shorthand notation for { |item| item.method_name }
# can use this with any method that has no required arguments

## Further Exploration: come up with 2 solutions that don't use String#capitalize

=begin

# Algorithm:

create empty results array
split string into words
iterate through words
  split each word into chars
    upcase! the first char
    downcase! the others
    rejoin into capitalized word
    insert word into results array
rejoin into string

=end

def word_cap(string)
  results = []
  words = string.split
  
  words.each do |word|
    letters = word.chars
    letters.each_with_index do |letter, index|
      letter.downcase!
      letter.upcase! if index == 0
    end

    results << letters.join
  end

  results.join(' ')
end

p word_cap('four score and seven') == 'Four Score And Seven'
p word_cap('the javaScript language') == 'The Javascript Language'
p word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

=begin

# once more, without #capitalize

# Algorithm:

split string into words
map words onto new variable
  upcase the first letter
  downcase the rest with extra long slice length
  return value of map is concatenation of these two values
rejoin words into result

=end

def word_cap(string)
  capitalized_words = string.split.map { |word| word[0].upcase + word[1, 200].downcase }
  capitalized_words.join(' ')  
end

p word_cap('four score and seven') == 'Four Score And Seven'
p word_cap('the javaScript language') == 'The Javascript Language'
p word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'
