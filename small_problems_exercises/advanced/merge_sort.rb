=begin

Problem:

input: a single array with either integers or strings, but not a mix
  it can have an even or an odd number of elements
output: ultimately, a single sorted array

in detail...
  input: single unsorted array
    nested array of arrays, with half of elements in each sub-array
      more deeply nested array of arrays of arrays, with half of each sub-array in each sub-sub-array
        and so on until every element is in its own sub-...sub-array
      then, these are merge-sorted back into the next level sub-array, except now sorted
    and so on, until every sub-array has been merge-sorted with every other sub-array of the same level
  output: finally, the last sub-arrays are merge-sorted, and there is only one fully sorted array

Rules:
  I am allowed to use the merge method from the previous exercise
  this exercise will require recursion at some point

Algorithm:

because I can use the merge method from the previous exercise,
the challenge is the breaking down and then building back up recursively

pseudocode from the hint:

procedure mergesort( var a as array )
   if ( n == 1 ) return a

   var l1 as array = a[0] ... a[n/2]
   var l2 as array = a[n/2+1] ... a[n]

   l1 = mergesort( l1 )
   l2 = mergesort( l2 )

   return merge( l1, l2 )
end procedure

I should just be able to translate this to ruby below

=end

def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

def merge_sort(array)
  return array if array.size == 1
  
  first_half = array[0..((array.size / 2) - 1)] # had to alter this part a bit to
  second_half = array[(array.size / 2)..-1] # make sure I actually divided in half

  first_half = merge_sort(first_half)
  second_half = merge_sort(second_half)

  return merge(first_half, second_half)
end

p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

## LS Solution:

def merge_sort(array)
  return array if array.size == 1

  sub_array_1 = array[0...array.size / 2] # I didn't know you could notate the range like this
  sub_array_2 = array[array.size / 2...array.size]

  sub_array_1 = merge_sort(sub_array_1)
  sub_array_2 = merge_sort(sub_array_2)

  merge(sub_array_1, sub_array_2)
end

## Further Exploration: write a non-recursive merge_sort method

=begin

Algorithm:

split the array into two halves
push both halves into an empty main array

in a loop
  counter = 0
  iterate through the sub-arrays in the main array with index val
    next if sub-array size is 1
    otherwise, split into two halves
    put these halves into a containing array
    reinsert this containing array into the same place in the main array (reassingment using index val)
    iterate through this container of sub-arrays with index val
      next if sub-array size is 1
      otherwise, split into two halves
      put these halves into a containing array
      reinsert this containing array into the same place in the iterating array
      iterate through this container of sub-arrays with index val
        next if sub-array size is 1
        otherwise, split into two halves
        put these halves into a containing array
        reinsert this containing array into the same place in the iterating array
      ...
    counter += 1
  break if counter is still 0 (indicates all sub-arrays were skipped)
...

^^^I ended up just writing out a recursive process, which doesn't solve the problem.

I found an elegant solution from a student, which doesn't quite replicate the behavior
of the recursive merge_sort, in that it doesn't actually break down the array into quite
as deeply nested arrays first. Instead, it accomplishes the same result by breaking
all elements into individual sub-arrays first, and then combining sets of 2 with #merge and
placing them in a temporary array for further combination.

def merge_sort(array)
  return array if array.size == 1
  result = array.each_slice(1).to_a # breaks main array into single-element arrays

  loop do
    temp = []
    idx = 0
    while idx < result.size - 1 # updates based on modified result each loop
      temp << merge(result[idx], result[idx + 1]) # targets adjacent elements to merge
      idx += 2 # skips to the next potential set of 2
      temp << result[idx] if idx == result.size - 1 # handles the final item
    end
    result = temp # updates the result
    return result[0] if result[0].size == array.size 
  end # breaks out of the loop once all sub-arrays have been merged
end

=end
