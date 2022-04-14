=begin

# Problem: Make a program that constructs a madlibs story.
Prompt user for a noun, verb, adjective, and adverb, then output the story.

Algorithm:
prompt user for each word
save word to variable
output interpolated string for story with inputted words

=end

puts 'Enter a noun:'
noun = gets.chomp

puts 'Enter a verb:'
verb = gets.chomp

puts 'Enter an adjective:'
adjective = gets.chomp

puts 'Enter an adverb:'
adverb = gets.chomp

puts "I once saw a #{adjective} #{noun} on the street. The #{noun} suddenly started to 
#{verb} very #{adverb}. 'Boy I must be dreaming!' I said to myself."
