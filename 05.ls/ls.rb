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
end

existing_file    = []
existing_folders = []

if target_path.empty?
  file_names = Dir.glob('*').sort
  max = file_names.max_by(&:length).length + 3
  output(file_names, COLUMN, max)

else
  target_path.each do |path|
    if FileTest.file?(path)
      existing_file.push(path)
    elsif FileTest.directory?(path)
      existing_folders.push(path)
    else
      puts("ls: #{path}: No such file or directory")
    end
  end
end

if existing_file.length >= 1
  max = existing_file.max_by(&:length).length + 3
  output(existing_file, COLUMN, max)
  print("\n")
end

existing_folders.each do |path|
  puts "#{path}:" if existing_folders.length > 1
  existing_folders = Dir.glob("#{path}/*").sort.map { |x| x.sub("#{path}/", '') }
  max = existing_folders.max_by(&:length).length + 3
  output(existing_folders, COLUMN, max)
  print("\n")
end
