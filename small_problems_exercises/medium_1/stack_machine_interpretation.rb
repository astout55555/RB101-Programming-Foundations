=begin

Problem:

Write a method that implements a miniature stack-and-register-based programming language that has the following commands:

    n Place a value n in the "register". Do not modify the stack.
    PUSH Push the register value on to the stack. Leave the value in the register.
    ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
    SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
    MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
    DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
    MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
    POP Remove the topmost item from the stack and place in register
    PRINT Print the register value

All operations are integer operations.

The 'register' is initialized at 0.
The 'stack' is initialized as an empty array.

input: a single argument, a string, which contains one or more commands separated by spaces, to be processed in order
output: whenever the command 'PRINT' is processed, the output will be whatever is the current value of the register (as an integer). otherwise, there is no output

Algorithm:

(high level)
1. define a method `minilang` which
  -initializes the register and the stack
  -takes a single string argument and splits it into an array of its component commands
  -iterates through them to run the corresponding operations in order

(detail)

initialize the register as `[0]` so that the value it contains is 0, but it is easy to manipulate by reassigning its only element across various scopes

iterate through commands after splitting up the string
  first distinguish between numeric input and the various other string inputs with an if statement 
    in this case, reassign register[0] to n (converted to an integer), rather than pass it to a helper method
  run single line of code based on the command using a case statement (operations are all simple enough that no helper methods are actually required)

because we're working with immutable values (integers), I don't need to worry about the fact that the register and the stack will hold elements with identical object ids
  (also because we are not seeking to mutate any objects within either collection at any point anyway)

=end

def minilang(string_of_commands)
  register = [0]
  stack = []

  string_of_commands.split.each do |command|
    if command.to_i.to_s == command
      register[0] = command.to_i
    end

    case command
    when 'PUSH' then stack.push(register[0])
    when 'ADD' then register[0] += stack.pop
    when 'SUB' then register[0] -= stack.pop
    when 'MULT' then register[0] *= stack.pop
    when 'DIV' then register[0] /= stack.pop 
    when 'MOD' then register[0] %= stack.pop
    when 'POP' then register[0] = stack.pop
    when 'PRINT' then puts register[0]
    end
  end
end

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)

# LS Solution:

def minilang(program)
  stack = []
  register = 0 # because no helper methods ended up being needed, I can simply reassign this variable without worrying about method scopes
  program.split.each do |token|
    case token
    when 'ADD'   then register += stack.pop
    when 'DIV'   then register /= stack.pop
    when 'MULT'  then register *= stack.pop
    when 'MOD'   then register %= stack.pop
    when 'SUB'   then register -= stack.pop
    when 'PUSH'  then stack.push(register)
    when 'POP'   then register = stack.pop
    when 'PRINT' then puts register
    else              register = token.to_i # this works in a much more concise way than checking if it is a numeric string with an if statement like I did, however...
    end # this also means that the method will change the register to 0 whenever a word doesn't match the above, and we can't give an error message when triggering the else condition
  end
end

## Further Exploration

# write a 'program' to be processed by #minilang which evaluates and prints the result of this expression:
# (3 + (4 * 5) - 7) / (5 % 3)

puts '----'

minilang('3 PUSH 5 MOD PUSH 7 PUSH 4 PUSH 5 MULT PUSH 3 ADD SUB DIV PRINT') # => 8

# Add error messages to the method: detect and report if the stack is empty when attempting to pull from it; also detect/report if a word is misspelled
# going to go back to my version since it makes the error reporting a bit easier

def minilang(string_of_commands)
  register = 0
  stack = []

  string_of_commands.split.each do |command|
    if %w(ADD SUB MULT DIV MOD POP).include?(command) && stack.empty?
      puts "Stack is empty, cannot execute."
      return "Error: Empty stack."
    elsif command.to_i.to_s == command
      register = command.to_i
      next
    end

    case command
    when 'PUSH'   then stack.push(register)
    when 'ADD'    then register += stack.pop
    when 'SUB'    then register -= stack.pop
    when 'MULT'   then register *= stack.pop
    when 'DIV'    then register /= stack.pop 
    when 'MOD'    then register %= stack.pop
    when 'POP'    then register = stack.pop
    when 'PRINT'  then puts register
    else               
                       puts "Misspelled command!"
                       return "Error: Misspelled command."
    end
  end

  nil
end

puts '----'

error_1 = minilang('3 PRNT')
p error_1

error_2 = minilang('4 PUSH MULT ADD PRINT')
p error_2

default_return_value = minilang('5 PUSH 2 ADD PRINT')
p default_return_value
