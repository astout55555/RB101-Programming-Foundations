def sum(pos_integer) # return sum of the digits
  digits = pos_integer.to_s.chars.map!(&:to_i)
  digits.sum
end

# tests should print true
puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45

# To do this without any basic looping constructs (while, until, loop, or each) or even #map, try this:

def challenge_sum(pos_integer)
  pos_integer.digits.sum # found this answer from another student
end

puts challenge_sum(23) == 5
puts challenge_sum(496) == 19
puts challenge_sum(123_456_789) == 45