=begin

# Problem:
create a method that takes a float (representing the degree of an angle) and
returns a string that represents it in degrees, minutes, and seconds, with
appropriate symbols for each. use leading 0s for single-digit minutes and
seconds.

input: float (between 0 and 360)
output: string formatted as `%(0.00'00")` except use the degree symbol
  instead of the `.`, which you can represent using this constant:
  DEGREE = "\xC2\xB0"

# Algorithm:

find and store degrees, minutes, and seconds, in variables
  divide float into degrees and remainder
  multiply remainder by 3600 to get total seconds
  divmod by 60 to separate minutes and seconds
format results into string using concatentation

=end

DEGREE = "\xC2\xB0"

def dms(degrees_float)
  degrees, fraction = degrees_float.divmod(1)
  degrees = degrees % 360 # added line to solve further exploration challenge
  fraction_in_seconds = (fraction * 3600).round
  minutes, seconds = fraction_in_seconds.divmod(60)

  formatted_degrees = degrees.to_s + DEGREE
  formatted_minutes = minutes.to_s.rjust(2, '0') + "'"
  formatted_seconds = seconds.to_s.rjust(2, '0') + '"'
  
  formatted_degrees + formatted_minutes + formatted_seconds
end

# Official solution shows how to use #format to format entire result in 1 line:
# format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds)

p dms(30) == %(30°00'00")
p dms(76.73) == %(76°43'48")
p dms(254.6) == %(254°36'00")
p dms(93.034773) == %(93°02'05")
p dms(0) == %(0°00'00")
p dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

## Further Exploration: accounting for negative and greater than 360 degrees
p dms(400) == %(40°00'00")
p dms(-40) == %(320°00'00")
p dms(-420) == %(300°00'00")
