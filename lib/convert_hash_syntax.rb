# frozen_string_literal: true

# def convert_hash_syntax(old_syntax)
#   old_syntax.gsub(/:(\w+) *=> */,'\1:')
# end =end
#
# 「%記法(%r)」
# %r!http://example\.com!#!ではなく{}を区切り文字にする%r{http://example\.com}
#
# =begin
# vs code
# 複数行一括コメントアウト
# ［Shift］＋［Option］＋［A］
# 一行だけ

# ［command］＋［k］＋［c］

month_table = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# うるう年か？
is_uruu = lambda { |year|
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
}

# 西暦1年1月1日から何日目か（すべてグレゴリオ暦で計算）
days = lambda { |year, month, day|
  uruu = lambda { |y|
    y / 4 - y / 100 + y / 400
  }
  month_days = lambda {
    month_table[0, month].inject(&:+) + (is_uruu.call(year) && month > 2 ? 1 : 0)
  }
  y1 = year - 1
  y1 * 365 + uruu.call(y1) + month_days.call + day - 1
}

# 曜日の計算
week_number = lambda { |year, month, day|
  (days.call(year, month, day) + 1) % 7
}

# カレンダーの出力
Calender = lambda { |year, month|
  gen = lambda { |from, to|
    (from..to).map { |i| format('%2d  ', i) }.join
  }
  putout = lambda { |i|
    last = month_table[month]
    last += 1 if is_uruu.call(year) && month == 2
    while i + 6 <= last
      puts gen.call(i, i + 6)
      i += 7
    end
    st = gen.call(i, last)
    puts st unless st.empty?
  }
  puts "#{year}/#{month}".center(27)
  puts 'sun mon tue wed thu fri sat'
  w = week_number.call(year, month, 1)
  puts '    ' * w + gen.call(1, 7 - w)
  putout.call(8 - w)
}
