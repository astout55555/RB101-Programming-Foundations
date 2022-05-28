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

def show_available_info(game_data)
  prompt "The game is: '#{game_data[:game_name_limit]}'"
  prompt "Your stash: #{game_data[:player][:stash]} smackums."
  prompt "Dealer's stash: #{game_data[:dealer][:stash]} smackums."
  announce_visible_dealer_cards(game_data[:dealer][:hand])
  prompt "You have: #{list_cards(game_data[:player][:hand])}."
  prompt "Your current total is: #{game_data[:player][:total]}."
end

def detect_result(game_data)
  if busted?(game_data, game_data[:player][:total])
    :p_busted
  elsif busted?(game_data, game_data[:dealer][:total])
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
  prompt "The pot had a total of #{game_data[:pot]} smackums."

  case detect_result(game_data)
  when :p_busted then prompt "You busted! Dealer wins!"
  when :d_busted then prompt "Dealer busted! You win!"
  when :d_wins then prompt "Dealer wins!"
  when :p_wins then prompt "You win! Congratulations!"
  when :tie then prompt "This game is a tie, so the house takes the pot!"
  end

  prompt "Player stash: #{game_data[:player][:stash]}."
  prompt "Dealer stash: #{game_data[:dealer][:stash]}."
end

def rearrange_dealer_hand!(game_data)
  face_down_card = game_data[:dealer][:hand].shift
  list_cards((game_data[:dealer][:hand] + [face_down_card]))
end

def end_of_round_output(game_data)
  d_list = rearrange_dealer_hand!(game_data)
  p_list = list_cards(game_data[:player][:hand])

  puts "=============="
  prompt "It is time to see who won the game of #{game_data[:game_name_limit]}."
  prompt "Dealer has #{d_list}, a total of #{game_data[:dealer][:total]}."
  prompt "You have #{p_list}, a total of #{game_data[:player][:total]}."
  puts "=============="

  sleep 2
  display_result(game_data)
end

def busted?(game_data, hand_total)
  hand_total > game_data[:game_name_limit]
end

def update_total!(game_data, p_or_d)
  total_aces = p_or_d[:hand].count('Ace')
  total_value = total_aces * 11
  all_cards_except_aces = p_or_d[:hand].reject { |card| card == 'Ace' }

  all_cards_except_aces.each do |card|
    total_value += if card.to_i == 0
                     10
                   else
                     card.to_i
                   end
  end

  while (total_value > game_data[:game_name_limit]) && (total_aces > 0)
    total_value -= 10
    total_aces -= 1
  end

  p_or_d[:total] = total_value
end

def hit!(game_data, p_or_d)
  p_or_d[:hand] << game_data[:deck].shift
end

def find_lower_stash(game_data)
  if game_data[:player][:stash] < game_data[:dealer][:stash]
    game_data[:player][:stash]
  else
    game_data[:dealer][:stash]
  end
end

def place_bets!(game_data)
  bet = 0
  lower_stash = find_lower_stash(game_data)

  loop do
    prompt "Place your bet, up to #{lower_stash}."
    bet = gets.chomp.to_i
    break if bet > 0 && bet <= lower_stash
    prompt "The bet has to be between 0 and the smaller of our two stashes."
  end

  game_data[:player][:stash] -= bet
  game_data[:dealer][:stash] -= bet
  game_data[:pot] += (bet * 2)

  puts "========================"
  prompt "The pot has a total of #{game_data[:pot]} smackums."
end

def player_turn(game_data)
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    answer = gets.chomp.downcase

    if answer == 'hit' || answer == 'h'
      hit!(game_data, game_data[:player])
      update_total!(game_data, game_data[:player])
      break if busted?(game_data, game_data[:player][:total])
      show_available_info(game_data)
    elsif answer == 'stay' || answer == 's'
      break
    else
      prompt "It's one or the other, bub."
    end
  end
end

def dealer_turn(game_data)
  loop do
    update_total!(game_data, game_data[:dealer])
    sleep 1

    if game_data[:dealer][:total] < game_data[:dealer_stays_at]
      prompt "[Dealer hits!]"
      hit!(game_data, game_data[:dealer])
      announce_visible_dealer_cards(game_data[:dealer][:hand])
    else
      prompt "[Dealer stays.]"
      break
    end
  end
end

def undo_match?
  puts "~~~~~~~~#############################~~~~~~~~"
  prompt "Hello. I am the great will of the macrocosm."
  prompt "If you like, I can reset everything to how it was."
  prompt "Would you like me to undo these events? (y or n)"
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

def set_game_parameters!(game_data, player_answer)
  case player_answer
  when '21'
    game_data[:game_name_limit] = 21
    game_data[:dealer_stays_at] = 17
  when '31'
    game_data[:game_name_limit] = 31
    game_data[:dealer_stays_at] = 27
  when '41'
    game_data[:game_name_limit] = 41
    game_data[:dealer_stays_at] = 37
  when '51'
    game_data[:game_name_limit] = 51
    game_data[:dealer_stays_at] = 47
  end
end

def name_the_game!(game_data)
  answer = ''

  loop do
    prompt "Can you remind me what the name of the game is? Something-one?"
    puts '---------------------------------------------------------------'
    puts "[What do you tell them?]"
    puts "[Try 21...or 31, 41, or even 51 if you want to mess with them!]"

    answer = gets.chomp
    break if ['21', '31', '41', '51'].include?(answer)
    prompt "Hey, don't try to pull a fast one on me. That's not it!"
  end

  set_game_parameters!(game_data, answer)
end

# Actual game code below #

system 'clear'
prompt 'Welcome to the game of...uhh...umm...'

loop do # main program loop
  # initialize or reinitialize empty game_data hash
  game_data = {
    player: {
      hand: [],
      total: 0,
      stash: 100
    },
    dealer: {
      hand: [],
      total: 0,
      stash: 100
    },
    deck: [],
    game_name_limit: 21,
    dealer_stays_at: 17,
    pot: 0
  }

  round = 0

  name_the_game!(game_data)
  prompt "That was it! Right, the game of #{game_data[:game_name_limit]}!"
  prompt "I think I was pretty good at this...? Let's play!"

  while round < 5 # game loop (5 rounds max)
    round += 1
    prompt "Say something when you're ready to start round #{round}."
    gets

    # set up and place bets
    start_game!(game_data)
    game_data[:pot] = 0
    update_total!(game_data, game_data[:player])
    show_available_info(game_data)
    place_bets!(game_data)

    # player turn
    player_turn(game_data)
    if busted?(game_data, game_data[:player][:total])
      game_data[:dealer][:stash] += game_data[:pot]
      update_total!(game_data, game_data[:dealer])
      end_of_round_output(game_data)
      game_data[:player][:stash] <= 0 ? break : next
    else
      prompt 'You chose to stay.'
    end

    # dealer turn
    dealer_turn(game_data)
    if busted?(game_data, game_data[:dealer][:total])
      game_data[:player][:stash] += game_data[:pot]
      end_of_round_output(game_data)
      game_data[:dealer][:stash] <= 0 ? break : next
    end

    # compare hands to find winner if nobody busted
    if detect_result(game_data) == :p_wins
      game_data[:player][:stash] += game_data[:pot]
    else
      game_data[:dealer][:stash] += game_data[:pot]
    end
    end_of_round_output(game_data)
    break if (game_data[:player][:stash] <= 0) ||
             (game_data[:dealer][:stash] <= 0)
  end

  if game_data[:player][:stash] <= 0
    prompt "Come play with me again next time your wallet's weighing you down!"
  elsif game_data[:dealer][:stash] <= 0
    prompt "HOO BOY...time to see if I've got any more internal organs to sell."
  else
    prompt "Hey that was a good time, but it's probably best we end here."
    prompt "Let's play again sometime!"
  end

  break unless undo_match?
end

prompt "That's all folks!"
