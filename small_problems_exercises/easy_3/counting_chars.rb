=begin

PEDAC

understand the Problem:

input: one or more words (a string)
output: total characters (except spaces)

Examples/test cases:

'walk' => 4
'walk, don't run' => 13

Data structure:

store input string as an array of characters

Algorithm:

solicit input from user (1 or more words)
store input as a string
convert string to array of characters
create new array by selecting all characters except spaces
display size of array in message to user

=end

puts 'Please enter one or more words:'
words = gets.chomp

characters_with_spaces = words.chars

characters_without_spaces = characters_with_spaces.select {|char| char != ' '}

puts "There are #{characters_without_spaces.size} characters in \"#{words}\"."

# fun fact: the #delete method doesn't work as well here if we convert to array
# #delete returns the deleted characters if called on an array
# (a problem I ran into before modifying my algorithm)
# but if we had just kept it as a string, then #delete returns the new string!
# the official solution uses this, which is simpler and clearer