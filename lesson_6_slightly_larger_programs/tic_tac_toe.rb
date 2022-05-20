require 'pry-byebug'

# rubocop:disable Layout/LineLength
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
    display board except with values of board hash filled in as 1-9 (instead of blank spaces)
    display message explaining the rules
  if no... [another extra feature - player can choose 'X' or 'O'?]
    start game loop

initialize empty board
display board

game loop [
  player turn loop
    get user input for move
    loop until valid position is given [subprocess: determine if a position is valid]
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
I adjusted a few things as I went along, in order to have the program run correctly with my added features, so it doesn't always line up with the algorithms above.
Some things have been adjusted to better go with the feel/attitude of the game,
e.g. instead of looping for valid input the game may simply scold you and give you default values if you don't follow instructions.
Rather than static symbols for player and computer moves, it is customizable, even allowing single character choices outside of 'X' or 'O'.
When I check for a victor, I'm just checking if the player won or if the computer won, depending on who just went.
There is a skippable tutorial (output of instructions with the labeled board), but if you make an invalid choice later it will remind you how to play.

### Additional Features ###

Since I built the game a bit differently to begin with, I now need to do a bit of groundwork before I can tackle some of these.

## First ask: Improved "join" ##

Starting point: the walkthrough version of the game uses a prompt that shows available moves when it is the players turn, like so:

=> Choose a position to place a piece: 1, 2, 3, 4, 5, 6, 7, 8, 9

And the additional feature request is to improve it to read more naturally, like so:

=> Choose a position to place a piece: 1, 2, 3, 4, 5, 6, 7, 8, or 9

I need to create a "joinor" method which produces results like these examples:

joinor([1, 2])                   # => "1 or 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"

First step is to build the regular prompt, showing the available spaces. To do that, I need to have a way of determining open spaces.
(Valid choices / open spaces should be board hash values of ' ')

Algorithm:

create a method named list_valid_moves
  select from the board hash all keys with a value of ' '
  return an array of those keys (integers), save to variable
  call join(', ') on this variable (or pass variable into #joinor as an argument once that is set up)

create a method named joinor(1st arg, 2nd arg, 3rd arg)
  if array still has 2 or more elements
    remove final element from the passed array and store it as a separate variable
    join using 2nd arg as separator, store as variable
    for the final line / return value, use string interpolation:
      add the mostly joined array string and the final element together, separated by the value of the 3rd argument and proper spacing
  otherwise, simply join the array using the 3rd arg an proper spacing (string interpolation) as the argument

## Second ask: Keep Score ##

For this addition, I need to both keep track of how many times the player and the computer have each won, and terminate the game once someone wins 5 times.
I'm not allowed to use global or instance variables, which is fine because I don't really know how to use those yet (I've been working with local variables).

Algorithm:

create variables for player and computer wins, before the main loop
in the case statement that determines what happens when a winner is detected, add code incrementing the appropriate variable
in the 'play again?' code block, instead of seeking user input, use a `break if` statement to end the loop once someone reaches the needed number of wins

in the settings section of the program, seek user input and allow the player to choose the number of games needed to win
  store in a `match_wins` variable
  default to 5 if user gives input which is not a positive integer

make a display_score method, which can be used to show how many wins the player and computer each have, and the total number needed to win
  simply print interpolated statements with the total wins for the player and the computer, and the total needed to win the match

in the tutorial, explain that the player can ask for the score any time during the game

on the player's turn, have the game respond if the player wants to know the score
  if the user input is the word 'score' or 'score?', then run the `display_score` method
  then continue the loop so they can take their turn still

after the main program loop, give flavor to the final ending messages based on who won with an if/else statement

## Third ask: Computer AI: Defense ##

For this addition, I need to have the program recognize when the player has two marks in a row, then have the computer take the remaining spot.

Algorithm:

On computer turn, first check if there is an immediate risk
  if so, find the at risk square and move there.
  otherwise make a random move like before

subprocess: finding an immediate risk
  find out if there is a line with 2 player marks and 0 computer marks

create method immediate_risk?
  iterate through the WINNING_COMBINATIONS constant (array of subarrays of each winning line)
    for each line, count the number of squares which match the player's mark
      if there are 2, count the number of squares which match the computer's mark
        if 0, then return true (a risk is found)
  if no risk is found, return false

create method find_at_risk_square
  create line_threatened variable, initialized as empty array
  iterate through the WINNING_COMBINATIONS constant (array of subarrays of each winning line)
    for each line, count the number of squares which match the player's mark
      if there are 2, reassign the line_threatened variable to this sub-array # if there is more than one line at risk, that's okay, it will just be reassigned again to the second valid line
  select the square number which does not match the player marker
  return the element (not an array with it inside) by chaining something like #first to it

## 4th ask: Computer AI: Offense ##
## 5th ask (A and B): Computer turn refinements ##

I did these steps without working out the algorithm, because it seemed straightforward. I was probably too impatient.
Because I had to increase the number of difficulty settings and rearrange the order of preferred moves, plus adjust setting configuration text etc.,
I ended up spending a lot of time refactoring the code to make it work with minimal rubocop complaints.
I think I found 2 other solutions before settling on the one that is still in the code. They worked,
but rubocop doesn't like complex conditional statements. At least I got a lot of experience interpreting/addressing rubocop's complaints.

What I did was use a hash constant, `DIFFICULTY_RATINGS`, to give a numeric value to the chosen difficulty.
This allowed me to trigger the same line of code for multiple difficulties, still in the order of preference,
by placing the smarter moves first but behind conditionals that required a minimum level of difficulty.
I'm not sure if there's some way to do this without repeated `break if` statements within a while loop,
since I need to avoid the move choice being overwritten by lower priorities, considering I only want to go through it one time at most,
and I'm not really using the loop other than the fact that having my code inside it allows me to use the `break` command.

## 5th ask (C and D): Computer turn refinements ##
## 6th ask: Improve the game loop ##

I'm grouping these two (3?) together because the solution appears to be related to all 3 at once,
although I will likely solve 5C and 6 together, and then go back and solve 5D.
This is because the easiest way to solve 5C (allow the player to choose who goes first) will be to turn the game loop code into something more general,
as requested by #6, which wants me to use some code it provides and fill in the gaps (define the methods it uses to denote subprocesses I should solve).

The code (for #6):

loop do
  display_board(board)
  place_piece!(board, current_player)
  current_player = alternate_player(current_player)
  break if someone_won?(board) || board_full?(board)
end

The main thing it wants is for me to not have to repeat the line with the break conditions.
It is asking me to define the #place_piece! and #alternate_player methods, such that whoever is first goes and then it alternates who is up.

This is how the code would look now if I had limited my code to the walkthrough example:

loop do
  display_board(board)

  player_places_piece!(board)
  break if someone_won?(board) || board_full?(board)

  computer_places_piece!(board)
  break if someone_won?(board) || board_full?(board)
end

Of course mine is already more complicated than this, and doesn't lend itself well to a single method for both turns.
In addition to the board, I need to pass in arguments for the player and computer markers, the numeric difficulty level, and the array of remaining valid moves whenever I try to have the computer take a turn,
which means any method which is meant to execute either turn would also need all this information.
On top of that, the code itself is rather different between the turns,
and on the player's turn I need the board, both markers, the remaining valid moves, and the info for the scoreboard (the number of player wins, comp wins, and total wins needed to win match).

The player's turn involves user input within a loop, checking that the input results in a valid move, and then updating the board.
However, the player can also call up the scoreboard, and there is a message that appears if the input is invalid.
The computer's turn involves branching decision-making based on the preferability of each type of move and the level of computer difficulty.

Because of this, I cannot combine the two turns into a single method without maintaining the separate methods, although these could be placed inside an overarching method...
something like: #current_player_takes_turn(brd, play_mark, comp_mark, level, valid_moves, play_wins, comp_wins, match_wins, current_player),
which is so long that it triggers the line length complaint from rubocop even without indentation or anything else on the line (length == 122).

The method itself would be relatively simple, in that I would just use an if/then statement to execute the code and methods necessary for either turn, depending on the value of current_player.
Finally, the code for #alternate_player(current_player) would be fairly simple as well, simply swapping the value of current_player in some way that
mutates the object it refers to (since reassignment within a method definition would not affect the value of the variables outside of the method definition). I could do something like have
`current_player` be an array with either 'human' or 'computer' inside it. That way, I can mutate the array by replacing its contents (swapping the player) with one or the other based on what I
detect to be inside it, like

```
if current_player.first == 'human'
  current_player.pop
  current_player << 'computer'
elsif...
```

However, it seems to me like this is simply too much for a single method to do and that it's not a best practice to use a method that requires passing in 9 arguments.
On the other hand, this would mean that the game loop itself would be much easier to parse.

I can start by moving the code required for each turn into separate methods that enact the full turn.
Then, I can swap the turn order more easily using a conditional flow that is sensitive to who has been chosen to go first. Something like:

```
loop do
  if current_player.first == 'human'
    human_turn(*args)
  else
    computer_turn(*args)
  end

  break if someone_won?(*args) || board_full?(*args)
  alternate_player(*args) # I don't actually need to use `current_player = alternate_player` because my method mutates the value of current_player directly
end

With this end result, I'm still solving the challenge posed by #6 in that I no longer have to repeat the line checking for break conditions,
plus this is necessary if I want to clean up the game loop and make the turn order adjustable.

Algorithm:

I'll start by moving each turn into a single method which carries out the various tasks involved, using my currently existing sub-methods as needed.
Next, I will create the `current_player` variable, initialized with a value of [], and use prompts and a player input loop to initially fill it (mutate it) so it contains 'human' or 'computer'.
Then, I will create the #alternate_player method as described above.
I will then use the above-described structure for the game loop, thus solving 5C and 6.
Finally, I will add in an option to the prompts/loop which initially fills the empty `current_player` array that allows the player to have the computer decide who goes first.
  For this, I think it'd make sense to have the computer choose based on difficulty level, using a #computer_picks method.
    For easy, the computer should have the human go first.
    For normal or hard it should be random.
    For demonic it should always choose itself, increasing the liklihood that it wins.

=end
# rubocop:enable Layout/LineLength

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
end # returns a string or nil, `!!` changes to boolean

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
  loop do # human turn loop
    prompt "Choose a square: #{list_valid_moves(brd)}"
    user_input = gets.chomp

    if valid_move?(brd, user_input.to_i) # to match the board hash keys
      brd[user_input.to_i] = hum_mark # place human's mark on the board
      display_board(brd)
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

prompt "Okay, would you like to play as X's or O's?"
marking_choice = gets.chomp.upcase
if marking_choice == 'X'
  hum_mark = 'X'
  comp_mark = 'O'
elsif (marking_choice == 'O') || (marking_choice == '0')
  hum_mark = 'O'
  comp_mark = 'X'
elsif (marking_choice.length == 1) && (marking_choice != ' ')
  prompt "That's an...interesting choice. Sure, let's go with that."
  hum_mark = marking_choice
  comp_mark = 'O'
else
  prompt "Funny. Why don't we just make you X's and we'll move on."
  hum_mark = 'X'
  comp_mark = 'O'
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

  if accept_picking.start_with?('y')
    prompt "Okay, who'll go first then? Human or computer?"

    loop do
      human_choice = gets.chomp.downcase

      if human_choice == 'computer'
        current_player << human_choice
        break
      elsif human_choice == 'human' || human_choice == 'me'
        current_player << 'human'
        break
      else
        prompt "I couldn't make that out. Did you say 'human' or 'computer'?"
      end
    end

    break
  elsif accept_picking.start_with?('n')
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
