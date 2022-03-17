=begin

# Problem: creating #include? from scratch

input: array, search value
return: true if value found in array, else false

# Algorithm:

iterate through array
  check each value if it is equal to search value
  if so, return true, else return false

=end

def include?(array, search_value)
  match = false
  array.each do |element|
    match = true if element == search_value
  end
  match
end

p include?([1,2,3,4,5], 3) == true
p include?([1,2,3,4,5], 6) == false
p include?([], 3) == false
p include?([nil], nil) == true
p include?([], nil) == false

# Two official solutions, slightly more condensed:

def include?(array, value)
  !!array.find_index(value) # `!!` turns the truthy (integer) or falsy (nil) value into true or false
end

def include?(array, value)
  array.each { |element| return true if value == element } # return interrupts the method execution
  false
end
