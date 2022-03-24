=begin

# Problem: 

input: string of one or more words
output: new string with casing swapped, special characters the same
Rules:
-cannot use String#swapcase, instead we create it from scratch

# Algorithm:

break string into chars
iterate through chars
  if char matches A-Z, downcase! it
  if char matches a-z, upcase! it
  else leave it alone
rejoin chars into output string

=end

def swapcase(string)
  characters = string.chars
  characters.each do |char|
    case char
    when (/[a-z]/) then char.upcase!
    when (/[A-Z]/) then char.downcase!
    end
  end
  characters.join
end

swapcase('CamelCase') == 'cAMELcASE'
swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'
