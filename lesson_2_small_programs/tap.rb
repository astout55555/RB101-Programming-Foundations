array = [1, 2, 3]

mapped_array = array.map { |num| num + 1 } # mapped_array assigned value of [2, 3, 4]

mapped_array.tap { |value| p value } # prints [2, 3, 4]

mapped_and_tapped = mapped_array.tap { |value| p 'hello' }

# the above prints ‘hello’ because it executes the block after passing mapped_array to it
# however, it returns the value of mapped_array, it does not transform the value at all
# therefore, the value of the variable you've assigned this to is simply the value of mapped_array

mapped_and_tapped == [2, 3, 4] # returns true

# using the #tap method is one way to see the resulting value at each step within a method chain
# think of it like putting `binding.pry` in between every step. it looks like this:

(1..10)                 .tap { |x| p x }   # 1..10
 .to_a                  .tap { |x| p x }   # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
 .select {|x| x.even? } .tap { |x| p x }   # [2, 4, 6, 8, 10]
 .map {|x| x*x }        .tap { |x| p x }   # [4, 16, 36, 64, 100]
# also check out this beautifully organized layout!
# good to know you can ignore newlines when chaining methods, otherwise this would be massive and hard to read
# remember to indent underneath the starting line if doing this
# of course after this is no longer needed it can be condensed again