=begin

input: string which may contain duplicate characters
output: string without duplicate characters
condition: cannot use #squeeze or #squeeze!

crunch('ddaaiillyy ddoouubbllee') == 'daily double'
crunch('4444abcabccba') == '4abcabcba'
crunch('ggggggggggggggg') == 'g'
crunch('a') == 'a'
crunch('') == ''

break string into characters
save empty string in variable
iterate through chars
  add to string unless char matches previous char
output string

=end

def crunch(string)
  de_duped_string = ''
  previous_char = ''
  string.chars.each do |char|
    de_duped_string << char unless char == previous_char
    previous_char = char
  end
  de_duped_string
end

p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''

# Official Solution:

def crunch(text)
  index = 0
  crunch_text = ''
  while index <= text.length - 1
    crunch_text << text[index] unless text[index] == text[index + 1]
    index += 1
  end
  crunch_text
end

## Further Exploration: Try solving again using a regexp.

# I'll come back to this one after I learn more about regexp.
