puts "What is your name?"
name = gets.chomp!

if name[-1] == '!'
  name = name.chop!
  puts "HELLO #{name.upcase}! WHY ARE WE SCREAMING?"
elsif name == name.upcase
  puts "HELLO #{name}! WHY ARE WE SCREAMING?"
else
  puts "Hello #{name}...that's it. Nothing special about this program. No secrets."
end
