### Q1

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.key?('Spot') # returns false, as 'Spot' is not a key in the hash

## bonus: use two more hash methods to check if 'Spot' is present

ages.include?('Spot') # returns false
# in fact, #key?, #has_key?, and #member? are all aliases for #include?

ages.assoc('Spot') # a bit different--returns nil because there is no such key

p ages.fetch('Spot', 'no such key')
# returns 'no such key' as the default value when 'Spot' is not found
# without 2nd arg this would raise an error

### Q2

munsters_description = "The Munsters are creepy in a good way."

puts munsters_description.swapcase
puts munsters_description.capitalize
puts munsters_description.downcase
puts munsters_description.upcase

### Q3

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages['Marilyn'] = 22
ages['Spot'] = 237

# more efficient: `ages.merge!`(additional_ages)

p ages

### Q4

advice = "Few things in life are as important as house training your pet dinosaur."
advice.include?('Dino') # could also use #match?

### Q5

flinstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flinstones

### Q6

# flinstones.append('Dino') # or flinstones << 'Dino', or use #push or #concat

### Q7

flinstones.concat(['Dino', 'Hoppy']) #add more than one item at once in an array
# could also use flinstones.push('Dino').push('Hoppy') chained together
# flinstones.push('Dino', 'Hoppy') also works, using multiple args

### Q8

advice = "Few things in life are as important as house training your pet dinosaur."
# advice.slice!('Few things in life are as important as ')
# #slice! mutates the string, cutting out and returning the specified portion
# however, `advice.slice!(0, advice.index('house'))` is preferable
# this way I start at the beginning and go for the length of the string up until 'house'


p advice # prints 'as house training your pet dinosaur.'
# advice would be unaltered if we had used #slice instead

### Q9

statement = "The Flintstones Rock!"

statement.count('t')

### Q10

title = "Flintstone Family Members"
title.center(40) # returns centered string within 40 characters width
