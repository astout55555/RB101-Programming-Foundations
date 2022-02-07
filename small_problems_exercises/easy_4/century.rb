=begin

P:

input: number arg (year)
output: century formatted as string (number + 'st' or 'nd' or 'rd' or 'th')

E:

century(2000) == '20th'
century(2001) == '21st'
century(1965) == '20th'
century(256) == '3rd'
century(5) == '1st'
century(10103) == '102nd'
century(1052) == '11th'
century(1127) == '12th'
century(11201) == '113th'

D/A:

use float first to find value of century as a number (3 for 3rd century)
convert back to integer for other work
return result as a string

take number arg and float divide by 100, save as integer value
century is result rounded up (2001 is 21st).
convert century into string
use conditional flows to provide ending based on ending digits (from array of digits and from string)
return string with century and ending

=end

def century(year)
  century = ((year.to_f / 100).ceil).to_i
  century_string = century.to_s
  last_digit = century.digits.first

  case last_digit
  when 1 then century_ending = 'st'
  when 2 then century_ending = 'nd'
  when 3 then century_ending = 'rd'
  else century_ending = 'th'
  end

  if century_string.end_with?('11', '12', '13')
    century_ending = 'th'
  end

  century_string + century_ending
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'
p century(1984) == '20th'
# all print true
