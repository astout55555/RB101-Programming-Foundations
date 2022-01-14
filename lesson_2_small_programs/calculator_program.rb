require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
# only using this for regular strings for now. using a configuration file with string interpolation
# requires a bunch of finangling, and it'll be a better use of time to simply move to the next assignment

def prompt(message)
  Kernel.puts("=> #{message}")
end

def number?(input) # check to make sure input is a number (integer or float)
  input.to_i.to_s == input || input.to_f.to_s == input # true if it's either an integer or a float
end

def operation_to_message(input)
  operation = case input
              when '1'
                'Adding'
              when '2'
                'Subtracting'
              when '3'
                'Multiplying'
              when '4'
                'Dividing'
              end

  prompt("You say you want to do some #{operation.downcase}? Okay then!")

  operation
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets.chomp

  if name == name.to_i.to_s || name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

loop do
  number1 = 0
  loop do
    prompt(MESSAGES['first_number'])
    number1 = Kernel.gets.chomp

    if number?(number1)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  number2 = 0
  loop do
    prompt(MESSAGES['second_number'])
    number2 = Kernel.gets.chomp

    if number?(number2)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)
  operator = 0
  loop do
    operator = Kernel.gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['valid_operation'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_f + number2.to_f
           when '2'
             number1.to_f - number2.to_f
           when '3'
             number1.to_f * number2.to_f
           when '4'
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}")

  prompt(MESSAGES['again'])
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for calculating with me, #{name}!")
