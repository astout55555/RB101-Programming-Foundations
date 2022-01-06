NUMBERS = [1, 2, 3]
arr = ['hello', 'guy']

def test
  puts NUMBERS.inspect #  you can access the constant from outside the method, even though it's a separate scope
  puts arr.inspect # cannot access a local variable from the outer scope within a method definition, raises error
end

test