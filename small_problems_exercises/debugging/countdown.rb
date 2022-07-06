def decrease(counter)
  counter -= 1 # reassigns the variable in an isolated method scope
end

counter = 10

10.times do
  puts counter
  decrease(counter) # has no effect on the external `counter` var
end

puts 'LAUNCH!'

# corrected solution below:

counter = 10

10.times do
  puts counter
  counter -= 1
end

puts 'LAUNCH!'

# LS Solution:

def decrease(counter)
  counter - 1 # removed the reassignment here for clarity
end

counter = 10

10.times do
  puts counter
  counter = decrease(counter) # reassigns the external `counter` using the method's return value
end

puts 'LAUNCH!'

## Further Exploration: refactor the code to only specify 10 once

def decrease(counter)
  counter - 1
end
# removed the initializing of `counter`, since it is specified in the next line
10.downto(1) do |counter| # used #downto with `counter` as the parameter
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'
