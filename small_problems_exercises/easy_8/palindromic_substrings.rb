=begin

Problem:

Write a method that returns a list of all substrings of a string that are palindromic. That is, each substring must consist of the same sequence of characters forwards as it does backwards.
The return value should be arranged in the same sequence as the substrings appear in the string. Duplicate palindromes should be included multiple times.

You may (and should) use the substrings method you wrote in the previous exercise.

For the purposes of this exercise, you should consider all characters and pay attention to case; that is, "AbcbA" is a palindrome, but neither "Abcba" nor "Abc-bA" are.
In addition, assume that single characters are not palindromes.

input: string
output: all the palindromic substrings as they appear left to right
  (this is a subset of all the substrings produced by the previou method)

Algorithm:

call #substrings and pass it the string as its argument, save all substrings in a variable
use selection to produce the array of palindromic substrings
  if substring is equal to itself reversed AND is more than 1 character then it meets the criteria
output this selected array

=end

def leading_substrings(string)
  output = []

  slice_length = 1
  while slice_length <= string.length
    output << string.slice(0, slice_length)
    slice_length += 1
  end

  output
end

def substrings(string)
  results = []
  (0...string.size).each do |start_index|
    this_substring = string[start_index..-1]
    results.concat(leading_substrings(this_substring))
  end
  results
end

def palindromes(string)
  substrings = substrings(string)
  
  palindromes = substrings.select do |substring|
                  (substring == substring.reverse) && (substring.length > 1)
                end

  palindromes
end

palindromes('abcd') == []
palindromes('madam') == ['madam', 'ada']
palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]

## Further Exploration

=begin

Problem: Modify methods to ignore non-alphanumeric characters and case

Algorithm:

modify the selection criteria by placing it in a helper method which can be more complex
  downcase substring to ignore case
  delete all non-alphanumeric characters before comparing

=end

def palindromes(string) # LS solution already has selection criteria separated
  all_substrings = substrings(string)
  results = []
  all_substrings.each do |substring|
    results << substring if palindrome?(substring)
  end
  results
end

def palindrome?(string)
  string = string.downcase # using reassignment within a method definition. we cannot mutate the original string after this
  string = string.gsub(/[^'a-z0-9']/, '') # replace all non-alphanumeric characters with empty strings, i.e. delete them
  string == string.reverse && string.size > 1
end

p palindromes('hello-madam-did-madam-goodbye') # now outputs things like '-madam' and 'madam-'

## Another round of further exploration:

# I probably want to generate the list of matches based on the modifications, rather than just having certain things not prevent matches but still increase the number of substrings I'm reviewing/collecting.
# To do that, I have to make the modifications before collecting them, otherwise I end up with a bunch of duplicates after removing special characters.
# i.e. I don't want '-did-+++' to give me 'did' 'did' 'did' 'did' etc. as the results, which is what happens if you remove the characters after generating the list

def substrings(string)
  results = []

  string = string.downcase.gsub(/[^'a-z0-9 ']/, '') # reassigning the method variable `string` so I can modify it. not changing the original object.

  (0...string.size).each do |start_index| # this was causing a bug. it was using the original size of the string, calling #leading_substrings at the same place in the substring twice, essentially.
    this_substring = string[start_index..-1] # if a special character is at the start of a substring (even if it gets removed during the #leading_substrings method), it will still cause duplicates.
    results.concat(leading_substrings(this_substring)) # i.e.: '&he' and 'he' generate the same list of substrings if you start by removing '&'.
  end # I fixed it by modifying the method variable `string` above, within the #substrings method, so it also changes the length within this method's scope.
  results
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('helLo-mad234am-did-+++]MaDAm-goodbye')
p palindromes('kni&tting 5 casSetTes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]

test_word = '%hello'
p leading_substrings(test_word)
p substrings(test_word)
p palindromes(test_word)
p test_word == '%hello' # I did not mutate the variable/string used as an argument
