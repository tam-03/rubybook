# frozen_string_literal: true

require 'optparse'

# 入力
# ファイルの情報
# 変換
# 行数・空白で区切られた単語数・ファイルの容量(バイト数)
files = Dir.entries('.').sort
files.each do |n|
  file = File::Stat.new(n)
  files.size
end
