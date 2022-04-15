### Part 1

=begin

Problem: write method that doubles all the characters in a string
input: string containing 0 or more characters
output: string with every character doubled, still in the same order

Algorithm:

break string into array of chars
map array onto new array, transformed by doubling every char
join this new array into a string
output string

=end

def repeater(string)
  string.chars.map { |char| char * 2 }.join('')
end


repeater('Hello') == "HHeelllloo"
repeater("Good job!") == "GGoooodd  jjoobb!!"
repeater('') == ''

### Part 2

=begin

Problem: write a new method which doubles only the consonants, returns the new string
input: string containing 0 or more characters
output: new string with all consonants doubled, kept in same order

Algorithm:

create empty results array
break string into array of chars
iterate through chars array
  use conditional, if char is a-z && not vowel
    double char before putting into results array
  otherwise just put into results array
join and return results array

=end

def double_consonants(string)
  modified_chars = []
  chars = string.chars
  chars.each do |char|
    if /[a-z&&[^aeiou]]/.match(char.downcase)
      modified_chars << (char * 2)
    else
      modified_chars << char
    end
  end

  modified_chars.join('')
end

p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""
