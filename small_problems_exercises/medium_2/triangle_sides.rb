=begin

Problem: 

input: 3 arguments, each an integer or float, representing sides of a triangle
output: a symbol
  -:invalid if the 2 shortest sides combined are not longer than the longest side
  -:equilateral if the sides are equal
  -:isosceles if only two sides are equal, and the triangle is valid
  -:scalene if all sides are different lengths, and the triangle is valid

Data/Algorithm:

take the side arguments into an array and sort! by size
  return :invalid if the first two combined aren't bigger than the last one

determine if all sides are equal to each other
  if so, return :equilateral

determine if only 2 sides are equal to each other
  check if the first and second or second and third sides are equal
  (this works because they are sorted by size, and because we already would have caught it if they were all equal)
  return :isosceles if so
  return :scalene if not (the only remaining option)

=end

def triangle(side_1, side_2, side_3)
  sides = [side_1, side_2, side_3].sort!

  return :invalid if sides[0] + sides[1] <= sides[2]

  return :equilateral if sides[0] == sides[2]

  return :isosceles if sides[0] == sides[1] || sides[1] == sides[2]

  :scalene
end

triangle(3, 3, 3) == :equilateral
triangle(3, 3, 1.5) == :isosceles
triangle(3, 4, 5) == :scalene
triangle(0, 3, 3) == :invalid
triangle(3, 1, 1) == :invalid

# I really like this solution found from a fellow student:

def triangle(side1, side2, side3) 
  sides = [side1, side2, side3].sort

  return :invalid unless sides[0,2].sum > sides.max 

  case(sides.uniq.size) # this part is brilliant, and way simpler to read
  when 1 then :equilateral
  when 2 then :isosceles
  when 3 then :scalene 
  end 
end 
