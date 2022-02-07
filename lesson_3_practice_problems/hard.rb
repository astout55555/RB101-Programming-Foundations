require 'pry'

### Q1

if false
  greeting = "hello world"
end

greeting # guess: this will raise an error, the code initializing the variable is never run
# answer: not quite right. greeting is initialized but with a value of nil, because the code assigning the value is never run


### Q2

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings # prints the hash, which now has a key value pair of
# :a and 'hi there' (we pointed the `informal_greeting` variable to it
# and then mutated the value, changing the original hash)
# prints as: {:a=>"hi there"}


### Q3

## A

def mess_with_vars(one, two, three)
  one = two # local method variable `one` reassigned to 'two'
  two = three # local method variable `two` reassigned to 'three'
  three = one # local method variable `three` reassigned to 'two'
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # 'one'
puts "two is: #{two}" # 'two'
puts "three is: #{three}" # 'three' # variables outside method never changed

## B

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one" # reassignments are to string values shown
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # 'one'
puts "two is: #{two}" # 'two'
puts "three is: #{three}" # 'three' # variables are not changed, again

## C

def mess_with_vars(one, two, three)
  one.gsub!("one","two") # object assigned to variable `one` is mutated, string replaced with 'two'
  two.gsub!("two","three") # mutated to 'three'
  three.gsub!("three","one") # mutated to 'one'
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # 'two'
puts "two is: #{two}" # 'three'
puts "three is: #{three}" # 'one'


### Q4

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  if dot_separated_words.size == 4
    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      if !is_an_ip_number?(word)
        return false
      end
    end
    return true
  else
    return false
  end
end

# cleaner solution:

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end

  true
end
