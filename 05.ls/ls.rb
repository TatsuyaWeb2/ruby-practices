# frozen_string_literal: true

columns = 3

file_name = Dir.glob('*').sort

# filenameの長さを見るメソッド
def maximum_char(file_name)
  max_char = 0
  file_name.each do |name|
    max_char = name.length if name.length > max_char
  end
  max_char
end

# 順番に出力するメソッド
def output(file_name, columns, max)
  max_row = (file_name.size / columns.to_f).ceil
  file_name = file_name.each_slice(max_row).to_a
  (0..max_row - 1).each do |row|
    (0..file_name.length - 1).each do |column| # (0..columns-1)にするとファイルが16個の場合、5列を表示できないため、file_name.lengthにしている。
      print file_name[column][row].to_s.ljust(max) if file_name[column][row]
    end
    print "\n"
  end
end

max = maximum_char(file_name) + 2

output(file_name, columns, max)
