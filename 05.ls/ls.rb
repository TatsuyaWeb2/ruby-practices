# frozen_string_literal: true

COLUMN = 3

target_path = ARGV.sort

def output(file_names, column, max)
  max_row = (file_names.size / column.to_f).ceil
  file_names = file_names.each_slice(max_row).to_a
  (0..max_row - 1).each do |row|
    (0..file_names.length - 1).each do |target_column| # (0..column-1)にするとファイルが16個の場合、5列を表示できないため、file_names.lengthにしている。
      print file_names[target_column][row].to_s.ljust(max) if file_names[target_column][row]
    end
    print "\n"
  end
  print "\n"
end

def no_name(target_path)
  truth_paths = []
  target_path.each do |path|
    if FileTest.exist?(path)
      truth_paths.push(path)
    else
      puts("ls: #{path}: No such file or directory")
    end
  end
  truth_paths
end

if target_path.empty?
  file_names = Dir.glob('*').sort
  max = file_names.max_by(&:length)
  output(file_names, COLUMN, max)
else
  truth_paths = no_name(target_path)
end

truth_paths.each do |path|
  if target_path.length > 1
    if FileTest.directory?(path)
      puts "#{path}:"
    elsif FileTest.file?(path)
      put path
    end
  end
  file_names = Dir.glob("#{path}/*").sort.map { |x| x.sub("#{path}/", '') }
  max = file_names.max_by(&:length).length + 3
  output(file_names, COLUMN, max)
end
