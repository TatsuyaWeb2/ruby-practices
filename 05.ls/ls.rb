# frozen_string_literal: true

COLUMN = 3

target_path = ARGV[0]

if target_path == nil
  file_names = Dir.glob('*').sort
else
  file_names = Dir.glob(target_path + '/*').sort
  file_names = file_names.map{|x| x.sub(target_path + "/", '')}
end

def maximum_char(file_names)
  file_names.max.length
end

def output(file_names, columns, max)
  max_row = (file_names.size / columns.to_f).ceil
  file_names = file_names.each_slice(max_row).to_a
  (0..max_row - 1).each do |row|
    (0..file_names.length - 1).each do |columns| # (0..columns-1)にするとファイルが16個の場合、5列を表示できないため、file_name.lengthにしている。
      print file_names[columns][row].to_s.ljust(max) if file_names[columns][row]
    end
    print "\n"
  end
end

max = maximum_char(file_names) + 2

output(file_names, COLUMN, max)
