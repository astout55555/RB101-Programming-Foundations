def stringy(pos_integer)
  string = ''
  
  count = 0
  loop do # this works, but it's a bit clunky
    string << '1'
    count += 1
    break if count == pos_integer
    string << '0'
    count += 1
    break if count == pos_integer
  end

  string
end

# tests all print true
puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

def stringy_alt(pos_integer)
  string = ''

  until string.length >= pos_integer
    string << '1'
    break if string.length == pos_integer
    string << '0'
  end

  string
end

puts stringy_alt(6) == '101010'
puts stringy_alt(9) == '101010101'
puts stringy_alt(4) == '1010'
puts stringy_alt(7) == '1010101'

# official solution is slightly more condensed, uses #times despite alternating numbers

def stringy_official(size)
  numbers = [] # works with an array instead of a string, which means we need to join it together at the end

  size.times do |index|
    number = index.even? ? 1 : 0 # uses tertiary to return 1 or 0 based on even or odd index
    numbers << number
  end

  numbers.join # can't cut this line because we need to return the end result anyway, string or array works fine
end

# Further Exploration

def stringy_modified(size, start_with_1_or_0 = 1) # default value but you can put in 0...although anything else != 1 will act like 0 here
  numbers = []
  start_with_1_or_0 == 1 ? (alt = 0) : (alt = 1) # sets what we're alternating with based on value of start_with

  size.times do |index|
    number = index.even? ? start_with_1_or_0 : alt # alternates based on values of variables to be responsive
    numbers << number
  end

  numbers.join
end

# tests below print `true`
puts stringy_modified(4) == '1010'
puts stringy_modified(4, 1) == '1010'
puts stringy_modified(4, 0) == '0101'
puts stringy_modified(7) == '1010101'
puts stringy_modified(7, 0) == '0101010'
