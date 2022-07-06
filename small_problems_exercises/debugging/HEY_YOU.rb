# Original Code: why does this print 'HEY you' instead of 'HEY YOU'?

def shout_out_to(name)
  name.chars.each { |c| c.upcase! }
# #upcase! is destructive, but it's being called on elements in an array made from the string, not the string itself
  puts 'HEY ' + name # original name is unaltered
end

shout_out_to('you') # expected: 'HEY YOU'

# Debugged code:

def shout_out_to(name)
  name = name.chars.each { |c| c.upcase! }.join # reassigned the name to the newly rejoined string

  puts 'HEY ' + name
end

shout_out_to('you')

# LS Solution:

def shout_out_to(name)
  name.upcase! # took the option to simply #upcase! the name directly

  puts 'HEY ' + name
end

shout_out_to('you')
