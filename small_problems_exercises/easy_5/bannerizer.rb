=begin

input: string
output: string with a box around it, responsive to length of string, made of '-', '|', and '+' symbols
  box is 5 lines, each needs to be responsive to length because it needs to end based on when the string ends
  lines 1 and 5 are the same
  lines 2 and 4 are the same
  line 3 is like line 2 or 4 but with the string in the center
  also needs to print an empty box when passed an empty string

start by finding length of string, save value
print box modified by this value for lines 1, 2, 4, 5
  lines 1, 5: use concatenation, multiply '-' by string length and insert into middle of default box
  lines 2, 4: use concatentation, multiply ' ' by string length, insert in middle of default box
print line 3 using concatenation, simply insert string into middle of default box line 3

=end

def print_in_box(string)
  length = string.length
  outer = '+-' + ('-' * length) + '-+'
  inner = '| ' + (' ' * length) + ' |'
  center = '| ' + string + ' |'
  puts outer
  puts inner
  puts center
  puts inner
  puts outer
end

# Official Solution:

def print_in_box(message)
  horizontal_rule = "+#{'-' * (message.size + 2)}+"
  empty_line = "|#{' ' * (message.size + 2)}|"

  puts horizontal_rule
  puts empty_line
  puts "| #{message} |" # it is a bit cleaner not to have a separate line above for the center, since we only use it once
  puts empty_line
  puts horizontal_rule
end

## Further Exploration:

# A Challenge: Truncate the message if it would go longer than 80 columns, length of standard terminal window

=begin

use while loop to handle if length is longer than 76 (message plus box edges)
  if longer than 76, chop off last character until short enough
  continue as normal from there

=end

def print_in_box(message)
  while message.size > 76
    message.chop!
  end

  horizontal_rule = "+#{'-' * (message.size + 2)}+"
  empty_line = "|#{' ' * (message.size + 2)}|"

  puts horizontal_rule
  puts empty_line
  puts "| #{message} |"
  puts empty_line
  puts horizontal_rule
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')
print_in_box("Once upon a time there was a very long-winded sailor. He said: 'When I was younger, I took life by the horns and boy howdy it was great! Let me tell you the whole story, start to finish. Here goes...'")

# A Big Challenge: Wrap long messages so they appear on multiple lines within the box still.

=begin

use conditional to base spacing on the original message length (plus 2) or the 78 maximum (maximum message length plus 2)
  also find specific length for extra spacing on the final line, if the message has to be split up, using % 76
  final spacing can be set to 0 if message is not longer than 76, so code doesn't have to be conditional later

use loop to handle lines longer than 76 characters
  if longer, use #slice! to remove first 76 characters
    save as first line, insert into array
    loop through again if rest of line is still longer than 76 chars, saving as 2nd line, etc.
    return array of string chopped into manageable parts
  when printing the message, iterate through array to print a line for each chunk

=end

require 'pry'

def print_in_box(message)
  # this is where I find the spacing values that I'll need later, depending on the length of the string
  if message.length > 76
    spacer = 78
    final_margin_size = 78 - (message.length % 76)
    left_margin = ' ' * (final_margin_size / 2)
    if final_margin_size.odd?
      right_margin = left_margin + ' '
    else
      right_margin = left_margin
    end
  else
    spacer = message.length + 2
    left_margin, right_margin = ' ', ' '
  end
  
  # this is where I put the loop to split up the message into chunks if needed
  message_chunks = []
  while message.length > 76
    message_chunks << message.slice!(0..75)
  end
  message_chunks << message # put the last bit in, or put the original message in if it wasn't too long to start with

  horizontal_rule = "+#{'-' * spacer}+"
  empty_line = "|#{' ' * spacer}|"

  puts horizontal_rule
  puts empty_line
  
  # this is where I print one or more lines based on the length of the original message
  while message_chunks.size > 1
    puts "| #{message_chunks.shift} |"
  end
  puts "|#{left_margin}#{message_chunks.shift}#{right_margin}|"

  puts empty_line
  puts horizontal_rule
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')
print_in_box("Once upon a time there was a very long-winded sailor. He said: 'When I was younger, I took life by the horns and boy howdy it was great! Let me tell you the whole story, start to finish. Here goes...okay, so I was tinkering in my workshop, and an owl came to say hello to me so I grabbed that great-horned owl by the horns and gave it a big ol' kiss! How's that for carpe diem!'")

# it works! I feel like I could refactor the code, the way I find the spacing is ugly looking but it works!
# and maybe I could make it even more complex so that the message wraps smartly, keeping words together instead of cutting them into two when wrapping to the next line...
