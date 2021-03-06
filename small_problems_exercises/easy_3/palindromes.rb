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

# you can instead use String#delete, which uses rules that look
# similar to a regex when determining what to delete


### Palindromic Numbers

=begin

Prob: method returns true if integer arg is a palindrome, else false

Examples: found in exercise

Data/Alg: convert to string, check if reverse == original

=end

require 'pry'

def palindromic_number?(number)
  number.to_s == number.to_s.reverse
end

# these all print true
p palindromic_number?(34543) == true
p palindromic_number?(123210) == false
p palindromic_number?(22) == true
p palindromic_number?(5) == true


## Further Exploration: Does this work with a number that starts with a 0?

p palindromic_number?(0012100) == true # doesn't work, prints false

# starting a number literal with a 0 tells Ruby to read it as an "octal" number
# e.g. 0252 or 00252 == 170
# however, I can convert the number back to decimal when converting to string #to_s(8)

=begin

Prob: method returns true if integer arg is a palindrome, else false
do so even if the number begins with one or more `0`

I need to be able to compare the reverse order of the actual digits provided
if there are leading 0s, I need to know how many so I can take that into account
I know any octal number will have at least one 0 provided, but could be more than one
I know any octal number that doesn't end with at least one 0 is not a palindrome

...
like most other students I was unable to find a way to solve this problem
unless we are given a string via user input in the first place,
rather than passing the method an argument
because I can't tell the difference between `0253` and `171`,
and any conversion or check I do will be done with the numeric value of the reference passed, not the literal digits
...

=end

# the below is borrowed from another student, for this problem
# it only works if there was only one leading 0, and you also
# have to know it was an octal number in the first place.
# but this is what I was thinking is the best we can do for this problem

def octal_palindrome?(integer)
  octal_number = integer.to_s(8)

  if !octal_number.end_with?('0')
    return false
  else
    while octal_number.end_with?('0')
      octal_number.chop!
    end
  end

  octal_number = octal_number.reverse
end
