### Part 1

=begin

Problem:

method must return true if palindrome, else false. case and all characters matter.
input: string
output: true or false

Examples:

palindrome?('madam') == true
palindrome?('Madam') == false          # (case matters)
palindrome?("madam i'm adam") == false # (all characters matter)
palindrome?('356653') == true

Data/Algorithm:

get string
change string to an array of characters
copy array and reverse order of the copy
compare copy to original
true if equal, else false

=end

def palindrome?(string)
  original = string.chars
  reversed = original.reverse
  original == reversed
end

# all examples print true
p palindrome?('madam') == true
p palindrome?('Madam') == false          # (case matters)
p palindrome?("madam i'm adam") == false # (all characters matter)
p palindrome?('356653') == true

# apparently you can just call #reverse on the string directly! so...
# string == string.reverse # all you need in the method


## Further Exploration:

# method for arrays is the same as official solution for strings:

def array_is_palindrome?(array)
  array == array.reversed
end

# method that takes either strings or arrays:

def any_palindrome?(string_or_array)
  string_or_array == string_or_array.reverse
end



### Part 2

=begin

Problem:

determine if string is palindrome except case-insensitive, ignore non-alphanumeric characters
input: string
output: true or false

Examples: 

real_palindrome?('madam') == true
real_palindrome?('Madam') == true           # (case does not matter)
real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
real_palindrome?('356653') == true
real_palindrome?('356a653') == true
real_palindrome?('123ab321') == false

Data/Algorithm:

take string as argument
call #downcase on string, convert downcased string to array of characters
iterate through array, delete all non-alphanumeric characters (not matching regex)
compare this to a reversed copy
return true if equal, else false

=end

def real_palindrome?(string)
  array_of_chars = string.downcase.chars
  array_of_chars.delete_if do |char|
    !char.match?(/\A[a-z0-9]\z/)
  end
  array_of_chars == array_of_chars.reverse
end

p real_palindrome?('madam') == true
p real_palindrome?('Madam') == true           # (case does not matter)
p real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
p real_palindrome?('356653') == true
p real_palindrome?('356a653') == true
p real_palindrome?('123ab321') == false
