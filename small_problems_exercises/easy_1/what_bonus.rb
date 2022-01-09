def calculate_bonus(salary, bonus_awarded)
  if bonus_awarded
    bonus = salary/2
  else
    bonus = 0
  end
end # or more simply, use the ternary operator => bonus_awarded ? (salary/2) : 0

# tests to print true
puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000