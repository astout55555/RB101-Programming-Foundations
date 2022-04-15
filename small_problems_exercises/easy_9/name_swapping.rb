=begin

Problem: Write a method that swaps order of a given name
input: string consisting of first name, space, last name
output: string consisting of last name, comma, space, first name

Algorithm:

break string into words
assign first and last name to variables
output interpolated string

=end

def swap_name(first_and_last)
  names = first_and_last.split
  first_name, last_name = names[0], names[1]

  "#{last_name}, #{first_name}"
end

swap_name('Joe Roberts') == 'Roberts, Joe'

# LS Solution: simpler, use #reverse and add an argument to #join

def swap_name(name)
  name.split(' ').reverse.join(', ')
end
