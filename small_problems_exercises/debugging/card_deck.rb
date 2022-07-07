# Original Code: raises a TypeError

# cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

# deck = { :hearts   => cards,
#          :diamonds => cards,
#          :clubs    => cards,
#          :spades   => cards }

# def score(card)
#   case card
#   when :ace   then 11
#   when :king  then 10
#   when :queen then 10
#   when :jack  then 10
#   else card
#   end
# end

# # Pick one random card per suit

# player_cards = []
# deck.keys.each do |suit|
#   cards = deck[suit]
#   cards.shuffle!
#   player_cards << cards.pop
# end

# # Determine the score of the remaining cards in the deck

# sum = deck.reduce(0) do |sum, (_, remaining_cards)|
#   remaining_cards.map do |card| # maps the cards onto a new array as the card values instead of names
#     score(card)
#   end

#   sum += remaining_cards.sum # raises an error because the `remaining_cards` array wasn't mutated, still contains symbols
# end

# puts sum

# Debugged Code (part 1): no longer raises an error--but why is the sum too low?

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

deck = { :hearts   => cards, # this is putting the same object in 4 new locations
         :diamonds => cards, # this leads to problems down the line, because we end up
         :clubs    => cards, # mutating the cards array, and therefore mutating all 4
         :spades   => cards } # of these sets of cards simultaneously

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit

player_cards = []
deck.keys.each do |suit|
  cards = deck[suit] # this assigns the prexisting cards array to itself
  cards.shuffle! # this therefore shuffles the original array of all card types
  player_cards << cards.pop # this removes a card from the original cards array
end # by the end of this, all four suits have identical sets of the remaining 9 cards

# Determine the score of the remaining cards in the deck

sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  remaining_cards.map! do |card| # there are only 36 remaining cards, but should be 48
    score(card)
  end

  sum += remaining_cards.sum
end

puts sum

# Debugged Code (part 2): Now the code functions properly and gives the correct sum too

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

deck = { :hearts   => cards.dup, # I copy the array values into this hash instead of
         :diamonds => cards.dup, # directly putting the same reference to the same object
         :clubs    => cards.dup, # in these four additional spots. this way I can
         :spades   => cards.dup } # manipulate the values in deck without mutating `cards`

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit

player_cards = []
deck.keys.each do |suit|
  suit_cards = deck[suit] # I also use a new name for this variable to avoid mutating `cards`
  suit_cards.shuffle! # it's not necessary, but it could avoid additional complications later
  player_cards << suit_cards.pop
end

# Determine the score of the remaining cards in the deck

sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  remaining_cards.map! do |card|
    score(card)
  end

  sum += remaining_cards.sum
end

puts sum

# debugging line to demonstrate that there are 12 cards left per suit
p deck # also shows that the cards remaining are not the same for each suit
