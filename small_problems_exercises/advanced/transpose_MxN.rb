=begin

Problem: modify previous #transpose method to handle any matrix 1x1 or bigger
  does not have to be a square

Old method:

def transpose(matrix)
  new_matrix = []

  0.upto(matrix.size - 1) do |idx|
    new_sub_array = matrix.map { |sub_array| sub_array[idx] }
    new_matrix << new_sub_array
  end

  new_matrix
end

current method will create n sub-arrays,
  where n is the number of sub-arrays in the original matrix.
  this leads to only creating 1 of the 4 sub-arrays it should in example 1,
  and creating 3 extra sub-arrays filled with nil values in example 2.
  in example 3, it creates the first 3 sub-arrays correctly, but then stops.

Algorithm:

instead, the method needs to be altered to essentially do what it's doing except
  it needs to run as many times as are equal to the size of the first sub-array
  i.e. it needs to create as many rows as there are iniitally columns (not assuming a square),
  whereas right now it is creating as many rows as there are initially rows (assuming a square)

so all I need to do is change the argument for 0.upto(arg) to refer to
  `matrix[0].size - 1` instead of `matrix.size - 1`

I'll relabel things a little to make it easier to read, i.e. 'rows' and 'columns'

=end

def transpose(matrix)
  new_matrix = []

  columns = matrix[0].size - 1

  0.upto(columns) do |column|
    new_row = matrix.map { |row| row[column] }
    new_matrix << new_row
  end

  new_matrix
end

# Examples/Tests:

p transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) == [[1]]

## LS Solution: accesses elements with explicit combination of row/column when mapping

def transpose(matrix)
  result = []
  number_of_rows = matrix.size
  number_of_columns = matrix.first.size
  (0...number_of_columns).each do |column_index|
    new_row = (0...number_of_rows).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end
