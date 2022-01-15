# m = p * (j / (1 - (1 + j)**(-n)))
# formula for calculating monthly payment

def prompt(message)
  puts("=> #{message}")
end

def number?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

prompt("Welcome to Rubo-corp's loan calculator!")
prompt("We're here to help! We just need some info.")

prompt("First, what is the Annual Percentage Rate (APR) of your loan?")
apr = 0
loop do
  apr = gets.chomp
  if number?(apr)
    apr = apr.to_f / 100
    break
  else
    prompt("Please just provide the number, e.g. '85' instead of '85%'")
  end
end

prompt("Next, please enter the dollar amount of your desperately-needed loan.")
loan_amount = 0
loop do
  loan_amount = gets.chomp
  if number?(loan_amount)
    loan_amount = loan_amount.to_i
    break
  else
    prompt("I'm sorry, but we don't have time for your sass.")
    prompt("Enter a valid number, urchin.")
  end
end

prompt("And how many years did you commit to being a filthy debtor?")
loan_years = 0
loop do
  loan_years = gets.chomp
  if number?(loan_years)
    loan_years = loan_years.to_i
    break
  else
    prompt("Do not test us. What is the term of your loan in years?")
  end
end

monthly_interest_rate = apr / 12
loan_months = loan_years * 12
monthly_payment = loan_amount *
                  (monthly_interest_rate / 
                  (1 - (1 + monthly_interest_rate)**(-loan_months)))

results_prompt = <<-MSG
  Wow, this is fantastic news for at least one of us!
  Your monthly payment is a low $#{format('%.2f', monthly_payment)}!
  Your monthly interest rate is only #{monthly_interest_rate * 100}%. Wowie!
  And you have a whole #{loan_months} months before we call our goons!
  You're so lucky that we're so generous :D
MSG

prompt(results_prompt)
