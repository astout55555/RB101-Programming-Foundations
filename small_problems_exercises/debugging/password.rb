## Original Code: raises an error and doesn't work as expected

# password = nil

# def set_password
#   puts 'What would you like your password to be?'
#   new_password = gets.chomp
#   password = new_password
# end

# def verify_password
#   puts '** Login **'
#   print 'Password: '
#   input = gets.chomp

#   if input == password # `password` is undefined within this method's scope
#     puts 'Welcome to the inside!'
#   else
#     puts 'Authentication failed.'
#   end
# end

# if !password
#   set_password
# end

# verify_password

## Debugged Code: error fixed and code made functional

password = [nil] # using an array so I can mutate it instead of reassigning the pointer in the methods

def set_password(password) # added the `password` parameter so that it can be manipulated
  puts 'What would you like your password to be?'
  new_password = gets.chomp
  password[0] = new_password # mutates `password` by reassigning its element to a new value
end

def verify_password(password) # added the `password` parameter again to bring it into scope
  puts '** Login **'
  print 'Password: '
  input = gets.chomp

  if input == password[0] # changed this to refer to its element
    puts 'Welcome to the inside!'
  else
    puts 'Authentication failed.'
  end
end

if !password[0] # changed this to refer to its element
  set_password(password) # added the argument
end

verify_password(password) # added the argument

## LS Solution:

password = nil

def set_password
  puts 'What would you like your password to be?'
  new_password = gets.chomp
  new_password # instead of attempting to reassign `password`, it simply returns the `new_password` value
end

def verify_password(password) # LS still has to add `password` as the parameter to this method
  puts '** Login **'
  print 'Enter your password: '
  input = gets.chomp

  if input == password # this no longer raises an error because `password` is defined
    puts 'Welcome to the inside!'
  else
    puts 'Authentication failed.'
  end
end

if !password
  password = set_password # this was a different and perhaps cleaner solution.
end # the line above simply assigns `password` to the return value of #set_password,
# rather than using #set_password to mutate `password` directly.
verify_password(password) # argument still must be passed in for the method to function
