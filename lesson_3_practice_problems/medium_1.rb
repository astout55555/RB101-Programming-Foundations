### Q1

10.times { |i| puts 'The Flinstones Rock!'.rjust(i+20) }
# could also use `10.times { |i| puts (' ' * i) + 'The Flinstones Rock!' }`

### Q2

# puts "the value of 40 + 2 is " + (40 + 2) # produces an error

# First way to fix it:
puts "the value of 40 + 2 is " + "#{(40 + 2)}"

# Second way to fix it, variation of #1:
puts "the value of 40 + 2 is #{(40 + 2)}"

# For good measure, third, different way to fix it:
puts "the value of 40 + 2 is " + (40 + 2).to_s

### Q3

# Make the following code handle 0 and negative numbers--
# with error message instead of actually raising an error or getting stuck in loop
# don't use begin/end/until

def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  
  if number <= 0
    puts 'Invalid number. Please provide a positive integer instead.'
  else
    factors
  end
end

# Bonus 1: the `number % divisor == 0` is to ensure that the divisor is a factor
# if there were any remainder, then it wouldn't == 0

# Bonus 2: The purpose of calling `factors` at the end of the method is to make
# sure that the return value is the factors array

### Q4: Considering the following code...

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# The difference between using `+` and `<<` for adding elements to an array is
# the `+` is used with reassignment, `buffer = input_array + [new_element]`
# therefore, the buffer is being reassigned to a new place in physical memory
# every time a new element is added. so if the buffer is mutated in some other
# way before #rolling_buffer2 is called, this mutation will not be included
# unless `input_array` is also changed to match the current value of buffer.
# and, because local variable `buffer` within the method definition scope
# is isolated from the original variable `buffer`, we will be left with a
# return value for the modified buffer after calling #rolling_buffer2
# which will be different from the value of local variable `buffer` from
# outside the method definition scope. this could cause confusion if we are
# working with the variable in any way outside of this method.

# for this reason, using `<<` is preferred, because you are mutating the value of
# the object which both the local method variable `buffer` and the local variable
# `buffer` outside the method definition point to. keeping these pointing to the
# same object will decrease the risk of bugs. that is, unless there is some
# reason why we need to preserve the original value of buffer in a variable,
# but even then we could just save it in a variable called `original_buffer`
# or something like that, and it would be more clear than the 2nd method above.

### Q5

# the original code doesn't work because method definitions are self-contained
# we have to initialize `limit` within the method definition, or pass it in
# as an argument

def fib(first_num, second_num, limit) # added a limit parameter
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15) # added the third arg here
puts "result is #{result}"

### Q6: what is the output of the following code?

answer = 42

def mess_with_it(some_number)
  some_number += 8 # reassigns the method variable, does not mutate object
end

new_answer = mess_with_it(answer) # new_answer == 50, but answer == 42 still

p answer - 8

# `-` should be higher precedence than the code block attached to #p,
# which means that `answer` and `8` are bound more tightly as operands to it
#than #p and `answer` are to each other. i.e. `answer - 8` will be resolved
# first. then the value it returns (34) is printed as the output.
# it should also be noted that #p returns the object, unlike #puts which returns nil.

### Q7: did anything happen to the original hash after the following code is run?

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

# Surprisingly, yes! Remember, `[]=` is actually a method
# you can call on a hash (or an array) to update its values.
# This is NOT the same as using reassignment! #[] is similar to #fetch,
# while #[]= is an alias for #store. Neither are simply assignment.
# But it's not that simple either!
# The #[]= method is mutating with respect to the hash (or array),
# i.e. it changes a value within the hash without reassigning the hash itself,
# so this is capable of changing the hash permanently even outside the scope
# of the method definition.
# On the other hand, it is non-mutating with respect to the key whose value
# is changed. You can tell by calling the #object_id method on the hash and
# the key before and after calling the #[]= method on the key (changing the
# value associated with the key), but you can also tell because in this case
# we are also changing an immutable value--a number--associated with the
# key 'age'. Because numbers are immutable, what we must be doing is
# reassigning the 'key' to a new place in memory with a new object,
# a different number. But because we did this while mutating the original
# hash (or array), that change stays, despite involving reassignment.


#Reassignment wouldn't affect
# the original object, or the value of the original reference when used in
# a method, but the #[]= method does mutate the object!

p munsters # proof here

### Q8

def rps(fist1, fist2) # returns the winning play
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

# What is the result of the following call?
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
# This will print 'paper' to the screen.

### Q9

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

# considering the above two methods, what will be the return value of the following:
bar(foo)
# it will return 'no' because #foo always returns 'yes', which gets passed to
# #bar as the arg, overriding the default param value of 'no'. since `param` == 'yes',
# that means the expression to the left of the `?` evaluates to false, causing the
# ternary operator to return the right-hand result, 'no'.
