=begin

Problem:

input: string
output: hash with three pairs
  -% of lowercase chars
  -% of uppercase chars
  -% of chars which are neither
  (% is given as a float, e.g. 50% == 50.0)

Data/Algorithm:

start with counter from easy exercises

``
def letter_case_count(string)
  counts = {}
  characters = string.chars
  counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }
  counts[:uppercase] = characters.count { |char| char =~ /[A-Z]/ }
  counts[:neither] = characters.count { |char| char =~ /[^A-Za-z]/ }
  counts
end
``

create a new method which will use the old one within it
call the old method and save that hash
iterate through the values of each key in that hash
  compare against total string length to find percentage (float division)
  mutate the hash so that the value is changed to a % for each category
return the mutated hash

=end

def letter_case_count(string)
  counts = {}
  characters = string.chars
  counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }
  counts[:uppercase] = characters.count { |char| char =~ /[A-Z]/ }
  counts[:neither] = characters.count { |char| char =~ /[^A-Za-z]/ }
  counts
end

def letter_percentages(string)
  hash = letter_case_count(string)

  hash.each do |category, count|
    percent = ((count.to_f / string.length) * 100).round(2) # added the rounding for the further exploration
    hash[category] = percent
  end

  hash
end

p letter_percentages('abCdef 123') == { lowercase: 50.0, uppercase: 10.0, neither: 40.0 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25.0 }
p letter_percentages('123') == { lowercase: 0.0, uppercase: 0.0, neither: 100.0 }
p letter_percentages('abcdefGHI') # results are rounded as required
