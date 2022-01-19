def find_age
  rand(20..200)
end

def prompt(message)
  puts "=> #{message}"
end

prompt("What's your name, hun?")
name = gets.chomp
if name == ''
  name = 'Teddy'
end

prompt("Alright, #{name}, I will now astound you by guessing your age!")
prompt("And your age is...#{find_age}! Yes! Don't bother confirming!")
prompt("(exit left pursued by bear)")