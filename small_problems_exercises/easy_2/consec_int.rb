def prompt(message)
  puts ">> #{message}"
end

def sum(int)
  total = 0
  1.upto(int) { |i| total += i }
  total
end

def product(int)
  total = 1
  1.upto(int) { |i| total *= i }
  total
end

prompt("Please enter an integer greater than 0:")
int = gets.chomp.to_i

prompt("Enter 's' to compute the sum, or 'p' to compute the product.")
operation = gets.chomp

sum_total = sum(int)
prod_total = product(int)

case operation
when 's' then puts "The sum of the integers between 1 and #{int} is #{sum_total}."
when 'p' then puts "The product of the integers between 1 and #{int} is #{prod_total}."
else puts "I didn't understand. Please run the program again."
end
