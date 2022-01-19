puts "What is your age?"
current_age = gets.chomp.to_i

puts "At what age do you plan on retiring?"
retirement_age = gets.chomp.to_i

working_years = retirement_age - current_age

current_year = Time.now.year
retirement_year = current_year + working_years

puts %Q(
It's #{current_year}. You will retire in #{retirement_year}. 
You only have #{working_years} years of work left to go!
)
