=begin

Problem: 

input: string
output: true (if all alphabetic chars are uppercase); or false (if not)

Algorithm:

check if the string.upcase == string

=end

def uppercase?(string)
  string == string.upcase
end

p uppercase?('t') == false
p uppercase?('T') == true
p uppercase?('Four Score') == false
p uppercase?('FOUR SCORE') == true
p uppercase?('4SCORE!') == true
p uppercase?('') == true

## Further Exploration: Does it make sense to return `true` for an empty string?

# I'd say yes depending on why we're checking.
# If we want to know if upcasing the string would cause any change, then yes.
# If we want to know if the string contains no lowercase alphabetic characters, then also yes.
# However, if we want to know that there are in fact uppercase alphabetic characters, and no lowercase ones, then it should return false instead.
