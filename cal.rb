# frozen_string_literal: true

# カレンダーの表示
# -m -y で日付と日にち指定
# 1970年から2100年まで

# カレンダープログラム
require 'date'
require 'optparse'

# 今日のデータ
today_year = Date.today.year
today_month = Date.today.month

# 入力するデータ
opt = OptionParser.new
opt.on('-y', '-m') { |val| }
opt.parse!(ARGV)
if ARGV == []
  year = today_year
  month = today_month
else
  year = ARGV[0].to_i
  month = ARGV[1].to_i
end
puts "#{month}月 #{year}".center(18)

# 曜日を表示
week = %w[日 月 火 水 木 金 土]
puts week.join(' ')

# 日付を表示
last_day = Date.new(year, month, -1).day
(1..last_day).to_a.each do |x|
  day = Date.new(year, month, x).wday
  first_day = '   ' * day if x == 1
  print first_day
  print x.to_s.rjust(2) + ' '
  print "\n" if day == 6
end
