### Q1: "Predict how the values and object IDs will change throughout the flow of the code below:"

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42] # the first three objects are easy. they are all different objects, and in fact different types of objects. they all start different from each other.
  d_outer = c_outer[0] # this is also a different object. although there is only one element in the array `c_outer`, that element (referred to by `d_outer`) has a different object ID than the array itself.
  # however, d_outer points to the same object as a_outer, the number 42 (an immutable object). they both have the same object ID, even though they differ from the others.

  a_outer_id = a_outer.object_id # in this chunk, we are assigning the values of the object IDs themselves to new variables. thus, the new variables have different object IDs than the objects we called #object_id on!
  b_outer_id = b_outer.object_id # i.e. `b_outer_id.object_id != b_outer.object_id` would evaluate to true. they are two separate objects with the same value stored in their separate places in physical memory. 
  c_outer_id = c_outer.object_id # so even though they are different objects, the variable `c_outer_id` has the correct value for our purposes, and we can call it in order to get the value of `c_outer.object_id`
  d_outer_id = d_outer.object_id 

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts # after assigning the object IDs to variables, we print the values interpolated in the above messages to the screen. the final #puts call without an argument to put a space (a blank line) after this output.

  1.times do # we now enter an inner scope created by the method #times, between do...end
    a_outer_inner_id = a_outer.object_id # here we point new variables (`a_outer_inner_id`, etc.) to the same objects to which the previous set (`a_outer_id`, etc.) were pointing (with the values of `a_outer.object_id` etc.)
    b_outer_inner_id = b_outer.object_id # there is no mutation yet. no values have been changes, only variables created.
    c_outer_inner_id = c_outer.object_id # also, the inner scope has access to the variables from the outer scope, so there's no problem.
    d_outer_inner_id = d_outer.object_id # as before, a_outer and d_outer have the same object ID, so these two (`a_outer_inner_id` and `d_outer_inner_id`) have the same values as each other

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts # in this chunk, the first set of variables has the same value as the second set of variables, since they both have the value of `a_outer.object_id` (and so on). being in the block doesn't change it.

    a_outer = 22 # because this is just an inner scope (not a separate method definition scope), the inner scope has access to the outer scope and can reassign the original variables to new objects, which we do here.
    b_outer = "thirty three" 
    c_outer = [44] # we reassign each original variable to a new object (with a new value), so they will all have different object IDs
    d_outer = c_outer[0] # this is true even for `d_outer` because it is now pointing to the only element within a new array, and is therefore also a different object. this time it is also different from a_outer.

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts # here this will show the new values of each reassigned variable, followed by the original object ID (stored in the variable set `a_outer_id` etc), which is different from the new object IDs found here using #object_id calls.
    # at this point, all 4 variables have different IDs from each other, rather than `a` and `d` variants being matched like they were originally.

    a_inner = a_outer # here we initialize a new set of variables within the block, pointing to the same objects as the first set of variables (`a_outer` etc.) after the reassignment.
    b_inner = b_outer # they therefore have the same values and object IDs that the other variable set currently has (after reassignment).
    c_inner = c_outer 
    d_inner = c_inner[0] # this looks tricky because the right side of the assignment is `c_inner[0]` instead of `c_outer[0]`. however, because `c_inner` was just pointed to the same object as `c_outer`, it doesn't matter.

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id # here a new set of variables is created to store the object_ids of the `inner` variables.

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts # here we print to the screen messages showing that the inner and outer variables have the same IDs, since the inner versions have been pointed to the same objects as the outer versions.
  end # this is the end of the #times do...end block.

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
  puts # here we print the new values of the outer variables, alongside their stored original IDs, and their new (and different) IDs after the block has reassigned them to new objects.

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end # this last chunk of code attempts to access the inner variables but cannot, and so we have code which executes instead after the `rescue` keyword.
# that said, the inner variables were initialized to point to the changed outer variables, but nothing changed the inner variables after that. they should be the same as they started.

fun_with_ids # the method call, where all the above actually happens

### Q2

