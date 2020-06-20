# frozen_string_literal: true
require 'optparse'

=begin
入力
ファイルの情報
変換
行数・空白で区切られた単語数・ファイルの容量(バイト数)
=end
files = Dir.entries('.').sort
files.each {|n|
  file = File::Stat.new(n)
  files.size
}

