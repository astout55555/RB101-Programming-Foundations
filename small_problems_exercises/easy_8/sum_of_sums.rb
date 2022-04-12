=begin

# Problem:
input: an array of 1 or more positive integers
output: a single integer (the sum of the series of sums)
hard to describe in words, examples below

Algorithm:
initialize result as 0
create empty sub_sum array
iterate through input array
  for each integer, add it to the empty sub_sum array
  add the sum of all sub_sum elements to the final result variable
return result

=end

def sum_of_sums(array)
  final_sum = 0
  nums_for_sub_sum = []

  array.each do |num|
    nums_for_sub_sum << num
    final_sum += nums_for_sub_sum.sum
  end

  final_sum
end

sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
sum_of_sums([4]) == 4
sum_of_sums([1, 2, 3, 4, 5]) == 35
