ALL_CARDS = [
  ['2', 2], ['3', 3], ['4', 4],
  ['5', 5], ['6', 6], ['7', 7],
  ['8', 8], ['9', 9], ['10', 10],
  ['Jack', 10], ['Queen', 10], ['King', 10],
  ['Ace', 11] # Aces may be worth 1 instead to prevent busting
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
  names = hand.map { |card| card[0] }

  if hand.size > 2
    final_card = names.last
    mostly_joined = names[(0..(names.size - 2))].join(separator_string)
    "#{mostly_joined}#{separator_string}#{final_separator} #{final_card}"
  else
    names.join(" #{final_separator} ")
  end
end

def announce_visible_dealer_cards(dealer_hand)
  card_names = dealer_hand.map { |card| card[0] }
  visible_dealer_cards = card_names[(1..card_names.size)].join(', ')
  prompt "Dealer has: #{visible_dealer_cards} and one unknown card."
end

def show_available_info(game_data)
  prompt "The game is: '#{game_data[:game_name_limit]}'"
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
  puts '-----------------------------'

  case detect_result(game_data)
  when :p_busted then prompt "You busted! Dealer wins!"
  when :d_busted then prompt "Dealer busted! You win!"
  when :d_wins then prompt "Dealer wins!"
  when :p_wins then prompt "You win! Congratulations!"
  when :tie then prompt "This game is a tie, so the house takes the pot!"
  end

  puts '-----------------------------'
  prompt "Player stash: #{game_data[:player][:stash]}."
  prompt "Dealer stash: #{game_data[:dealer][:stash]}."
end

def rearrange_dealer_hand!(game_data)
  face_down_card = game_data[:dealer][:hand].shift
  list_cards((game_data[:dealer][:hand] + [face_down_card]))
end

def end_of_round_output(game_data)
  sleep 2
  d_list = rearrange_dealer_hand!(game_data)
  p_list = list_cards(game_data[:player][:hand])

  system 'clear'
  puts "==========================="
  prompt "The name of the game is '#{game_data[:game_name_limit]}'"
  prompt "Dealer has #{d_list}, a total of #{game_data[:dealer][:total]}."
  prompt "You have #{p_list}, a total of #{game_data[:player][:total]}."
  display_result(game_data)
  puts "==========================="
end

def detect_match_result(game_data)
  if game_data[:player][:stash] <= 0
    :player_broke
  elsif game_data[:dealer][:stash] <= 0
    :dealer_broke
  elsif game_data[:player][:stash] > game_data[:dealer][:stash]
    :player_gained
  elsif game_data[:player][:stash] < game_data[:dealer][:stash]
    :dealer_gained
  else
    :stashes_even
  end
end

def end_of_match_output(game_data)
  case detect_match_result(game_data)
  when :player_broke
    prompt "BAM! Come back next time your wallet's weighing you down!"
  when :dealer_broke
    prompt "HOO BOY...time to see if I've got any more internal organs to sell."
  when :player_gained
    prompt "I'm having fun but I better stop before I go broke!"
  when :dealer_gained
    prompt "As much as I love robbing you I better leave you with some dignity."
  else
    prompt "That was a lot of fun! How 'bout we end on a high note?"
  end

  prompt "Let's play again sometime!"
end

def busted?(game_data, hand_total)
  hand_total > game_data[:game_name_limit]
end

def update_total!(game_data, p_or_d)
  total_aces = p_or_d[:hand].count(['Ace', 11])
  total_value = p_or_d[:hand].map { |card| card[1] }.sum

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

def place_bet!(game_data)
  lower_stash = find_lower_stash(game_data)
  bet = 0
  puts '-----------------------'
  prompt "Your stash: #{game_data[:player][:stash]} smackums."
  prompt "Dealer's stash: #{game_data[:dealer][:stash]} smackums."
  puts '-----------------------'

  loop do
    prompt "Place your bet, up to #{lower_stash}."
    bet = gets.chomp.to_i
    break if bet > 0 && bet <= lower_stash
    prompt "The bet has to be between 0 and the smaller of our two stashes."
  end

  game_data[:current_bet] = bet
end

def fill_pot!(game_data)
  game_data[:player][:stash] -= game_data[:current_bet]
  game_data[:dealer][:stash] -= game_data[:current_bet]
  game_data[:pot] += (game_data[:current_bet] * 2)

  puts "-----------------------"
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
  prompt "HELLO. I AM THE GREAT WILL OF THE MACROCOSM."
  prompt "IF YOU LIKE, I CAN RESET EVERYTHING TO HOW IT WAS."
  prompt "WOULD YOU LIKE ME TO UNDO THESE EVENTS? (Y OR N)"
  answer = gets.chomp.upcase
  answer == 'Y' || answer == 'YES'
end

def start_game!(game_data)
  system 'clear'

  game_data[:player][:hand] = []
  game_data[:dealer][:hand] = []
  game_data[:deck] = (ALL_CARDS * 4).shuffle

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
    pot: 0,
    current_bet: 0
  }

  round = 0

  name_the_game!(game_data) # changes name and rules of game accordingly
  prompt "That was it! Right, the game of #{game_data[:game_name_limit]}!"
  prompt "...I think I'm good at this...? Let's play!"
  prompt "We'll go for 5 rounds, or until one of us is broke!"

  while round < 5 # game loop (5 rounds max)
    round += 1
    prompt "Hit enter when you're ready to start round #{round}."
    gets

    # set up and place bets
    start_game!(game_data)
    game_data[:pot] = 0
    update_total!(game_data, game_data[:player])
    show_available_info(game_data)
    place_bet!(game_data)
    fill_pot!(game_data)

    # player turn and consequences for busting
    player_turn(game_data)
    if busted?(game_data, game_data[:player][:total])
      game_data[:dealer][:stash] += game_data[:pot]
      update_total!(game_data, game_data[:dealer])
      end_of_round_output(game_data)
      game_data[:player][:stash] <= 0 ? break : next
    else
      prompt 'You chose to stay.'
    end

    # dealer turn and consequences for busting
    dealer_turn(game_data)
    if busted?(game_data, game_data[:dealer][:total])
      game_data[:player][:stash] += game_data[:pot]
      end_of_round_output(game_data)
      game_data[:dealer][:stash] <= 0 ? break : next
    end

    # if nobody busted, compare hands and reward winner
    if detect_result(game_data) == :p_wins
      game_data[:player][:stash] += game_data[:pot]
    else
      game_data[:dealer][:stash] += game_data[:pot]
    end
    end_of_round_output(game_data)
    break if (game_data[:player][:stash] <= 0) ||
             (game_data[:dealer][:stash] <= 0)
  end

  end_of_match_output(game_data)
  break unless undo_match?
end

puts "~~~That's all folks!~~~"
