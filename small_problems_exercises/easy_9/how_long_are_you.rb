=begin

Problem:

input: string (may be empty, or have one or more words)
output: array of strings, each of them composed of a word from the original string followed by the length of that word, in order
note: empty string should return an empty array

Algorithm:

break string into words
transform array of words
  find length of each word
  return concatenated string of word + space + word length (string), transforming each element
output the transformed array

=end

def word_lengths(string)
  string.split(' ').map do |word|
    word + ' ' + word.length.to_s
  end
end

word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]

word_lengths("baseball hot dogs and apple pie") ==
  ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

word_lengths("It ain't easy, is it?") == ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

word_lengths("Supercalifragilisticexpialidocious") ==
  ["Supercalifragilisticexpialidocious 34"]

word_lengths("") == []

# The most concise LS Solution:

def word_lengths(string)
  string.split.map { |word| "#{word} #{word.length}" } # a little easier to read than mine, interpolation is typically preferable it seems
end
