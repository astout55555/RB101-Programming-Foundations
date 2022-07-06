=begin

Problem:

input: string
output: boolean
        -true if: all parentheses are balanced in '(' and ')' pairs
          -(also the pairs must start with the left '(' parenthesis)
        -otherwise false

Data/Algorithm:

create empty left and right parentheses arrays to store/check pairs

break string into chars, iterate through
  if '(' or ')' is found, push it into the left or right parentheses array
  confirm that the left array is equal to or bigger than the right array
    if not, return false (it means a right parenthesis came too early)

after iterating through the string, check that the left/right arrays are equal
  -return false if false, true if true, using a simple `==` comparison

=end

def balanced?(string)
  left_parentheses = []
  right_parentheses = []

  string.chars.each do |char|
    if char == '('
      left_parentheses << char
    elsif char == ')'
      right_parentheses << char
    end

    return false if right_parentheses.size > left_parentheses.size
  end

  left_parentheses.size == right_parentheses.size
end

balanced?('What (is) this?') == true
balanced?('What is) this?') == false
balanced?('What (is this?') == false
balanced?('((What) (is this))?') == true
balanced?('((What)) (is this))?') == false
balanced?('Hey!') == true
balanced?(')Hey!(') == false
balanced?('What ((is))) up(') == false

# LS Solution:

def balanced?(string)
  parens = 0
  string.each_char do |char|
    parens += 1 if char == '('
    parens -= 1 if char == ')'
    break if parens < 0 # breaks if there are ever more right than left
  end

  parens.zero? # only returns true if they are matched up
end

# Further Exploration:

# Expand the solution to cover square, curly, and quotation marks (single and double)

# Algorithm:

# add more categories, and use the same method as before to confirm balance
# initialize `parens = 0` etc.
# add more lines to the iteration actions for each type
# at the end, check that all categories are balanced
# for single/double quotes (which are the same on left/right), only count up for each
  # check that the total for each is even at the end

def balanced?(string)
  parens = 0
  sq_brackets = 0
  curly = 0
  single_q = 0
  double_q = 0

  string.each_char do |char|
    parens += 1 if char == '('
    parens -= 1 if char == ')'
    break if parens < 0

    sq_brackets += 1 if char == '['
    sq_brackets -= 1 if char == ']'
    break if sq_brackets < 0

    curly += 1 if char == '{'
    curly -= 1 if char == '}'
    break if curly < 0

    single_q += 1 if char == "'"
    double_q += 1 if char == '"'
  end

  parens.zero? && sq_brackets.zero? && curly.zero? && single_q.even? && double_q.even?
end

p balanced?("hello world()[]{}''\"\"") == true

# To refactor this code, I'd take every category and turn it into a helper method,
# then call `#balanced?` which would use every helper method to find the result
