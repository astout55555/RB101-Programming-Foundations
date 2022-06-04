=begin

input: integer, always odd
output: image of a diamond made up of '*' in the n by n grid
(this means '*' surrounded by ' ', scaling up from 1 '*' by 2 at a time until n, then back down 2 at a time until 1)

Algorithm:

for each line
  determine how many '*' to place
  divide remainder of spaces by 2
  interpolate blanks, '*', blanks

start by finding halfway point (int/2 + 1 [to round up instead of down])
from 1 until then, number of '*' is line number * 2 - 1
after halfway point, '*' total is int - 2 for every line after midway point

=end

def diamond(int)
  center = int / 2 + 1
  stars = 1
  1.upto(int) do |line|
    margin = ' ' * ((int - stars) / 2)
    puts "#{margin}#{'*' * stars}#{margin}"

    if line < center
      stars += 2
    else
      stars -= 2
    end
  end
end

diamond(1)
diamond(3)
diamond(9)

# LS Solution: makes use of helper method based on distance from center, and the #center method

def print_row(grid_size, distance_from_center)
  number_of_stars = grid_size - 2 * distance_from_center
  stars = '*' * number_of_stars
  puts stars.center(grid_size)
end

def diamond(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(0) { |distance| print_row(grid_size, distance) }
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

## Further Exploration:

=begin

modify my solution or LS solution to print only the outline of the diamond, like so:

diamond(5)

  *
 * *
*   *
 * *
  *

Algorithm:

same as above, except:

instead of printing block of stars, use helper method to find value of middle insert

if stars - 2 > 0, then print ('*', blanks * `stars -2`, '*')
otherwise, print '*'

=end

def determine_middle_insert(stars, outline)
  if outline
    if stars - 2 > 0
      ('*' + (' ' * (stars - 2)) + '*')
    else
      '*'
    end
  else
    '*' * stars
  end
end

def diamond(int, outline = false)
  center = int / 2 + 1
  stars = 1
  1.upto(int) do |line|
    margin = ' ' * ((int - stars) / 2)
    middle = determine_middle_insert(stars, outline)
    puts "#{margin}#{middle}#{margin}"

    if line < center
      stars += 2
    else
      stars -= 2
    end
  end
end

diamond(9, true)
diamond(9, false)
diamond(5, false)
diamond(5, true)
diamond(3, true)
diamond(1, true)
