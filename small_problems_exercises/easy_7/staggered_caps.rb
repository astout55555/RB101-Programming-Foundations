### Part 1

=begin

# Problem:
input: string of one or more words, may contain special characters
output: new string with every other char uppercased, the rest lowercased
Rules:
-special characters are unchanged, but count as characters when alternating

# Algorithm:

break string into chars
iterate through chars with index
  next if char is not a letter
  if index is even, upcase!
  if index is odd, downcase!
rejoin string for output

=end

def staggered_case(string)
  characters = string.chars
  characters.each_with_index do |char, idx|
    next unless char.match(/[a-zA-Z]/)
    if idx.even?
      char.upcase!
    else
      char.downcase!
    end
  end
  characters.join
end

staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
staggered_case('ALL_CAPS') == 'AlL_CaPs'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

## Further Exploration: same as before except caller can request we start with downcase instead of upcase

def staggered_case(string, start_with_upper=true) # using positional arg with default value
  result = ''
  need_upper = start_with_upper
  string.chars.each do |char|
    if need_upper
      result += char.upcase
    else
      result += char.downcase
    end
    need_upper = !need_upper
  end
  result
end

staggered_case('I Love Launch School!', true) == 'I LoVe lAuNcH ScHoOl!' # can specify start with uppercase
staggered_case('ALL_CAPS', false) == 'aLl_cApS' # can start with lowercase too
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS' # defaults to uppercase first


### Part 2

=begin

# Problem: modify prior method to ignore non-alphabetic characters in pattern
Rules:
-still include special chars in return value
-skip them when alternating casing though

# algorithm: 

break string into chars
iterate through chars with counter (not index)
  next unless character is a letter
  upcase if counter is even
  downcase if counter is odd
  increment counter (skipped for non-letters)
rejoin string for output

=end

def staggered_case(string)
  characters = string.chars
  counter = 0
  characters.each do |char|
    next unless char.match(/[a-zA-Z]/)
    if counter.even?
      char.upcase!
    else
      char.downcase!
    end
    counter += 1
  end
  characters.join
end

staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
staggered_case('ALL CAPS') == 'AlL cApS'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'

## Further Exploration: 

=begin

# Problem: allow caller to swap whether or not special chars are skipped in counting
input: string, keyword argument (not positional argument)
output: string with alternating upper/lowercase, skipping or not skipping special characters based on argument provided

# Algorithm:

break string into chars
initialize counter at 0
iterate through chars with either index or counter depending on args:
  upcase if counter is even
  downcase if counter is odd
  increment counter (skipped for special chars if skip arg is true)
rejoin string for output

=end

def staggered_case(string: '', skip_special_chars: true)
  characters = string.chars
  counter = 0
  characters.each do |char|
    if counter.even?
      char.upcase!
    else
      char.downcase!
    end
    counter += 1 unless ( skip_special_chars && char.match(/[^a-zA-Z]/) ) # doesn't increment if a special character is found and supposed to be skipped
  end
  characters.join
end

staggered_case(string: 'ignore 77 the 444 numbers', skip_special_chars: true) == 'IgNoRe 77 ThE 444 nUmBeRs' # works normally
staggered_case(string: 'ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs' # works without specifying 2nd arg
staggered_case == '' # if string is not specified, returns empty string
staggered_case(string: 'ignore 77 the 444 numbers', skip_special_chars: false) == 'IgNoRe 77 ThE 444 NuMbErS' # changes to previous function if we specify false
staggered_case(skip_special_chars: false, string: 'ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS' # works even if we swap arg positions
