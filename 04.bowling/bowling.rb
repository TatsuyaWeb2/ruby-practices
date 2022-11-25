# frozen_string_literal: true

throw_score = ARGV[0].split(',')
total_score = []

def ten_frame(*ten_throw)
  score = ten_throw.sum {|x| 
            if x == "X"
              x = 10
            else
              x.to_i
            end
          }  
  score
end

throw_count = 0

9.times do |frame_count|
  if throw_score[throw_count] == 'X'
    total_score[frame_count] = if throw_score[throw_count + 1] == 'X' && throw_score[throw_count + 2] == 'X'
                                30
                              elsif throw_score[throw_count + 1] == 'X'
                                20 + throw_score[throw_count + 2].to_i
                              else
                                10 + throw_score[throw_count + 1].to_i + throw_score[throw_count + 2].to_i
                              end
    throw_count += 1
  else
    total_score[frame_count] = throw_score[throw_count].to_i + throw_score[throw_count + 1].to_i
    throw_count += 2
  end

  if total_score[frame_count] == 10
    total_score[frame_count] += if throw_score[throw_count] == 'X'
                                  10
                                else
                                  throw_score[throw_count].to_i
                                end
  end
end

total_score[9] = ten_frame(throw_score[throw_count],throw_score[throw_count + 1],throw_score[throw_count + 2])
puts total_score.sum
