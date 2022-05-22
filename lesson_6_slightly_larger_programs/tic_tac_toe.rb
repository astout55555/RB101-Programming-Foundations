require 'pry-byebug'

WINNING_COMBINATIONS = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7]
]

DIFFICULTY_RATINGS = {
  'easy' => 1,
  'normal' => 2,
  'hard' => 3,
  'demonic' => 4
}

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

def prompt(string)
  puts "=> #{string}"
end

def determine_winner(brd, hum_mark, comp_mark)
  WINNING_COMBINATIONS.each do |combo|
    if combo.all? { |num| brd[num] == hum_mark }
      return 'human'
    elsif combo.all? { |num| brd[num] == comp_mark }
      return 'computer'
    end
  end
  nil # returns nil if neither human nor computer have won
end

def someone_won?(brd, hum_mark, comp_mark)
  !!determine_winner(brd, hum_mark, comp_mark)
end # returns a string or nil, `!!` changes value to boolean

def full_board?(brd) # if board is full, this should return true.
  !brd.values.include?(' ') # returns false if any blank spaces on board
end

def valid_move?(brd, move) # should return true
  brd[move] == ' ' # as long as the position is blank (choice is valid)
end

def joinor(array, separator_string = ', ', final_separator = 'or')
  if array.size > 2
    final_element = array.pop
    mostly_joined = array.join(separator_string)
    "#{mostly_joined}#{separator_string}#{final_separator} #{final_element}"
  else
    array.join(" #{final_separator} ")
  end
end

def list_valid_moves(brd)
  valid_moves = brd.keys.select { |key| brd[key] == ' ' }
  joinor(valid_moves)
end

def show_tutorial_board
  tutorial_board = {}
  (1..9).each { |num| tutorial_board[num] = num.to_s }
  display_board(tutorial_board)
end

def display_scoreboard(hum_wins, comp_wins, match_wins)
  prompt "SCOREBOARD"
  prompt "Player has won #{hum_wins} games."
  prompt "Computer has won #{comp_wins} games."
  prompt "Total games needed to win match: #{match_wins}"
end

def give_instructions
  prompt "It's regular Tic Tac Toe rules, except the squares are ordered."
  prompt 'When prompted, simply enter a number (1-9) to pick your square.'
  prompt "If you need to see the scoreboard, just type 'score' on your turn."
  prompt 'But first, we have a couple more settings to adjust.'
end

# rubocop:disable Metrics/CyclomaticComplexity
# I'm not sure there's a way to make these two less complex,
# given the tasks they handle. Not without breaking computer_moves
# into a bunch of smaller methods based on the difficulty level, or
# find_final_sqaure into two separate methods (1 for each mode).
# They're each down to 8/7 when detected, so it doesn't seem too bad
# as a cost for keeping the code DRY.
def find_final_square(brd, play_mark, comp_mark, mode)
  final_square = nil

  WINNING_COMBINATIONS.each do |line|
    hum_squares = brd.values_at(*line).count(play_mark)
    computer_squares = brd.values_at(*line).count(comp_mark)
    squares_filled = hum_squares + computer_squares
    next unless squares_filled == 2

    if (hum_squares == 2 && mode == 'defense') ||
       (computer_squares == 2 && mode == 'offense')
      final_square = line.select { |square| brd[square] == ' ' }.first
    end
  end

  final_square # returns nil or brd key (int) for computer defense or attack
end

# this one is also 8/7 for the PerceivedComplexity offense, which seems okay
# rubocop:disable Metrics/PerceivedComplexity
def computer_moves(brd, play_mark, comp_mark, level, valid_moves)
  move = nil

  while move.nil?
    move = find_final_square(brd, play_mark, comp_mark, 'offense') if level > 3
    break unless move.nil?

    move = find_final_square(brd, play_mark, comp_mark, 'defense') if level > 2
    break unless move.nil?

    move = (5 if brd[5] == ' ') if level > 1
    break unless move.nil?

    move = valid_moves.sample
  end

  brd[move] = comp_mark
end
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity

def human_turn(brd, hum_mark, hum_wins, comp_wins, match_wins)
  loop do
    prompt "Choose a square: #{list_valid_moves(brd)}"
    user_input = gets.chomp

    if valid_move?(brd, user_input.to_i) # to match the board hash keys
      brd[user_input.to_i] = hum_mark # place human's mark on the board
      break
    elsif user_input.downcase.start_with?('s') # 'score' or 'scoreboard'
      display_scoreboard(hum_wins, comp_wins, match_wins)
    else
      show_tutorial_board
      prompt '^^^ As a reminder, here is the ordering for the squares.'
      display_board(brd)
    end
  end
end

def computer_turn(brd, hum_mark, comp_mark, level)
  system 'clear'
  prompt "My supercomputer will surely outsmart you! Just watch!"
  valid_moves = brd.keys.select { |key| brd[key] == ' ' }
  computer_moves(brd, hum_mark, comp_mark, level, valid_moves)
  display_board(brd)
end

def alternate_player(current_player)
  current = current_player.pop

  if current == 'human'
    current_player << 'computer'
  elsif current == 'computer'
    current_player << 'human'
  end
end

def computer_picks(level)
  options = ['human', 'computer']

  if level == 1
    'human'
  elsif level <= 3
    options.sample
  elsif level >= 4
    'computer'
  end
end

### Meat of program (user input, game, etc.) is below this point ###

prompt 'Welcome to Tic Tac Toe!'
prompt 'You are about to face a fearsome computer opponent!'

prompt 'Would you like to see some instructions for how to play? y/n'
input = gets.chomp.downcase
if (input == 'y') || (input == 'yes')
  show_tutorial_board
  give_instructions
elsif (input == 'n') || (input == 'no')
  prompt 'An old pro, eh?'
else
  prompt "You seem easily confused. I'll just show you how to play."
  show_tutorial_board
  give_instructions
end

prompt "What would you like to use as your marker during the game?"
prompt "Pick anything you want, as long as it's a single character."
hum_mark = 'X'
comp_mark = 'O'
loop do
  marking_choice = gets.chomp.upcase

  if marking_choice == 'O'
    prompt "You picked O's? But Compy wanted O's...this is fine."
    hum_mark = marking_choice
    comp_mark = 'X'
    break
  elsif (marking_choice.length == 1) && (marking_choice != ' ')
    prompt "That is a choice! Sure, let's go with that."
    hum_mark = marking_choice
    comp_mark = 'O'
    break
  else
    prompt "Hey, come on! Single-character only, and no spaces."
  end
end

level = 0
loop do
  prompt "Choose your difficulty: easy, normal, hard, or demonic"
  difficulty = gets.chomp.downcase
  level = DIFFICULTY_RATINGS[difficulty]

  case level
  when 1
    prompt 'Not much for thinking, eh? Easy it is!'
    break
  when 2
    prompt 'Fair enough. The standard settings, then.'
    break
  when 3
    prompt "As you wish. Your doom is nigh!"
    break
  when 4
    prompt "NOT TO FIFTY! Just kidding, I'd be happy to crush you!"
    break
  else
    prompt "That's not really an option. Let's try again."
  end
end

current_player = []
prompt 'We need to decide who goes first. Do you want to pick? y/n'
loop do
  accept_picking = gets.chomp.downcase

  if accept_picking == 'y' || accept_picking == 'yes'
    prompt "Okay, who'll go first then? Human or computer?"

    loop do
      human_choice = gets.chomp.downcase

      if human_choice == 'computer' || human_choice == 'c'
        current_player << human_choice
        break
      elsif %w(human h me).include?(human_choice)
        current_player << 'human'
        break
      else
        prompt "I couldn't make that out. Did you say 'human' or 'computer'?"
      end
    end

    break
  elsif accept_picking == 'n' || accept_picking == 'no'
    prompt "Alright then. I'll have the computer pick..."

    comp_choice = computer_picks(level)

    prompt "...Looks like the #{comp_choice} is going to go first."
    current_player << comp_choice
    break
  end

  prompt "I couldn't hear, did you say 'yes' or 'no' to picking who's first?"
end

prompt 'Lastly, how many games should you have to win to win the whole match?'
wins_input = gets.chomp.to_i
if wins_input > 0
  match_wins = wins_input
else
  prompt "Not sure what to make of what you just said. So let's just say 2."
  match_wins = 2
end

prompt 'Alright! Now just hit enter to get started.'

hum_wins = 0
comp_wins = 0

loop do # main program loop
  gets
  system 'clear'
  display_scoreboard(hum_wins, comp_wins, match_wins)
  board = initialize_board
  display_board(board)

  loop do # single game loop
    if current_player.first == 'human'
      human_turn(board, hum_mark, hum_wins, comp_wins, match_wins)
    elsif current_player.first == 'computer'
      computer_turn(board, hum_mark, comp_mark, level)
    end

    break if someone_won?(board, hum_mark, comp_mark) || full_board?(board)
    alternate_player(current_player)
  end

  case determine_winner(board, hum_mark, comp_mark)
  when 'human'
    prompt "It's not possible! How could my magnificent creation lose!?"
    hum_wins += 1
  when 'computer'
    prompt "Ha! I knew you couldn't defeat my supercomputer!"
    comp_wins += 1
  else
    prompt "Looks like this game is a tie. That's a bit unsatisfying, huh?"
  end

  break if (hum_wins >= match_wins) || (comp_wins >= match_wins)

  prompt "Time for another round. I'll show no mercy!"
  prompt "Hit enter when you're ready for your beating."
end

if hum_wins > comp_wins
  prompt "Inferior...being..."
else
  prompt "You know, I had fun. I hope you did too. Thanks for playing, cutie!"
end
