require 'pry-byebug'

ALL_CARDS = [
  'Ace', 'Ace', 'Ace', 'Ace',
  '2', '2', '2', '2',
  '3', '3', '3', '3',
  '4', '4', '4', '4',
  '5', '5', '5', '5',
  '6', '6', '6', '6',
  '7', '7', '7', '7',
  '8', '8', '8', '8',
  '9', '9', '9', '9',
  '10', '10', '10', '10',
  'Jack', 'Jack', 'Jack', 'Jack',
  'Queen', 'Queen', 'Queen', 'Queen',
  'King', 'King', 'King', 'King'
]

def prompt(msg)
  puts "=> #{msg}"
end

def deal_starting_hands!(game_data)
  2.times do
    game_data[:player][:hand] << game_data[:deck].shift
    game_data[:dealer][:hand] << game_data[:deck].shift
  end
end

def list_cards(hand, separator_string = ', ', final_separator = 'and')
  if hand.size > 2
    final_card = hand.last
    mostly_joined = hand[(0..(hand.size - 2))].join(separator_string)
    "#{mostly_joined}#{separator_string}#{final_separator} #{final_card}"
  else
    hand.join(" #{final_separator} ")
  end
end

def announce_visible_dealer_cards(dealer_hand)
  visible_dealer_cards = dealer_hand[(1..dealer_hand.size)].join(', ')
  prompt "Dealer has: #{visible_dealer_cards} and one unknown card."
end

def announce_all_visible_cards(game_data)
  announce_visible_dealer_cards(game_data[:dealer][:hand])
  prompt "You have: #{list_cards(game_data[:player][:hand])}."
end

def detect_result(game_data)
  if busted?(game_data[:player][:total])
    :p_busted
  elsif busted?(game_data[:dealer][:total])
    :d_busted
  elsif game_data[:player][:total] < game_data[:dealer][:total]
    :d_wins
  elsif game_data[:player][:total] > game_data[:dealer][:total]
    :p_wins
  else
    :tie
  end
end

def display_result(game_data)
  case detect_result(game_data)
  when :p_busted then prompt "You busted! Dealer wins!"
  when :d_busted then prompt "Dealer busted! You win!"
  when :d_wins then prompt "Dealer wins!"
  when :p_wins then prompt "You win! Congratulations!"
  when :tie then prompt "This game was a tie."
  end
end

def end_of_round_output(game_data)
  face_down_card = game_data[:dealer][:hand].shift
  d_list = list_cards((game_data[:dealer][:hand] + [face_down_card]))
  p_list = list_cards(game_data[:player][:hand])

  puts "=============="
  prompt "Dealer has #{d_list}, a total of #{game_data[:dealer][:total]}."
  prompt "You have #{p_list}, a total of #{game_data[:player][:total]}."
  puts "=============="

  display_result(game_data)

  prompt "Player wins: #{game_data[:player][:wins]}."
  prompt "Dealer wins: #{game_data[:dealer][:wins]}."
  prompt "Hit enter to continue."
  gets
end

def hit!(deck, hand)
  hand << deck.shift
end

def busted?(hand_total)
  hand_total > 21
end

def find_total_value(hand)
  total_aces = hand.count('Ace')
  total_value = total_aces
  all_cards_except_aces = hand.reject { |card| card == 'Ace' }

  all_cards_except_aces.each do |card|
    total_value += if card.to_i == 0
                     10
                   else
                     card.to_i
                   end
  end

  if total_value < 12 && total_aces > 0
    total_value += 10
  end

  total_value
end

def player_turn(game_data)
  loop do
    announce_all_visible_cards(game_data)

    prompt "Would you like to (h)it or (s)tay?"
    answer = gets.chomp.downcase

    if answer == 'hit' || answer == 'h'
      hit!(game_data[:deck], game_data[:player][:hand])
      game_data[:player][:total] = find_total_value(game_data[:player][:hand])
      break if busted?(game_data[:player][:total])
    elsif answer == 'stay' || answer == 's'
      break
    else
      prompt "Sorry, that's not a valid answer."
    end
  end
end

def dealer_turn(game_data)
  loop do
    game_data[:dealer][:total] = find_total_value(game_data[:dealer][:hand])
    sleep 1

    if game_data[:dealer][:total] < 17
      hit!(game_data[:deck], game_data[:dealer][:hand])
      prompt "Dealer hits!"
      announce_visible_dealer_cards(game_data[:dealer][:hand])
    else
      prompt "Dealer stays."
      break
    end
  end
end

def play_again?
  puts "-------------"
  prompt "That ends the match! Do you want to play again? (y or n)"
  answer = gets.chomp.downcase
  answer == 'y' || answer == 'yes'
end

def start_game!(game_data)
  system 'clear'

  game_data[:player][:hand] = []
  game_data[:dealer][:hand] = []
  game_data[:deck] = ALL_CARDS.shuffle

  deal_starting_hands!(game_data)
end

# Actual game code below #

system 'clear'
prompt 'Welcome to the game of Twenty-one! Hit enter to start.'
gets

loop do # main program loop
  # initialize or reinitialize empty game_data hash
  game_data = {
    player: {
      hand: [],
      total: 0,
      wins: 0
    },
    dealer: {
      hand: [],
      total: 0,
      wins: 0
    },
    deck: []
  }

  loop do # game loop (until someone wins 5 times)
    start_game!(game_data)

    # player turn
    player_turn(game_data)
    game_data[:player][:total] = find_total_value(game_data[:player][:hand])
    if busted?(game_data[:player][:total])
      game_data[:dealer][:wins] += 1
      end_of_round_output(game_data)
      game_data[:dealer][:wins] == 5 ? break : next
    else
      prompt 'You chose to stay.'
    end

    # dealer turn
    dealer_turn(game_data)
    if busted?(game_data[:dealer][:total])
      game_data[:player][:wins] += 1
      end_of_round_output(game_data)
      game_data[:player][:wins] == 5 ? break : next
    end

    # compare hands to find winner if nobody busted
    if detect_result(game_data) == :p_wins
      game_data[:player][:wins] += 1
    elsif detect_result(game_data) == :d_wins
      game_data[:dealer][:wins] += 1
    end
    end_of_round_output(game_data)
    break if (game_data[:player][:wins] == 5) ||
             (game_data[:dealer][:wins] == 5)
  end

  break unless play_again?
end

# end of program message
prompt "That was fun, let's play again sometime!"
