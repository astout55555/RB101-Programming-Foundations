=begin

Problem:

create a method that displays an 8-pointed star in an n x n grid
n is an odd integer >= 7

input: `n` => odd integer >= 7
output: star made of '*', 8 points, n x n grid

notes/rules:

middle line is made of n '*' characters
line immediately above and below middle line is always 3 '*' characters, centered
every line further away is made of 3 '*' characters, spaced by 1, then 2, 3, etc.
i.e. aside from center line, lines are made of 3 '*' characters,
  spaced apart by x - 1, where x is the number of lines away from the center.
  this also means the spaces on the outside of the edge '*' chars is the reverse,
  i.e. in a star formed by the int arg 9, the spaces between go 3, 2, 1, 0,
  while the spaces outside the edge '*' chars go 0, 1, 2, 3.
  this pattern is formed using the numbers 0 through (n/2.rounded_down - 1),
  e.g. for n = 7, the spaces go 2, 1, 0 and 0, 1, 2.
  finally, the spaces are reversed for the bottom half of the star

Data/Algorithm:

take the integer arg and find the center line (n / 2 rounded up)
in a loop counting from 0 to max_spaces (center - 2)
  form lines with stars with spaces between stars of max_spaces - counter,
  and spaces before and after stars at size of counter
print center line of n stars
print bottom half of lines using reverse, counting from max_spaces to 0

=end

def star(n)
  return "Error!" if n < 7 || n.even?

  max_spaces = (n / 2) - 1

  0.upto(max_spaces) do |i|
    puts "#{' ' * i}*#{' ' * (max_spaces - i)}*#{' ' * (max_spaces - i)}*#{' ' * i}"
  end # the above line wouldn't pass rubocop, too long

  puts '*' * n

  max_spaces.downto(0) do |i|
    puts "#{' ' * i}*#{' ' * (max_spaces - i)}*#{' ' * (max_spaces - i)}*#{' ' * i}"
  end
end

star(7)
star(9)
star(2)
star(13)

## LS Solution:

def print_row(grid_size, distance_from_center)
  number_of_spaces = distance_from_center - 1 # basing the spaces on the distance var makes this easier to parse
  spaces = ' ' * number_of_spaces # saving this to a `spaces` var saves some space
  output = Array.new(3, '*').join(spaces) # very clever way to construct the line with correct spacing
  puts output.center(grid_size)
end

def star(grid_size) # the various space-saving measures allow a more descriptive parameter name
  max_distance = (grid_size - 1) / 2 # the `- 1` is unnecessary, but makes it clearer
  max_distance.downto(1) { |distance| print_row(grid_size, distance) }
  puts '*' * grid_size 
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end # like my solution, upper and lower halves are produced separately, but more legibly
