=begin

input: array of integers between 0-19
output: array of integers sorted alphabetically (based on English word for each number)

create constant, a hash, each number paired with English word

iterate through numeric array, mapping onto the word version of each number
sort transformed array
map back onto integers
output final array

=end

ENGLISH_WORDS_FOR_NUMBERS = {
  zero: 0, one: 1, two: 2, three: 3, four: 4, five: 5,
  six: 6, seven: 7, eight: 8, nine: 9, ten: 10,
  eleven: 11, twelve: 12, thirteen: 13, fourteen: 14, fifteen: 15,
  sixteen: 16, seventeen: 17, eighteen: 18, nineteen: 19
}

def alphabetic_number_sort(array_of_integers_0_through_19)
  word_array = array_of_integers_0_through_19.map do |integer|
    ENGLISH_WORDS_FOR_NUMBERS.key(integer)
  end
  word_array.sort.map do |word|
    ENGLISH_WORDS_FOR_NUMBERS[word]
  end
end

alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]

# Official Solution:

NUMBER_WORDS = %w(zero one two three four
                  five six seven eight nine
                  ten eleven twelve thirteen fourteen
                  fifteen sixteen seventeen eighteen nineteen)

def alphabetic_number_sort(numbers)
  numbers.sort_by { |number| NUMBER_WORDS[number] }
end

## Further Exploration

# Challenge was to use #sort instead of #sort_by, but I already did that above. Definitely less efficient, though.

# Used Enumerable#sort_by instead of Array#sort_by! because we don't want to mutate the original array, just return a sorted copy.
