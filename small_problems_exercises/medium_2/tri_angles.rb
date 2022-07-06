=begin

Problem: 

input: 3 arguments, each an integer, representing the angles of a triangle
output: a symbol
        :invalid if the angles don't add up to 180 or if any is 0
        :right if one angle is 90
        :obtuse if one angle is above 90
        :acute if all angles are below 90

Data/Algorithm:

sort the angles in an array
check for validity first, returning :invalid if a condition is met
return value based on size of biggest angle only (>, =, < 90)

=end

def triangle(angle_1, angle_2, angle_3)
  angles = [angle_1, angle_2, angle_3].sort

  return :invalid if angles.sum != 180 || angles.include?(0)

  if angles[2] > 90
    :obtuse
  elsif angles[2] == 90
    :right
  else
    :acute
  end
end

p triangle(60, 70, 50) == :acute
p triangle(30, 90, 60) == :right
p triangle(120, 50, 10) == :obtuse
p triangle(0, 90, 90) == :invalid
p triangle(50, 50, 50) == :invalid

# LS Solution: Not necessarily better, but uses some tricks I should keep in mind

def triangle(angle1, angle2, angle3)
  angles = [angle1, angle2, angle3] # doesn't sort them, but uses the array

  case # a case statement without a value in the first line, used to replace if/elsif/else
  when angles.reduce(:+) != 180, angles.include?(0) # uses `,` to check 2 conditions
    :invalid
  when angles.include?(90)
    :right
  when angles.all? { |angle| angle < 90 }
    :acute
  else # could also use `angles.any? { |angle| angle > 90 }`
    :obtuse
  end
end
