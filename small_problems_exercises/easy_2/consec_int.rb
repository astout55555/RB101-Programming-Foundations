def prompt(message)
  puts ">> #{message}"
end

def valid_number?(input)
  input.to_i.to_s == input && input.to_i.positive?
end

int = 0
loop do
  prompt('Please enter an integer greater than 0:')
  input = gets.chomp
  if valid_number?(input)
    int = input.to_i
    break
  else
    prompt('Invalid entry.')
  end
end

operation = ''
loop do
  prompt("Enter 's' to compute the sum, or 'p' to compute the product.")
  operation = gets.chomp.downcase
  valid_responses = %w[s p]
  break if valid_responses.include?(operation)

  prompt("Invalid entry. And don't ask 'Of what?' just do what I tell you!")
end

sum_total = 1.upto(int).inject(:+)
prod_total = 1.upto(int).inject(:*)

case operation
when 's' then puts "The sum of the integers between 1 and #{int} is #{sum_total}."
when 'p' then puts "The product of the integers between 1 and #{int} is #{prod_total}."
else puts "I didn't understand. Please run the program again."
end
