=begin

input: string
output: total 'ASCII' value

if string is empty return value should be 0
break string into characters
iterate through array of chars, call #ord on each and find sum
return sum value

=end

def ascii_value(string)
  return 0 if string == ''
  characters = string.chars
  value = 0
  characters.each { |char| value += char.ord }
  value
end

# Official solution:

def ascii_value(string)
  sum = 0  
  string.each_char { |char| sum += char.ord } # uses #each_char on string instead of first #chars then #each
  sum # although #ord called on an empty string produces an error, this never happens if there is no character to iterate over
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0

