FEET_TO_CENTIMETERS = 30.48

puts "Enter the length of the room in feet:"
length = gets.to_f

puts "Enter the width of the room in feet:"
width = gets.to_f

area_sqft = length * width
area_sqin = area_sqft * 12
area_sqcm = (length * FEET_TO_CENTIMETERS) * (width * FEET_TO_CENTIMETERS)

results_msg = <<MSG
The area of the room is:
#{format('%.2f', area_sqft)} square feet
or #{format('%.2f', area_sqin)} square inches
or #{format('%.2f', area_sqcm)} square centimeters. 
MSG

puts results_msg
