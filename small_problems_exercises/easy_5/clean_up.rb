=begin

input: string with any number of lowercased words including any number of non-aphabetic characters
output: string with only alphabetic characters, spaced no more than 1 space apart

Example:

cleanup("---what's my +*& line?") == ' what s my line '

replace non-alphabetic chars with spaces
squeeze string to remove all excess spaces

=end

def cleanup(string)
  string.gsub(/[^a-z]/, ' ').squeeze(' ')
end

p cleanup("---what's my +*& line?") == ' what s my line '
