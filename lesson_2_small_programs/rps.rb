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

def win?(player_choice, computer_choice)
  if RULES[player_choice.to_sym].include?(computer_choice)
    true
  elsif RULES[computer_choice.to_sym].include?(player_choice)
    false
  end
end

def display_results(player_choice, computer_choice, scoreboard)
  prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")
  if win?(player_choice, computer_choice) == true
    prompt("You won!")
  elsif win?(player_choice, computer_choice) == false
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
  prompt(scoreboard)
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
  player_move = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}, or just the first letter.")
    prompt("(If you abbreviate, use 's' for 'scissors', or 'S' for 'Spock'.)")
    player_move = Kernel.gets().chomp()

    if VALID_CHOICES.include?(player_move)
      break
    elsif VALID_ABBREVIATIONS.key?(player_move.to_sym)
      player_move = VALID_ABBREVIATIONS[player_move.to_sym]
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_move = VALID_CHOICES.sample

  if win?(player_move, computer_move) == true
    player_score += 1
  elsif win?(player_move, computer_move) == false
    computer_score += 1
  end

  scoreboard = "Your score: #{player_score}; Computer score: #{computer_score}."
  display_results(player_move, computer_move, scoreboard)

  answer = ''
  loop do
    prompt("Do you want to play again?")
    answer = Kernel.gets().chomp().downcase()
    if answer.start_with?('y')
      prompt("Okay!")
      break
    elsif answer.start_with?('n')
      prompt("Thank you for playing. Goodbye!")
      break
    else
      prompt("I didn't understand you. Please answer with 'y' or 'n'.")
    end
  end

  break unless answer.start_with?('y')
end
