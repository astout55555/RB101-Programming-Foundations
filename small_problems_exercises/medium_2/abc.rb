=begin

Problem: determine if a word can be spelled using a set of lettered blocks

input: string
output: boolean

-each block can only be used once
-cannot use both sides at once

The collection of blocks:

B:O   X:K   D:Q   C:P   N:A
G:T   R:E   F:S   J:W   H:U
V:I   L:Y   Z:M

-note that there are no repeat letters

Examples:

block_word?('BATCH') == true
block_word?('BUTCH') == false
block_word?('jest') == true # note, method needs to be case insensitive

Data/Algorithm:

store the blocks in a hash (two letters form key/value pairs)
make a copy of the hash to work with in the method without mutating the original

iterate through the upcased letters of the string that was provided as an argument
  for each letter, check if it is found in the keys
    if letter is found, remove the block from the hash
    if letter is not found, check if letter is found in the values
      if so, remove the block from the hash
      if not, exit method and return false
  if all letters are found, return true

=end

BLOCKS = {
  B:'O', X:'K', D:'Q', C:'P', N:'A',
  G:'T', R:'E', F:'S', J:'W', H:'U',
  V:'I', L:'Y', Z:'M'
}

def block_word?(string)
  blocks = BLOCKS.dup
  
  string.upcase.chars.each do |letter|
    if blocks.keys.include?(letter.to_sym)
      blocks.delete(letter.to_sym)
    elsif blocks.values.include?(letter)
      blocks.delete_if { |_, v| v == letter }
    else
      return false
    end
  end

  true
end

block_word?('BATCH') == true
block_word?('BUTCH') == false
block_word?('jest') == true 

# LS Solution:

BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze # uses a set of 2-letter strings

def block_word?(string)
  up_string = string.upcase
  BLOCKS.none? { |block| up_string.count(block) >= 2 } # checks that no set of letters can have its components found twice (or more) in the word
end # note: apparently passing #count a string will have it check for instances of each letter, not each instance of the full string
# also note: passing in an array, however, does not then count each instance of each element. instead, it will count each instance of the full array
