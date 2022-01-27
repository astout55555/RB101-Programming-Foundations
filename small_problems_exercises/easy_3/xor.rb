=begin

PEDAC

Problem:

create 'exclusive or' method
input: any two args/operands
output: true if only one operand is truthy; else false

Examples:

xor?(5.even?, 4.even?) == true
xor?(5.odd?, 4.odd?) == true
xor?(5.odd?, 4.even?) == false
xor?(5.even?, 4.odd?) == false

Data / Algorithm:

use conditional flows
&& must return false
|| must return true
xor? returns true if both conditions met, else false

Coding:
=end

def xor?(arg1, arg2)
  if arg1 && arg2
    return false
  elsif !(arg1 || arg2)
    return false
  else
    return true
  end
end

# these all print true
p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false
