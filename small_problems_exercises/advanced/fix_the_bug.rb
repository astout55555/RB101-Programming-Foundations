def my_method(array)
  if array.empty?
    []
  elsif array.size > 1 # the condition was missing, causing the ruby parser to evaluate the
    array.map do |value| # array.map expression with its block as the conditional instead.
      value * value # array.map returns the new array, which is always truthy, so the elsif condition is always met
    end # from there, the ruby parser runs the code in this branch of the if/elsif/else statement. but no code is equivalent to nil, so it returns nil.
  else
    [7 * array.first]
  end
end

p my_method([]) == [] # was already correct, because it triggered the first condition
p my_method([3]) == [21] # was printing nil before, code never got to the else condition
p my_method([3, 4]) == [9, 16] # was printing nil before
p my_method([5, 6, 7]) == [25, 36, 49] # was printing nil
