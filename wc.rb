# frozen_string_literal: true

require 'optparse'

class WcCommand
  def standard_input_or_file
    @stdin = StandardInput.new if ARGV[0].nil? == true
    @input = InputtedFile.new if ARGV[0].nil? == false
  end
  def run
    if ARGV[0].nil? == true
      stdin_detail = [
        @stdin.generate_number_of_lines,
        @stdin.generate_word_count,
        @stdin.byte_size,
      ]
      View.new(stdin_detail)
    elsif ARGV[0].nil? == false
      input_detail = [
        @input.generate_number_of_lines,
        @input.generate_word_count,
        @input.byte_size,
        @input.file_name,
      ]
      View.new(input_detail)
    end
  end
end

class StandardInput
  def initialize
    @standard_input = $stdin.read#.map {|r| r.split(/\s/) }
  end
  def generate_number_of_lines
    p @standard_input.split(/\R/).size
  end
  def generate_word_count
    b = @standard_input.split("\n").size
  end
  def byte_size
    std = 0
    @standard_input.split(/\R/).each{|stdin| std += stdin.bytesize}
    std
  end
end

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
  def file_name
    @inputted_file
  end
end

class View
  def initialize(array)
    array.each {|view|
      print view.to_s.rjust(8)
    }
  end
end

wc = WcCommand.new
wc.standard_input_or_file
wc.run

# 本家 ls -l | wc の結果  行24     単語209    バイト1499

