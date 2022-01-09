def count_occurrences(array)
  unique_elements = array.uniq
  unique_elements.each { |element| puts "#{element} => #{array.count(element)}" }
end

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck', 'suv', # added the lowercase 'suv' to test final method
  'motorcycle', 'motorcycle', 'car', 'truck'
]

count_occurrences(vehicles)

# the above works, but starting to look at the solution I realize the output was supposed to be a hash

def count_occurrences_alt(array)
  occurrences = {} # sets up an empty hash

  array.uniq.each do |element| # this part is similar to my solution, but is creating key: value pairs
    occurrences[element] = array.count(element)
  end

  occurrences.each do |element, count| # iterates over the hash, printing each key: value pair
    puts "#{element} => #{count}"
  end
end

count_occurrences_alt(vehicles)

# Further Exploration: Solve the problem while treating words as case insensitive.

def count_occurrences_case_insensitive(array)
  occurrences = {} 

  downcased_array = array.map(&:downcase)

  downcased_array.uniq.each do |element| 
    occurrences[element] = downcased_array.count(element)
  end

  occurrences.each do |element, count|
    puts "#{element} => #{count}"
  end
end

count_occurrences_case_insensitive(vehicles)