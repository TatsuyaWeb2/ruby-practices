require 'date'
require 'optparse'
require 'debug'

#今年の西暦を取得
today = Date.today
target_date = {year: today.year, month: today.month, day: today.day}

#ユーザーからの入力を取得しoptionsに入力
options    = ARGV.getopts('', 'year:', 'month:')

#もし、ユーザーからの入力があった際にはtarget_dateを更新
if options['year']
  target_date[:year]   = options['year'].to_i
end

if options['month'] 
  target_date[:month]  = options['month'].to_i
end

#月初と、月末日を取得
firstday = Date.new(target_date[:year], target_date[:month],  1)
lastday  = Date.new(target_date[:year], target_date[:month], -1)

m = target_date[:month]
y = target_date[:year]

#headerに月と年
header = m.to_s + "月 " + y.to_s + "年"
puts header.center(20)

# 日〜土をweekに入れて、表示させる。
week = %w(日 月 火 水 木 金 土)
puts week.join(" ")

# 初めの曜日まで空白を入れる。
print "   " * firstday.wday


(firstday..lastday).each do |date|
  day = date.day.to_s.rjust(2)

  #土曜日の場合には改行を入れる。
  if date.saturday?
    print day + "\n"
  else
    print day + " "
  end
end

print ("\n")