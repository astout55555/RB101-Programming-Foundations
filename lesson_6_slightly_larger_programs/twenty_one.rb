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

def deal_starting_hands!(deck, player_hand, dealer_hand)
  player_hand[:face_down_card] << deck.shift
  dealer_hand[:face_down_card] << deck.shift
  player_hand[:face_up_cards] << deck.shift
  dealer_hand[:face_up_cards] << deck.shift
end

def joinand(array, separator_string = ', ', final_separator = 'and')
  if array.size > 2
    final_element = array.pop
    mostly_joined = array.join(separator_string)
    "#{mostly_joined}#{separator_string}#{final_separator} #{final_element}"
  else
    array.join(" #{final_separator} ")
  end
end

def get_player_cards(player_hand)
  all_player_cards = player_hand[:face_down_card] + player_hand[:face_up_cards]
  joinand(all_player_cards)
end

def announce_visible_dealer_cards(dealer_hand)
  visible_dealer_cards = dealer_hand[:face_up_cards].join(', ')
  prompt "Dealer has: #{visible_dealer_cards} and one unknown card."
end

def announce_all_visible_cards(player_hand, dealer_hand)
  announce_visible_dealer_cards(dealer_hand)
  prompt "You have: #{get_player_cards(player_hand)}."
end

def get_all_dealer_cards(dealer_hand)
  all_dealer_cards = dealer_hand[:face_up_cards] + dealer_hand[:face_down_card]
  joinand(all_dealer_cards)
end

def end_of_round_output(p_hand, d_hand, p_total, d_total)
  puts "=============="
  prompt "Dealer has #{get_all_dealer_cards(d_hand)}, a total of #{d_total}."
  prompt "You have #{get_player_cards(p_hand)}, a total of #{p_total}."
  puts "=============="

  if busted?(p_total)
    prompt "You busted! Dealer wins!"
  elsif busted?(d_total)
    prompt "Dealer busted! You win!"
  elsif p_total < d_total
    prompt "Dealer wins!"
  elsif p_total > d_total
    prompt "You win! Congratulations!"
  else
    prompt "This game was a tie."
  end
end

def hit!(deck, hand)
  hand[:face_up_cards] << deck.shift
end

def busted?(hand_total)
  hand_total > 21
end

def find_total_value(hand)
  all_cards = hand[:face_up_cards] + hand[:face_down_card]
  total_aces = all_cards.count('Ace')
  total_value = total_aces
  all_cards_except_aces = all_cards.reject { |card| card == 'Ace' }

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

def player_turn(deck, player_hand, dealer_hand)
  loop do
    announce_all_visible_cards(player_hand, dealer_hand)

    prompt "Would you like to (h)it or (s)tay?"
    answer = gets.chomp.downcase

    if answer == 'hit' || answer == 'h'
      hit!(deck, player_hand)
      player_total = find_total_value(player_hand)
      break if busted?(player_total)
    elsif answer == 'stay' || answer == 's'
      break
    else
      prompt "Sorry, that's not a valid answer."
    end
  end
end

def dealer_turn(deck, dealer_hand)
  sleep 1

  loop do
    if find_total_value(dealer_hand) < 17
      hit!(deck, dealer_hand)
      prompt "Dealer hits!"
      announce_visible_dealer_cards(dealer_hand)
      sleep 2
    else
      prompt "Dealer stays."
      sleep 1
      break
    end
  end
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp.downcase
  answer == 'y' || answer == 'yes'
end

# Actual game code below #
system 'clear'
prompt 'Welcome to the game of Twenty-one! Hit enter to start.'
gets

loop do # game loop
  # start game, initialize variables
  system 'clear'
  player_hand = {
    face_down_card: [],
    face_up_cards: []
  }
  dealer_hand = {
    face_down_card: [],
    face_up_cards: []
  }
  deck = ALL_CARDS.shuffle
  deal_starting_hands!(deck, player_hand, dealer_hand)

  # player turn
  player_turn(deck, player_hand, dealer_hand)
  player_total = find_total_value(player_hand)
  if busted?(player_total)
    end_of_round_output(player_hand, dealer_hand, player_total, dealer_total)
    play_again? ? next : break
  else
    prompt 'You chose to stay.'
  end

  # dealer turn
  dealer_turn(deck, dealer_hand)
  dealer_total = find_total_value(dealer_hand)
  if busted?(dealer_total)
    end_of_round_output(player_hand, dealer_hand, player_total, dealer_total)
    play_again? ? next : break
  end

  # compare hands to find winner if nobody busted
  end_of_round_output(player_hand, dealer_hand, player_total, dealer_total)
  break unless play_again?
end

# end of program message
prompt "That was fun, let's play again sometime!"
