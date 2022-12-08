# frozen_string_literal: true

COLUMN = 4

target_path = ARGV

def output(file_names, column, max)
  max_row = (file_names.size / column.to_f).ceil
  file_names = file_names.each_slice(max_row).to_a
  (0..max_row - 1).each do |row|
    (0..file_names.length - 1).each do |target_column| # (0..column-1)にするとファイルが16個の場合、5列を表示できないため、file_names.lengthにしている。
      print file_names[target_column][row].to_s.ljust(max) if file_names[target_column][row]
      # binding.break
    end
    print "\n"
  end
end

if target_path.empty?
  file_names = Dir.glob('*').sort
  max = file_names.max.length + 2
  output(file_names, COLUMN, max)

else
  target_path.map do |path|
    if FileTest.directory?(path)
      puts "#{path}:"
    elsif FileTest.file?(path)
      puts path
    else
      print("ls: #{path}: No such file or directory")
    end

    file_names = Dir.glob("#{path}/*").sort.map { |x| x.sub("#{path}/", '') }
    if file_names.empty?
      print ''
    else
      max = file_names.max.length + 2
      output(file_names, COLUMN, max)
    end
  end
end
