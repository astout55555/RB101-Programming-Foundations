=begin

# Problem:

input: array of strings (1 or more)
output: array of strings with vowels removed
  empty string if no characters left

# Algorithm:

create empty new array
iterate through array of strings
  delete lowercase vowels and delete uppercase vowels
  push remaining string into new array
  return new array

=end

def remove_vowels(array_of_strings)
  result = []

  array_of_strings.each do |string|
    result << string.delete("aeiou").delete("AEIOU")
  end

  result
end

# Official solution:

def remove_vowels(strings) # uses map, no need to separately push each element into new array!
  strings.map { |string| string.delete('aeiouAEIOU') } # can include both sets in single #delete call
end


remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']
