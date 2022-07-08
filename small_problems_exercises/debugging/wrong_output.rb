require 'pry-byebug'

## Original Code:

arr = ["9", "8", "7", "10", "11"]
p arr.sort do |x, y| # here's the problem. the do...end is lower in the order of operations
    y.to_i <=> x.to_i # than #p. in other words, `arr.sort` is bound to #p as its argument,
  end # more tightly than the block is bound to #sort. so the sorted array of strings
# ends up being printed, and then the do...end block doesn't run at all because there's
# no method yielding to the block

# Expected output: ["11", "10", "9", "8", "7"]
# Actual output: ["10", "11", "7", "8", "9"] # it sorts based 

## Debugged Code (challenge is to fix it without removing any code):

arr = ["9", "8", "7", "10", "11"]
p ( # simply add parentheses around the code you wish to ultimately print the return value of!
  arr.sort do |x, y|
    binding.pry
    y.to_i <=> x.to_i
  end
) # another solution would be to use `{}` instead, but that would require removing the `do...end`
# Expected output: ["11", "10", "9", "8", "7"] 
# Actual output: ["11", "10", "9", "8", "7"]
