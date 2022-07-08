## Original Code:

# on first run, it told me 6 was too small, and 7 was too big
# if I tried to enter '6.5' it would ignore the guess and simply ask again
# it seemed that the correct number may be a float, but only integers are valid guesses?
# however, I also noticed that I was able to enter way more than 3 guesses,
# even though it's supposed to only give me 3.
# after more testing, I realize that the winning number is changing, and even if I win,
# it still has me play more.
# this is because instead of simply using the loop, it is calling #guess_number recursively,
# leading to a new winning number being chosen, a new attempts var being initialized at 0,
# and a new round of guesses.
# under this stystem, the only way to end the game is to win enough times in a row that
# you've cleared out all the existing levels of the recursion. if you make a wrong guess,
# that sets up another game at another level of recursion. although, if you alternate
# between winning and making a wrong guess, you may end up making 3 wrong guesses on the
# same level of recursion, leading to the end of that level.
# still, effectively, I had to ctrl+c to exit.

# def valid_integer?(string)
#   string.to_i.to_s == string # only integers are valid guesses
# end

# def guess_number(max_number, max_attempts)
#   winning_number = (1..max_number).to_a.sample # each level of recursion picks a new winning number
#   attempts = 0 # on each level of recursion, reassigns `attempts` to 0

#   loop do
#     attempts += 1
#     break if attempts > max_attempts # this should cause a break after 3 guesses

#     input = nil
#     until valid_integer?(input)
#       print 'Make a guess: '
#       input = gets.chomp
#     end

#     guess = input.to_i

#     if guess == winning_number
#       puts 'Yes! You win.' # this will actually end the round, but there could still be more levels of recursion to resolve
#     else
#       puts 'Nope. Too small.' if guess < winning_number
#       puts 'Nope. Too big.'   if guess > winning_number

#       # Try again: # this note was included to start with
#       guess_number(max_number, max_attempts) # calls #guess_number recursively, causing the problems
#     end
#   end
# end

# guess_number(10, 3)

## Debugged Code:

def valid_integer?(string)
  string.to_i.to_s == string
end

def guess_number(max_number, max_attempts)
  winning_number = (1..max_number).to_a.sample
  attempts = 0

  loop do
    attempts += 1
    break if attempts > max_attempts

    input = nil
    until valid_integer?(input)
      print 'Make a guess: '
      input = gets.chomp
    end

    guess = input.to_i

    if guess == winning_number
      puts 'Yes! You win.'
      break # even without the recursion, this is needed,
    else # otherwise you're forced to guess after winning until the attempts are used up
      puts 'Nope. Too small.' if guess < winning_number
      puts 'Nope. Too big.'   if guess > winning_number

      # I removed the recursion, since the loop already serves the purpose
    end
  end
end

guess_number(10, 3)
