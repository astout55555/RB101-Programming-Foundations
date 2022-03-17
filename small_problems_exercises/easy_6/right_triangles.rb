=begin

# Problem: create a right triangle out of `*` symbols based on inputted height
input: integer
output: right triangle with sides equal to integer
Rules:
-right angle should be at bottom right of triangle
-start with a single `*`
-each subsequent row adds another `*`, so each row's length is equal to the row number

# Algorithm:

create counter for row number
loop to create triangle until image is correct size
  print `*` multiplied by row number, right-justified with blank spaces equal to input integer minus row
  break after final row == input integer

=end

def triangle(height)
  row = 0

  until row == height
    row += 1
    stars = '*' * row
    blanks = ' ' * (height - row)
    puts( "#{blanks}" + "#{stars}" )
  end
end

# triangle(5)
# triangle(9)

## Further Exploration:

# Problem: make an upside down triangle instead

def upside_down_triangle(height)
  row = height
  
  while row > 0
    stars = '*' * row
    blanks = ' ' * (height - row)
    puts( "#{blanks}" + "#{stars}" )
    row -= 1
  end
end

# upside_down_triangle(5)
# upside_down_triangle(9)

# Problem: now make it so I can display the triangle at any corner

=begin

input: height (integer), corner (string)
output: right triangle, same as before, with corner at location chosen

# Data/Algorithm:

use array to store each option ('top-left', 'top-right', 'bottom-left', 'bottom-right')
give error message if arg does not match option from array
use bottom-right as default

use case statement to control outcome, running one of 4 sub-methods or else giving error

use same methods as before except flip order of blanks and stars for reversed triangles

=end

CORNERS = ['top-left', 'top-right', 'bottom-left', 'bottom-right']

def right_triangle(height, corner='bottom-right')
  case corner
  when 'top-left'
    row = height
    while row > 0
      stars = '*' * row
      blanks = ' ' * (height - row)
      puts( "#{stars}" + "#{blanks}" )
      row -= 1
    end

  when 'top-right'
    row = height
    while row > 0
      stars = '*' * row
      blanks = ' ' * (height - row)
      puts( "#{blanks}" + "#{stars}" )
      row -= 1
    end

  when 'bottom-left'
    row = 0
    until row == height
      row += 1
      stars = '*' * row
      blanks = ' ' * (height - row)
      puts( "#{stars}" + "#{blanks}" )
    end

  when 'bottom-right'
    row = 0
    until row == height
      row += 1
      stars = '*' * row
      blanks = ' ' * (height - row)
      puts( "#{blanks}" + "#{stars}" )
    end

  else
    puts "Not a valid corner. Select only from: #{CORNERS}"
  end
end

right_triangle(1)
right_triangle(5, 'right-and-up')
right_triangle(5)
right_triangle(9)
right_triangle(5, 'bottom-left')
right_triangle(9, 'bottom-left')
right_triangle(5, 'top-left')
right_triangle(9, 'top-left')
right_triangle(5, 'top-right')
right_triangle(9, 'top-right')
right_triangle(5, 'bottom-right')
right_triangle(9, 'bottom-right')
