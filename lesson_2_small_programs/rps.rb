VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'Spock']

VALID_ABBREVIATIONS = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  l: 'lizard',
  S: 'Spock'
}

RULES = {
  rock: ['scissors', 'lizard'],
  paper: ['rock', 'Spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['paper', 'Spock'],
  Spock: ['rock', 'scissors']
}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(player, computer)
  if RULES[player.to_sym].include?(computer)
    true
  elsif RULES[computer.to_sym].include?(player)
    false
  else
    nil
  end
end

def display_results(player, computer, scoreboard)
  prompt("You chose: #{player}; Computer chose: #{computer}")
  if win?(player, computer) == true
    prompt("You won!")
    prompt(scoreboard)
  elsif win?(player, computer) == false
    prompt("Computer won!")
    prompt(scoreboard)
  else win?(player, computer) == nil
    prompt("It's a tie!")
    prompt(scoreboard)
  end
end

rules_message = <<MSG
  Rock beats: #{RULES[:rock].join(' or ')}
  Paper beats: #{RULES[:paper].join(' or ')}
  Scissors beats: #{RULES[:scissors].join(' or ')}
  Lizard beats: #{RULES[:lizard].join(' or ')}
  Spock beats: #{RULES[:Spock].join(' or ')}
MSG

prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")
prompt("Do you want to hear the rules?")
if Kernel.gets().chomp().downcase().start_with?('y')
  prompt(rules_message)
end

player_score = 0
computer_score = 0
scoreboard = ''

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}, or just the first letter.")
    prompt("(If you abbreviate, use 's' for 'scissors', or 'S' for 'Spock'.)")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    elsif VALID_ABBREVIATIONS.key?(choice.to_sym)
      choice = VALID_ABBREVIATIONS[choice.to_sym]
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  if win?(choice, computer_choice) == true
    player_score += 1
  elsif win?(choice, computer_choice) == false
    computer_score += 1
  end

  scoreboard = "Your score: #{player_score}; Computer score: #{computer_score}."
  display_results(choice, computer_choice, scoreboard)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
