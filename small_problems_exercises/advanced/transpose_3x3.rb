=begin

Problem:

3 x 3 matrix:

1  5  8
4  7  2
3  9  6

can be described by nested Arrays:

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

A transposed matrix is one where we've exchanged rows and columns, like so:

1  4  3
5  7  9
8  2  6

Challenge: write a method that takes a 3 x 3 matrix and returns the transposed version
Rules:
  do not use Array#transpose
  do not use the Matrix class
  do not modify the original matrix

input: a 3 x 3 Array of Arrays, only 2 dimensions (no 3rd level Arrays)
output: a new 3 x 3 Array of Arrays, with the arrangement of rows/columns transposed

Algorithm:

create empty new_matrix Array
from 0 upto 2
  iterate through the sub-Arrays, mapping each i element onto a new sub-Array
  push the new sub-Array into the new_matrix Array

return the new_matrix

=end

def transpose(matrix)
  new_matrix = []

  0.upto(matrix.size - 1) do |idx|
    new_sub_array = matrix.map { |sub_array| sub_array[idx] }
    new_matrix << new_sub_array
  end

  new_matrix
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

## Further Exploration:

=begin

Problem: create a #transpose! method that doesn't reuse the above method

for this destructive method, I need to consider that #map! will mutate the matrix
in steps, meaning that I will lose the data I need to continue constructing the new
matrix as #map! is executed. in order to prevent this, I need to create a copy of
the original matrix to refer to as I execute #map!

Algorithm:

copy the matrix to a method var

call #map! on the original matrix (I need the end result of the block to be each new row)
  within the block, create empty new_row array
  use 0 to 2 count and map on matrix copy to construct new row, add to empty array
  at the end of the #map! block of code, return the new row, which overwrites the old

=end

##...I wasn't able to figure it out, seems like trying to use similar methods as before
# was a dead end. what I needed to do instead was use multiple counters and nested loops.
# this student solution below is something similar to what I briefly considered before
# getting stuck in the #map! rut:

def transpose!(matrix)
  x, y = 0, 0
  counter = 0
  loop do
    break if x >= matrix[0].size
    loop do
      break if y >= matrix.size
      matrix[x][y], matrix[y][x] = matrix[y][x], matrix[x][y] if x != y
      y += 1
    end
    counter += 1
    x, y = counter, counter
  end
end

transpose!(matrix)

p matrix
