# frozen_string_literal: true

throw = ARGV[0].split(',')
current_num = 0
total_score = []

def ten_frame(*ten_throw)
  score = 0
  i = 0
  while ten_throw[i] do
    if ten_throw[i] == 'X'
      score += 10
    else
      score += ten_throw[i].to_i
    end
    i = i.next
  end
  score
end

9.times do |frame_count|
  if throw[current_num] == 'X'
    total_score[frame_count] = if throw[current_num + 1] == 'X' && throw[current_num + 2] == 'X'
                                30
                              elsif throw[current_num + 1] == 'X'
                                20 + throw[current_num + 2].to_i
                              else
                                10 + throw[current_num + 1].to_i + throw[current_num + 2].to_i
                              end
    current_num += 1
  else
    total_score[frame_count] = throw[current_num].to_i + throw[current_num + 1].to_i
    current_num += 2
  end

  if total_score[frame_count] == 10
    total_score[frame_count] += if throw[current_num] == 'X'
                                  10
                                else
                                  throw[current_num].to_i
                                end
  end
end

total_score[9] = ten_frame(throw[current_num],throw[current_num + 1],throw[current_num + 2])
puts total_score.sum
