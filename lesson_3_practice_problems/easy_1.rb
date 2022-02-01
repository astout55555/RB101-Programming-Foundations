# Question 1

numbers = [1, 2, 2, 3]
numbers.uniq # does not mutate the caller

puts numbers # prints original array on 4 lines


# Q2

# `!` at the end of a method name typically denotes a destructive method
# but this is not required for a method to be destructive, it's just the style.
# `?` at the end of a method name typically denotes a predicate method,
# meaning that the method returns `true` or `false`. again, it's just style.
# `!` also has other uses, where it is an actual operator or component of one.

#1 `!=` means 'not equal to' and is used to make sure two operands are different.
#2 putting `!` before something, like `!user_name` will negate the variable.
# i.e. if user_name has a truthy value then `!user_name` will evaluate to false.
#3 putting `!` after something, like `words.uniq!` may make it a destructive method.
# however, not always. some methods do not have a destructive version ending with `!`
# and in those cases, this will raise an 'undefined method' error.
#4 putting `?` before an array in irb locks you into something odd, had to ^C to get out...
# it seems to open up a new irb session within it? and it's picky about syntax...
#5 putting `?` after something will either cause something to match an existing
# method name, like #even?, or else it will be treated as the start of the
# ternary operator (?:), like so: `true? 'eval to true' : 'eval to false'`
#6 putting `!!` before anything will convert it to a boolean value. any
# truthy value becomes true, any falsy value becomes false (negated twice).


# Q3

advice = "Few things in life are as important as house training your pet dinosaur."
advice.sub!('important', 'urgent')
puts advice


# Q4

numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1) # deletes (and returns) element at index 1
p numbers # prints [1, 3, 4, 5]

numbers = [1, 2, 3, 4, 5] # reset between examples
numbers.delete(1) # deletes (and returns) the element with the value 1
p numbers # prints [2, 3, 4, 5]


# Q5 (Programmatically determine if 42 lies between 10 and 100.)

puts (10..100).include?(42) # prints true. could also use #cover?


# Q6

famous_words = "seven years ago..."
full_quote = famous_words.prepend('Four score and ')
puts full_quote

famous_words = "seven years ago..."
full_quote_2 = 'Four score and ' + famous_words
puts full_quote_2


# Q7

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten! # make it an un-nested array

p flintstones


# Q8

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

just_barney = flintstones.to_a[2] # could also use #assoc, `flinstones.assoc('Barney')`

p just_barney
