=begin

Problem:

def method that determines which of two string args is longer, then
 concatenates shorter string, then longer, then shorter
inputs: two string args
outputs: one string

Examples:

short_long_short('abc', 'defgh') == "abcdefghabc"
short_long_short('abcde', 'fgh') == "fghabcdefgh"
short_long_short('', 'xyz') == "xyz"

Data/Algorithm:

working with strings.
compare string lengths in conditional flow
concatenate based on variable positions (1 2 1) or the reverse
return string

=end

def short_long_short(string1, string2)
  if string1.length > string2.length
    string2 + string1 + string2
  else
    string1 + string2 + string1
  end
end

p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"
# these print true
