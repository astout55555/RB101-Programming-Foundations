=begin

Problem: write a method that sorts an array using the bubble sort algorithm

input: array with at least 2 elements (integers or strings, not mixed)
output: sorted array (lowest to highest / alphabetical order)

Data/Algorithm:

in a loop
  initialize/reassign `swapped` to false
  iterate through from starting pair to the last necessary index (length - pass)
    compare current value with index + 1
      swap if current value is greater
        also reassign `swapped` to true
      otherwise, increment index
  increment pass
  break if swapped == false
return sorted array

=end

def bubble_sort!(array)
  pass = 1
  loop do
    swapped = false
    array.each_with_index do |val, idx|
      break if idx == array.size - pass
      if val > array[idx + 1]
        array[idx], array [idx + 1] = array[idx + 1], array[idx]
        swapped = true
      end
    end

    break unless swapped
    pass += 1
  end

  nil # should not return a meaningful value, this is a destructive method
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
