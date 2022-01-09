def digit_list(positive_integer)
  arr_of_string_digits = positive_integer.to_s.split(//)
  arr_of_string_digits.map { |character| character.to_i }
end

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true

# could also use my plan with a single line, using the #chars method
# `positive_integer.to_s_chars.map(&:to_i)`
