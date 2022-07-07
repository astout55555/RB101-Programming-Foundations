# Original Code: SystemStackError triggered when calling #move

# def move(n, from_array, to_array)
#   to_array << from_array.shift
#   move(n - 1, from_array, to_array) # recursion doesn't end. calls #move forever
# end

# # Example

# todo = ['study', 'walk the dog', 'coffee with Tom']
# done = ['apply sunscreen', 'go to the beach']

# move(2, todo, done) # raises the error, too many items on stack before calculation can commence

# p todo # should be: ['coffee with Tom']
# p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']

# Debugged Code: 

def move(n, from_array, to_array)
  return if n <= 0 # added a condition which ends the recursion after n method calls
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']

## Further Exploration: What happens if the length of the from_array is smaller than n?
# Answer: it starts pushing nil values into the to_array for each extra call
# could add a counter and another return condition which triggers once the counter reaches
# the size of the from_array. although honestly this situation doesn't really call for
# recursion. better would be to simply use:
# `(done << todo.shift(2)).flatten!` rather than this clunky #move method
