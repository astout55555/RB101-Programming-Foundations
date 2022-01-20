array_of_num = (1..99).to_a

even_nums = array_of_num.select { |num| num.even? }

puts even_nums
