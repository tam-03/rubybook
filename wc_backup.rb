# frozen_string_literal: true

require 'optparse'

# 入力
# ファイルの情報
# 変換
# 行数・空白で区切られた単語数・ファイルの容量(バイト数)


class WcCommand
  def standard_input_or_file?
    StandardInput.new if ARGV[0].nil? == true
    InputtedFile.new if ARGV[0].nil? == false
  end
end

class StandardInput
  def initialize
    @standard_input = $stdin.read#.map {|r| r.split(/\s/) }
  end
  def generate_number_of_lines
    @standard_input.size
  end
  def generate_word_count
    @standard_input.split(/\R/)
    b = @standard_input.gsub(/\n/, ' ')
    p b.split(" ").size
    aaa = []
    a.each_line {|f|
      aaa << f
    }
    p aaa.size
    #標準入力の行数
  end
  def byte_size
    @standard_input.bytesize
  end
end

#WcCommand.new.standard_input_or_file?

class InputtedFile
  def initialize
    @inputted_file = ARGV[0]
  end
  def generate_number_of_lines
    open(@inputted_file){|f|
      while f.gets; end
      f.lineno
    }#行数
  end
  def generate_word_count
    file = open(@inputted_file).read
    s = file.gsub(/\n/, ' ')
    s.split(" ").size
  end
  def byte_size
    File.stat(@inputted_file).size
  end
end

puts "単語数"
p InputtedFile.new.generate_number_of_lines
p InputtedFile.new.generate_word_count
p InputtedFile.new.byte_size


#ファイル
p file_size = File.stat("wc_sample").size#ファイルバイト数

file = "wc_sample"
open(file){|f|
  while f.gets; end
  p f.lineno
}#行数


#標準入力
a = <<TEXT
total 216
-rw-r--r--   1 tamuratakumi  staff    157  6  5 20:10 Gemfile
-rw-r--r--   1 tamuratakumi  staff    221  4 27 10:19 Gemfile.lock
-rw-r--r--   1 tamuratakumi  staff    174  6  5 20:10 Rakefile
-rwxr-xr-x   1 tamuratakumi  staff  12556  5 17 21:27 addition
-rw-r--r--   1 tamuratakumi  staff    266  5 17 21:27 addition.c
-rw-r--r--   1 tamuratakumi  staff     68  6  5 20:10 argv.rb
-rw-r--r--   1 tamuratakumi  staff    852  7  2 23:45 bowling.rb
-rw-r--r--   1 tamuratakumi  staff    835  6  5 20:10 cal.rb
-rw-r--r--   1 tamuratakumi  staff   1871  6  5 20:10 class_test.rb
-rw-r--r--   1 tamuratakumi  staff    197  6  5 20:10 fizzbuzz.rb
-rw-r--r--   1 tamuratakumi  staff     17  5 16 17:35 hello-rake.txt
-rw-r--r--   1 tamuratakumi  staff     34  7  3 17:47 hello.rb
-rwxr-xr-x   1 tamuratakumi  staff  12556  5 17 21:16 kuji
drwxr-xr-x  16 tamuratakumi  staff    512  5 16 11:59 lib
-rw-r--r--   1 tamuratakumi  staff   2508  7  3 18:27 ls_command.rb
-rw-r--r--   1 tamuratakumi  staff   2722  6 28 19:19 ls_command_back_up.rb
-rw-r--r--   1 tamuratakumi  staff     45  6  5 20:10 my_first_progam.rb
-rw-r--r--   1 tamuratakumi  staff   1177  6  5 20:10 sample2.rb
-rw-r--r--   1 tamuratakumi  staff    132  6  5 20:10 sample3.rb
-rw-r--r--   1 tamuratakumi  staff    343  6  5 20:10 sinatra_hi.rb
drwxr-xr-x  11 tamuratakumi  staff    352  5 16 16:26 test
-rwxr-xr-x   1 tamuratakumi  staff    751  7  4 18:45 wc.rb
-rw-r--r--   1 tamuratakumi  staff     41  7  4 12:45 wc_sample
TEXT
p a.bytesize#バイト数

#input = $stdin.read.split(/\R/)#.map {|r| r.split(/\s/) }
#p input.size #行数

#b = "end\n\n"
b = a.gsub(/\n/, ' ')
p b.split(" ").size
aaa = []
a.each_line {|f|
  aaa << f
}
p aaa.size
#標準入力の行数

p f = open("wc_sample").read
p s = f.gsub(/\n/, ' ')
p s.split(" ").size


#p c = a.unpack('H*')
#p d =c.map {|d| d.gsub(/0a/, '0x20')}
#p d.pack('H*') #e = d.map {|e| e.pack('H*')}


# 本家 ls -l | wc の結果  行24     単語209    バイト1499


class Aaa
  def self.run
    ls = new()
    ls.run
  end
end

def run
end

class View
  def inputted_file
    print "行" "単語" "バイトサイズ" "ファイル名"
  end
end

#ファイル
p file_size = File.stat("wc_sample").size#ファイルバイト数

file = "wc_sample"
open(file){|f|
  while f.gets; end
  p f.lineno
}#行数


#標準入力
a = <<TEXT
total 216
-rw-r--r--   1 tamuratakumi  staff    157  6  5 20:10 Gemfile
-rw-r--r--   1 tamuratakumi  staff    221  4 27 10:19 Gemfile.lock
-rw-r--r--   1 tamuratakumi  staff    174  6  5 20:10 Rakefile
-rwxr-xr-x   1 tamuratakumi  staff  12556  5 17 21:27 addition
-rw-r--r--   1 tamuratakumi  staff    266  5 17 21:27 addition.c
-rw-r--r--   1 tamuratakumi  staff     68  6  5 20:10 argv.rb
-rw-r--r--   1 tamuratakumi  staff    852  7  2 23:45 bowling.rb
-rw-r--r--   1 tamuratakumi  staff    835  6  5 20:10 cal.rb
-rw-r--r--   1 tamuratakumi  staff   1871  6  5 20:10 class_test.rb
-rw-r--r--   1 tamuratakumi  staff    197  6  5 20:10 fizzbuzz.rb
-rw-r--r--   1 tamuratakumi  staff     17  5 16 17:35 hello-rake.txt
-rw-r--r--   1 tamuratakumi  staff     34  7  3 17:47 hello.rb
-rwxr-xr-x   1 tamuratakumi  staff  12556  5 17 21:16 kuji
drwxr-xr-x  16 tamuratakumi  staff    512  5 16 11:59 lib
-rw-r--r--   1 tamuratakumi  staff   2508  7  3 18:27 ls_command.rb
-rw-r--r--   1 tamuratakumi  staff   2722  6 28 19:19 ls_command_back_up.rb
-rw-r--r--   1 tamuratakumi  staff     45  6  5 20:10 my_first_progam.rb
-rw-r--r--   1 tamuratakumi  staff   1177  6  5 20:10 sample2.rb
-rw-r--r--   1 tamuratakumi  staff    132  6  5 20:10 sample3.rb
-rw-r--r--   1 tamuratakumi  staff    343  6  5 20:10 sinatra_hi.rb
drwxr-xr-x  11 tamuratakumi  staff    352  5 16 16:26 test
-rwxr-xr-x   1 tamuratakumi  staff    751  7  4 18:45 wc.rb
-rw-r--r--   1 tamuratakumi  staff     41  7  4 12:45 wc_sample
TEXT
p a.bytesize#バイト数

#input = $stdin.read.split(/\R/)#.map {|r| r.split(/\s/) }
#p input.size #行数

#b = "end\n\n"
b = a.gsub(/\n/, ' ')
p b.split(" ").size
aaa = []
a.each_line {|f|
  aaa << f
}
p aaa.size
#標準入力の行数

p f = open("wc_sample").read
p s = f.gsub(/\n/, ' ')
p s.split(" ").size


#p c = a.unpack('H*')
#p d =c.map {|d| d.gsub(/0a/, '0x20')}
#p d.pack('H*') #e = d.map {|e| e.pack('H*')}

