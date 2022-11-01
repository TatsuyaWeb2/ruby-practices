require 'date'
require 'optparse'

#今年の西暦を取得
this_year  = Date.today.year
this_month = Date.today.month
this_day   = Date.today.day

#今日の日付をtarget_dateに入力
target_date = {'year' => this_year, 'month' => this_month, 'day' => this_day}

#ユーザーからの入力を取得しtmp_dateに入力
tmp_date    = ARGV.getopts('', 'year:', 'month:', 'day:')

#もし、ユーザーからの入力があった際にはtarget_dateを更新
if tmp_date['year']
  target_date['year'] = tmp_date['year']
end

if tmp_date['month'] 
  target_date['month'] = tmp_date['month']
end

if tmp_date['day']
  target_date['day'] = tmp_date['day']
end


#月初と、月末日を取得
firstday = Date.new(target_date['year'].to_i, target_date['month'].to_i,  1)
lastday  = Date.new(target_date['year'].to_i, target_date['month'].to_i, -1)

m = target_date['month']
y = target_date['year']

#headerに月と年
header = m.to_s + "月 " + y.to_s + "年"
puts header.center(20)

# 日〜土をweekに入れて、表示させる。
week = %w(日 月 火 水 木 金 土)
puts week.join(" ")

# 初めの曜日まで空白を入れる。
print"   " * firstday.wday

while firstday.day != lastday.day
  if    firstday.wday == 0   #日曜日は何もしない
    nil
  elsif firstday.day == 1 #1日だけ、半角スペースを入れる。
    print(' ')
  elsif firstday.day <10  #10日未満は半角スペースを2つ入れる。
    print "  "
  else                    #10日以上は半角スペースを1つ入れる。
    print " "
  end

  print firstday.day

  #土曜日の場合には開業を入れる。
  if firstday.wday == 6
    print "\n"
    if firstday.day + 1 <10 #次の日付が、9以下なら、空白スペースを入れる
      print " "
    end
  end
  firstday += 1
end

print ("\n")

