require 'pry-byebug'

=begin

### Problem:

Build a single player Tic Tac Toe game where a user can play against the computer.

### High level sequence of game:

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

### Main subprocesses needed:

'display board'
'user marks square'
'computer marks square'
'determine if there is a winner'
'determine if the board is full'
'display winner; display tie'
'check if player wants to play again'
'reset board'

### Main Algorithm:

display message asking if user wants to see instructions
  if yes, showing labeling system for squares 1-9
    display board except with values of board hash filled in as 1-9 instead of blank spaces
    display message explaining the rules
  if no... [another extra feature - player can choose 'X' or 'O'?]
    start game loop    

initialize empty board
display board

game loop [
  player turn loop
    get user input for move
    loop until valid position is given
      [subprocess: determine if a position is valid]
      diplay error if not valid
    use input to change board state (update board hash)
  display board

  check for win conditions [subprocess: determine winner]
    if yes, display victor
      get user input for playing again?
      if no, exit game loop
      if yes, reset board (initialize board again), restart game loop

  check for full board (tie since no winner) [subprocess: check for full board]
    if yes, display tie
      get user input for playing again?
      if no, exit game loop
      if yes, reset board, restart game loop
    
  computer turn loop
    randomly select a position to fill
      if position is valid, change board state
        display board
        break loop
      if not valid, select a new position (continue loop)
  
  check for winner again
  check for tie again
]

display ending thank you message

### Smaller subprocess algorithms [using these names as placeholders while I focus on the larger game structure]:

player_won?
computer_won?
full_board?
valid_move?

# The algorithms for `player_won?` and `computer_won?` are a bit more complex, but will be very similar to each other:

outside of these methods, set up a WINNING_COMBINATIONS array (a constant I can access within method definitions)
  this should be made up of sub-arrays, each being a winning combo like [1, 2, 3] or [1, 4, 7]

in these two methods, create an empty current_board array
initialize a `victory` variable with a starting value of false
iterate through key/value pairs of the board hash
  if the value matches what we're looking for ('X' for the player or 'O' for the computer), then insert the key into the current_board array
# once we've moved all the matching positions into the current_board array, we need to compare this with the WINNING_COMBINATIONS array
iterate through the WINNING_COMBINATIONS array
  if the current_board array includes all of the elements of the current iteration, change the `victory` value to true
return the value of the `victory` variable (true or false)

### NOTES ###
# I adjusted a few things as I went along, in order to have the program run correctly with my added features, so it doesn't always line up with the algorithms above
# some things have been adjusted to better go with the feel/attitude of the game,
#   e.g. instead of looping for valid input the game may simply scold you and give you default values if you don't follow instructions
# rather than static symbols for player and computer moves, it is customizable, even allowing single character choices outside of 'X' or 'O'
# when I check for a victor, I'm just checking if the player won or if the computer won, depending on who just went
# there is a skippable tutorial (output of instructions with the labeled board), but if you make an invalid choice later it will remind you how to play


=end

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

def initialize_board
  new_board = {}
  (1..9).each {|num| new_board[num] = ' '}
  new_board
end

# This first section (above) was from the walkthrough.
# Now that I have a board and a way to view/change its status, I can
# proceed with my own ideas of how to build the game before watching
# further through the walk through, I think.

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

def player_won?(brd, player_mark) 
  player_victory = false
  current_board = []

  brd.each_pair do |key, value|
    if value == player_mark
      current_board << key
    end
  end

  WINNING_COMBINATIONS.each do |combo|
    if combo.all? { |num| current_board.include?(num) }
      player_victory = true
    end
  end

  player_victory # returns true or false
end

def computer_won?(brd, computer_mark)
  computer_victory = false
  current_board = []

  brd.each_pair do |key, value|
    if value == computer_mark
      current_board << key
    end
  end

  WINNING_COMBINATIONS.each do |combo|
    if combo.all? { |num| current_board.include?(num) }
      computer_victory = true
    end
  end

  computer_victory # returns true or false
end

def full_board?(brd) # if board is full, this should return true. this doubles as a check for a tie because I'm calling this method after checking for a victor
  !brd.values.include?(' ') # returns false if there are any blank spaces on the board
end

def valid_move?(brd, move) # should return true as long as the position is blank (and therefore a valid choice)
  brd[move] == ' '
end

def show_tutorial_board
  tutorial_board = {}
  (1..9).each {|num| tutorial_board[num] = "#{num}" }
  display_board(tutorial_board)
end

### Meat of program (user input, game, etc.) is below this point, using the set-up and methods defined above

puts 'Welcome to Tic Tac Toe! You are about to face a fearsome computer opponent!'

puts 'Would you like to see some instructions for how to play? y/n'
input = gets.chomp.downcase
if (input == 'y') || (input == 'yes')
  show_tutorial_board
  puts "It's regular Tic Tac Toe rules, except you will choose a square based on this ordering."
  puts 'When prompted, simply enter a number (1-9) to pick your square and take your turn.'
elsif (input == 'n') || (input == 'no')
  puts 'An old pro, eh?'
else
  puts "You seem easily confused. I'll just show you how to play."
  show_tutorial_board
  puts "It's regular Tic Tac Toe rules, except you will choose a square based on this ordering."
  puts 'When prompted, simply enter a number (1-9) to pick your square and take your turn.'
end

puts "Okay, would you like to play as X's or O's?"

marking_choice = gets.chomp.upcase
if marking_choice == 'X'
  player_mark = 'X'
  computer_mark = 'O'
elsif (marking_choice == 'O') || (marking_choice == '0')
  player_mark = 'O'
  computer_mark = 'X'
elsif (marking_choice.length == 1) && (marking_choice != ' ')
  puts "That's an...interesting choice. Sure, let's go with that."
  player_mark = marking_choice
  computer_mark = 'O'
else
  puts "Funny. Why don't we just make you X's and we'll move on."
  player_mark = 'X'
  computer_mark = 'O'
end


puts 'Alright! Now just hit enter to get started.'
gets

loop do # main program loop

  system 'clear'
  board = initialize_board
  display_board(board)

  loop do # single game loop

    loop do # player turn loop
      puts 'Your move:'
      user_move = gets.chomp.to_i # using integers for the board hash keys so I need to convert it when I get it
      if valid_move?(board, user_move)
        board[user_move] = player_mark # place player's mark on the board according to the selected square
        display_board(board)
        break
      else
        show_tutorial_board
        puts '^^^ As a reminder, here is the ordering for the squares. Enter a number to take your turn.'
        display_board(board)
      end
    end

    break if player_won?(board, player_mark) || full_board?(board)

    loop do # computer turn loop
      computer_move = (1..9).to_a.sample # random position between 1 and 9
      if valid_move?(board, computer_move)
        puts 'My supercomputer will surely outsmart you! Take your turn my pretty!'
        board[computer_move] = computer_mark
        display_board(board)
        break
      end
    end

    break if computer_won?(board, computer_mark) || full_board?(board)

  end

  if player_won?(board, player_mark)
    puts "It's not possible! How could my magnificent creation lose!?"
    puts 'I want a rematch! Do you accept? y/n'
  elsif computer_won?(board, computer_mark)
    puts "Ha! I knew you couldn't defeat my supercomputer!"
    puts 'Would you like to give it another shot, you loser? y/n'
  else
    puts "Looks like this game is a tie. That's a bit unsatisfying, huh?"
    puts 'Would you like to play again? y/n'
  end

  play_again = gets.chomp.downcase
  break unless (play_again == 'y') || (play_again == 'yes')

end

puts "I'll admit it. I had fun. I hope you did too :) Thanks for playing!"
