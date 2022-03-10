## Practice Problem 1

[1, 2, 3].select do |num|
  num > 5
  'hi' # 'hi' is always a truthy value
end

# => [1, 2, 3]
#select only cares if the value of the last line is truthy

## Practice Problem 2

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

# => 2
#count is similar to #select, except it returns an integer total
# of all the elements for which the block returns a truthy value,
# rather than those elements themselves.
# you can read more under Enumerable#count, as the Enumerable module contains
# the #count method, which is shared with (at least) the array and hash classes.
# because of this, you can also find it under Array#count.

## Practice Problem 3

[1, 2, 3].reject do |num|
  puts num
end

# => [1, 2, 3]
# #reject returns a new array with only those elements for which the block
# had a falsey value. i.e. it "rejects" the ones for which the block
# returns a truthy value, leaving only the other elements (in a new array).
# #puts always returns nil, so no elements are "rejected", and the new
# array contains the same elements as the old one.

## Practice Problem 4

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

# => { 'a' => 'ant', 'b' => 'bear', 'c' => 'cat' }
# #each_with_object returns the object as modified. in this case we are
# taking the first letter (index 0) of each element (value) and using it
# to create a hash pairing of it as the key and the full element as the
# value.

## Practice Problem 5

hash = { a: 'ant', b: 'bear' }
hash.shift

# => [a:, 'ant']
# the order shown should reflect the order of entry, which is what matters.
# #shift removes the first entered pairing (mutates the hash)
# and then returns that pairing as the return value.

## Practice Problem 6

['ant', 'bear', 'caterpillar'].pop.size

# => 11
# #pop destructively removes and returns the last element, 'caterpillar',
# and then the chained #size method returns the length of the string
# as an integer.

## Practice Problem 7

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# return value of #any? `=> true` (a single boolean value)
# #any? returns true because at least one of the elements fed to the
# block as an argument returned a truthy value.
# return value of the block `=> true`
# the block would normally have a return value for each element being checked,
# but #any? stops iterating after it evaluates a single truthy value
# and returns the boolean.
# this means that `puts num` only triggers for the first number in the array!

## Practice Problem 8

arr = [1, 2, 3, 4, 5]
arr.take(2)

# => [1, 2]
# #take(n) returns the first n elements in an array (n must be a non-negative integer)
# it is not destructive

## Practice Problem 9

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# => [nil, 'bear']
# #map returns an array of objects returned by the block
# if...end returns nil if the condition is not met and no `else` is
# specified. #map will always return an array equal in size to the
# original collection it is called on.

## Practice Problem 10

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# => [1, nil, nil]
# first element doesn't pass the if condition, so the else code runs and
# returns the element 1. after that, the two remaining elements pass the
# if condition, and so `puts num` is evaluated and returns nil.
