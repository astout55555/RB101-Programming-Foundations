def average(array_of_pos_int)
  array_of_pos_int.sum / array_of_pos_int.length
end

# tests should print true
puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40

# Official solution uses #reduce AKA #inject, which is found in the Enumerable module

def average_official(numbers)
  sum = numbers.reduce { |sum, number| sum + number } # or simply numbers.reduce {:+}
  sum / numbers.count
end

# Further Exploration: Change return value of #average from Integer to a Float

def average_float(array_of_pos_int)
  Float(array_of_pos_int.sum) / array_of_pos_int.length # if numerator is float, stays a float after division
end # could also have used the #to_f method

puts average_float([1, 6]) == 3.5 # more accurate as a Float anyway
