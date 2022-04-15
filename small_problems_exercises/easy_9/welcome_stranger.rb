=begin

Problem:

Create a method that takes 2 arguments, an array and a hash. The array will contain 2 or more elements that, when combined with adjoining spaces, will produce a person's name.
The hash will contain two keys, :title and :occupation, and the appropriate values. Your method should return a greeting that uses the person's full name, and mentions the person's title and occupation.

input: two args, an array with 2 or more string elements, and a hash with 2 specified keys (symbols) and their values (strings)
output: interpolated string greeting based on the provided info

Algorithm:

create name variable, assign it the name array joined together with spaces
directly interpolate the elements needed for the greeting from there

=end

def greetings(name_array, profession_hash)
  full_name = name_array.join(' ')

  puts "Oh hi #{full_name}. I didn't see you there! Man am I glad to have a real #{profession_hash[:title]} #{profession_hash[:occupation]} in town!"
end # LS Solution just interpolates as #{name.join(' ')}, no need to do that separately.

greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
# => Hello, John Q Doe! Nice to have a Master Plumber around.

## Further exploration: Make it pass rubocop (less than 80 chars per line of code)

def greetings(name_array, profession_hash)
  name = name_array.join(' ')
  title = profession_hash[:title]
  occupation = profession_hash[:occupation]

  puts "Hello, #{name}! Nice to have a #{title} #{occupation} around."
end
