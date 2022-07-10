=begin

Problem: write a method which takes any matrix and rotates it 90 degrees clockwise

Old method to transpose MxN matrices:

def transpose(matrix)
  new_matrix = []

  columns = matrix[0].size - 1

  0.upto(columns) do |column|
    new_row = matrix.map { |row| row[column] }
    new_matrix << new_row
  end

  new_matrix
end

Old LS solution to transpose MxN matrices:

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

input: MxN matrix (an Array of Arrays)
output: an Array of Arrays, with
  number of rows equal to old number of columns
  number of columns equal to old number of rows
  each new_row == old_column.reversed

Algorithm:

simply reuse the old method, except reverse the outputted row before adding it to the new matrix

=end

def rotate90(matrix)
  result = []
  number_of_rows = matrix.size
  number_of_columns = matrix.first.size
  (0...number_of_columns).each do |column_index|
    new_row = (0...number_of_rows).map { |row_index| matrix[row_index][column_index] }.reverse
    result << new_row
  end
  result
end

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2

## Further Exploration: modify method to rotate 90, 180, 270, or 360 based on an arg

def rotate(matrix, degrees=90)
  last_matrix = matrix
  
  (degrees/90).times do
    result = []
    number_of_rows = last_matrix.size
    number_of_columns = last_matrix.first.size
    (0...number_of_columns).each do |column_index|
      new_row = (0...number_of_rows).map { |row_index| last_matrix[row_index][column_index] }.reverse
      result << new_row
    end
    last_matrix = result
  end

  last_matrix
end

new_matrix1 = rotate(matrix1, 90)
new_matrix2 = rotate(matrix2)
new_matrix3 = rotate(matrix2, 360)

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2
