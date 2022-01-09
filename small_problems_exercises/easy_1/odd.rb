def is_odd?(number)
  number % 2 == 1 # checks if odd; modulo returns positive number even if number was negative
end # I'd initially used if/then and checked if number.abs % == 0 (was even), but this is simpler

puts is_odd?(2)   # => false
puts is_odd?(5)   # => true
puts is_odd?(-17) # => true
puts is_odd?(-8)  # => false
puts is_odd?(0)   # => false
puts is_odd?(7)   # => true

# Further Exploration

# alternate solution would work whether % was modulo or remainder in Ruby,
# since I'm checking with #abs, which bypasses the issue

def is_odd_alt?(number)
  number.abs.remainder(2) == 1 # works even by finding the remainder. could also swap order of #abs and #remainder
end

puts is_odd_alt?(2)    # => false
puts is_odd_alt?(5)    # => true
puts is_odd_alt?(-17)  # => true
puts is_odd_alt?(-8)   # => false
puts is_odd_alt?(0)    # => false
puts is_odd_alt?(7)    # => true