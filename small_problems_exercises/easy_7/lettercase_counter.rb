=begin

# Problem:

input: string
output: hash with 3 labeled entries:
  number of lowercase characters
  number of uppercase characters
  number of characters which are neither (numbers, spaces, etc)

if provided string is empty the hash still displays but with 0s

# Algorithm:

start by creating variables `lowercase`, `uppercase`, and `neither` each with value of 0
break string into chars
iterate through chars
  if a..z includes char, increment `lowercase` by 1
  if A..Z includes char, increment `uppercase` by 1
  else increment `neither` by 1
create results hash which has these keys with values tied to these variables

=end

def letter_case_count(string)
  lowercase = 0
  uppercase = 0
  neither = 0

  string.chars.each do |char|
    lowercase += 1 if ('a'..'z').include?(char)
    uppercase += 1 if ('A'..'Z').include?(char)
    neither += 1 unless ( ('a'..'z').include?(char) || ('A'..'Z').include?(char) )
  end

  results = { lowercase: lowercase, uppercase: uppercase, neither: neither }
end

p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

# LS Solution 1 (similar to mine, with constants to clean up method insides a bit):

UPPERCASE_CHARS = ('A'..'Z').to_a
LOWERCASE_CHARS = ('a'..'z').to_a

def letter_case_count(string)
  counts = { lowercase: 0, uppercase: 0, neither: 0 }

  string.chars.each do |char|
    if UPPERCASE_CHARS.include?(char)
      counts[:uppercase] += 1
    elsif LOWERCASE_CHARS.include?(char)
      counts[:lowercase] += 1
    else
      counts[:neither] += 1
    end
  end

  counts
end

# LS Solution 2 (uses #count and regex for a concise definition):

def letter_case_count(string)
  counts = {}
  characters = string.chars
  counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }
  counts[:uppercase] = characters.count { |char| char =~ /[A-Z]/ }
  counts[:neither] = characters.count { |char| char =~ /[^A-Za-z]/ }
  counts
end

# Both construct the hash as they go, rather than changing values of variables
# and then creating the hash in one line at the end
