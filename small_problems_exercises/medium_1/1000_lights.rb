=begin

Problem:

given n, start with n switches for lights all in the off position to start
from 1 to n, iterate through switches and swap position of every switch which is a multiple of i,
  where i is the current number (1 to n)

input: n
output: array of all lights which are on at the end of this sequence

Examples:

mess_with_the_lights(5) == [1, 4]
mess_with_the_lights(10) == [1, 4, 9]

Algorithm:

(high level)
1. generate hash using keys 1 to n and values of false (false => off; true => on)
2. from 1 to n, iterate through hash and change value to opposite boolean if key is multiple of i
3. return all keys with value of true

1. generate hash:
create array from range 1..n
map this array onto a new array where each element is now a sub array of the number and the boolean false
convert this new array into a hash, store in var

2. flip lights:
from 1 upto n
  select all light keys that are multiples of i, store in temp var
  iterate through lights hash, changing boolean value to opposite if key is found in this temp list

3. return array:
select all key/value pairs with value of true
return the array of these keys

=end

def mess_with_the_lights(int)
  all_lights = (1..int).to_a.map { |i| [i, false] }.to_h

  1.upto(int) do |i|
    to_flip = all_lights.keys.select { |x| (x % i).zero? }
    all_lights.each do |light, status|
      if to_flip.include?(light)
        all_lights[light] = !status
      end
    end
  end

  all_lights.select { |_, v| v == true }.keys
end

mess_with_the_lights(5) == [1, 4]
mess_with_the_lights(10) == [1, 4, 9]
p mess_with_the_lights(1000)

# LS Solution (uses helper methods so the code is more legible, which is a good practice even if mine isn't too complex for rubocop)

# initialize the lights hash
def initialize_lights(number_of_lights)
  lights = Hash.new
  1.upto(number_of_lights) { |number| lights[number] = "off" }
  lights
end

# return list of light numbers that are on
def on_lights(lights)
  lights.select { |_position, state| state == "on" }.keys
end

# toggle every nth light in lights hash
def toggle_every_nth_light(lights, nth)
  lights.each do |position, state|
    if position % nth == 0
      lights[position] = (state == "off") ? "on" : "off"
    end
  end
end

# Run entire program for number of lights
def toggle_lights(number_of_lights)
  lights = initialize_lights(number_of_lights)
  1.upto(lights.size) do |iteration_number|
    toggle_every_nth_light(lights, iteration_number)
  end

  on_lights(lights)
end

## Further Exploration

# 1. Every value is a perfect square...honestly not sure why that is, not sure I know enough about math to figure that out right now.

# 2. Alternatives? What if we used an array instead of a hash? -- I rewrote my algorithm because it was annoyingly complicated. Best to use a hash if we want info associated in pairs like this.

# 3. How would we write the code for a method that output the results in a description of lights that are on and lights that are off?
  # -- This would be easier if I break this down using helper methods. I'd need to get two return values, arrays of on or off lights, and then work those into interpolated strings.
    # ---E.g. If I wanted to use the return value of the 'on' keys to find the off keys, I'd need to access the hash again, recreate it, or compare it against a newly created array of all lights. 
  # -- I'd need to use something like the #joinor method from earlier in RB101 to handle the final light in the list.
