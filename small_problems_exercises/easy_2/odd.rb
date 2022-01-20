array_of_num = (1..99).to_a

array_of_num.each do |num|
  puts num if num.odd?
end

# Further Exploration: Another solution outside the above and the official answer

1.upto(99) { |i| puts i if i.odd? }