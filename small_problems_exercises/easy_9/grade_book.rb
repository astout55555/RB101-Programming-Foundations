=begin

Problem:

input: 3 scores (integers 0-100)
output: the grade (string) associated with the average of the 3 scores

Algorithm:

add grades together, divide by 3 to get average (rounded down)
use case method to return grade letter based on average score

=end

def get_grade(score_one, score_two, score_three)
  average = (score_one + score_two + score_three) / 3

  case average
  when 90..100 then 'A'
  when 80...90 then 'B'
  when 70...80 then 'C'
  when 60...70 then 'D'
  else 'F'
  end
end

get_grade(95, 90, 93) == "A"
get_grade(50, 50, 95) == "D"
get_grade(100, 100, 100) == 'A'
get_grade(90, 90, 90) == 'A'
get_grade(0, 0, 0) == 'F'

## Further Exploration: what if extra credit meant the grade could be over 100?

def get_grade(score_one, score_two, score_three)
  average = (score_one + score_two + score_three) / 3

  case average
  when 80..89 then 'B' # changed ranges to be a bit more readable, like LS solution
  when 70..79 then 'C'
  when 60..69 then 'D'
  else
    if average >= 90
      'A'
    else
      'F'
    end
  end
end

get_grade(95, 90, 93) == "A"
get_grade(50, 50, 95) == "D"
get_grade(90, 90, 90) == 'A'
get_grade(0, 0, 0) == 'F'
get_grade(100, 110, 105) == 'A'
