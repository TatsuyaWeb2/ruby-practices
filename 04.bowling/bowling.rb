# frozen_string_literal: true

throw_score = ARGV[0].split(',').map do |x|
  if x == 'X'
    10
  else
    x.to_i
  end
end

def ten_frame(*ten_throw)
  ten_throw.map(&:to_i).sum
end

total_score = []
throw_count = 0

9.times do |frame_count|
  if throw_score[throw_count] == 10
    total_score[frame_count] = if throw_score[throw_count + 1] == 10 && throw_score[throw_count + 2] == 10
                                 30
                               elsif throw_score[throw_count + 1] == 10
                                 20 + throw_score[throw_count + 2]
                               else
                                 10 + throw_score[throw_count + 1] + throw_score[throw_count + 2]
                               end
    throw_count += 1
  else
    total_score[frame_count] = throw_score[throw_count] + throw_score[throw_count + 1]
    throw_count += 2
  end

  total_score[frame_count] += throw_score[throw_count] if total_score[frame_count] == 10
end

total_score[9] = ten_frame(throw_score[throw_count], throw_score[throw_count + 1], throw_score[throw_count + 2])
puts total_score.sum
