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

def announce_visible_dealer_cards(dealer_hand)
  list_of_visible_dealer_cards = dealer_hand[:face_up_cards].join(', ')
  prompt "Dealer has: #{list_of_visible_dealer_cards} and one unknown card."
end

def announce_player_cards(player_hand)
  all_player_cards = player_hand[:face_down_card] + player_hand[:face_up_cards]
  list_of_player_cards = joinand(all_player_cards)

  prompt "You have: #{list_of_player_cards}."
end

def announce_all_visible_cards(player_hand, dealer_hand)
  announce_visible_dealer_cards(dealer_hand)
  announce_player_cards(player_hand)
end

def hit!(deck, hand)
  hand[:face_up_cards] << deck.shift
end

def busted?(hand)
  find_total_value(hand) > 21
end

def find_total_value(hand)
  all_cards = hand[:face_up_cards] + hand[:face_down_card]
  total_aces = all_cards.count('Ace')
  total_value = total_aces
  all_cards_except_aces = all_cards.reject { |card| card == 'Ace' }

  all_cards_except_aces.each do |card|
    total_value +=  if card.to_i == 0
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
      break if busted?(player_hand)
    elsif answer == 'stay' || answer == 's'
      break
    else
      prompt "Sorry, that's not a valid answer."
    end
  end
end

def dealer_turn(deck, dealer_hand)
  loop do
    if find_total_value(dealer_hand) < 17
      hit!(deck, dealer_hand)
      prompt "Dealer hits!"
      announce_visible_dealer_cards(dealer_hand)
    else
      prompt "Dealer stays."
      break
    end
  end
end

def reveal_hidden_card(dealer_hand)
  prompt "The dealer's face down card was: #{dealer_hand[:face_down_card][0]}!"
end

def tally_up_hands(player_hand, dealer_hand)
  prompt "Dealer's total hand value: #{find_total_value(dealer_hand)}."
  prompt "Your total hand value: #{find_total_value(player_hand)}."
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

loop do # main program loop
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

  loop do # single game loop
    deal_starting_hands!(deck, player_hand, dealer_hand)

    player_turn(deck, player_hand, dealer_hand)
    if busted?(player_hand)
      announce_player_cards(player_hand)
      prompt "Sorry, you busted!"
      break
    else
      prompt 'You chose to stay.'
    end

    dealer_turn(deck, dealer_hand)
    if busted?(dealer_hand)
      reveal_hidden_card(dealer_hand)
      prompt 'Dealer busted! You win!'
      break
    end

    # compare hands to find winner
    reveal_hidden_card(dealer_hand)
    tally_up_hands(player_hand, dealer_hand)
    if find_total_value(player_hand) < find_total_value(dealer_hand)
      prompt "Dealer wins!"
    elsif find_total_value(player_hand) > find_total_value(dealer_hand)
      prompt "You won! Congratulations!"
    else
      prompt "This game was a tie."
    end

    break
  end

  break unless play_again?
end

# end of program message
prompt "That was fun, let's play again sometime!"
