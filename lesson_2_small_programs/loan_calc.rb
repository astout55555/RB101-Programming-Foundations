# m = p * (j / (1 - (1 + j)**(-n)))
# formula for calculating monthly payment

def prompt(message)
  puts("=> #{message}")
end

prompt("Welcome to Rubo-corp's loan calculator!")
prompt("We're here to help! We just need some info.")

prompt("First, please enter the dollar amount of your desperately-needed loan.")
loan_amount = 0
loop do
  loan_amount = gets.chomp
  if loan_amount.to_i > 0
    loan_amount = loan_amount.to_i
    break
  else
    prompt("I'm sorry, but we don't have time for your sass.")
    prompt("Enter a valid number, urchin. No special characters.")
  end
end

prompt("And how many years did you commit to being a filthy debtor?")
loan_years = 0
loop do
  loan_years = gets.chomp
  if loan_years.to_i > 0
    loan_years = loan_years.to_i
    break
  else
    prompt("Do not test us. What is the term of your loan in years?")
  end
end

prompt("Now tell me the Annual Percentage Rate (APR) of your loan or else!")
apr = 0
zero_apr = true
loop do
  apr = gets.chomp
  if apr.to_f > 0
    apr = apr.to_f / 100
    zero_apr = false
    break
  elsif apr == '0' || apr == '0%'
    apr = apr.to_f / 100
    prompt("Seriously? You need a loan calculator for this?")
    prompt("If your APR is 0% then just divide up the loan by the term!")
    monthly_payment = loan_amount / (loan_years * 12)
    prompt("Your monthly payment is $#{format('%.2f', monthly_payment)}.")
    prompt("Now SCRAM!")
    break
  else
    prompt("Provide the APR as either e.g. '65%' or '65' ya dingus!")
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

prompt(results_prompt) unless zero_apr
