# frozen_string_literal: true

require 'optparse'

class WcCommand
  def initialize
    opt = OptionParser.new
    @params = ARGV.getopts('l')
    @file = opt.parse!(ARGV)
  end
  def standard_input_or_file
    @stdin = StandardInput.new if @file[0].nil? == true
    @input = InputtedFile.new if @file[0].nil? == false
  end
  def run
    if @file[0].nil? == true
      stdin_detail = [
        @stdin.generate_number_of_lines,
        @stdin.generate_word_count,
        @stdin.byte_size,
      ]
      if @params['l']
        View.new.print_wc(stdin_detail, 1)
      else
        View.new.print_wc(stdin_detail, 2)
      end
    elsif @file.size == 1
      input_detail = [
        @input.generate_number_of_lines,
        @input.generate_word_count,
        @input.byte_size,
        @input.file_name,
      ]
      if @params['l']
        View.new.print_wc(input_detail, 1)
      else
        View.new.print_wc(input_detail, 2)
      end
    elsif @file.size <= 2
      lines = []
      words = []
      bytes = []
      total = []
      ARGV.map {|file_name| 
        input = InputtedFile.new
        input_detail = [
          input.generate_number_of_lines(file_name),
          input.generate_word_count(file_name),
          input.byte_size(file_name),
          input.file_name(file_name),
        ]
        if @params['l']
          View.new.print_wc(input_detail, 1)
        else
          View.new.print_wc(input_detail, 2)
        end
        lines << input_detail[0]
        words << input_detail[1]
        bytes << input_detail[2]
      }
      total = [lines.sum, words.sum, bytes.sum, "total"]
      if @params['l']
        View.new.print_wc(total, 1)
      else
        View.new.print_wc(total, 2)
      end
    end
  end
end

class StandardInput
  def initialize
    @standard_input = $stdin.read#.map {|r| r.split(/\s/) }
  end
  def generate_number_of_lines
    @standard_input.split(/\R/).size
  end
  def generate_word_count
    words = @standard_input.unpack('H*')
    words_count = words[0].gsub(/20|0c|0a|0d|09|0b|a0|a0/, ' ')
    words_count.split(" ").size
  end
  def byte_size
    @standard_input.bytesize
  end
end

class InputtedFile
  def generate_number_of_lines(inputted_file = ARGV[0])
    File.read(inputted_file).count("\n")
  end
  def generate_word_count(inputted_file = ARGV[0])
    file = open(inputted_file).read
    s = file.gsub(/\n/, ' ')
    s.split(" ")
    s.split(" ").size
  end
  def byte_size(inputted_file = ARGV[0])
    File.stat(inputted_file).size
  end
  def file_name(inputted_file = ARGV[0])
    inputted_file
  end
end

class View
  def print_wc(array, option)
    if option == 1
      print " #{array[0].to_s.rjust(7)}"
    elsif
      array.each {|view|
        print " #{view.to_s.rjust(7)}"
      }
      puts ""
    end
  end
end

wc = WcCommand.new
wc.standard_input_or_file
wc.run

# 本家 ls -l | wc の結果   25     218    1566
# 本家 wc ls_command.rbの結果  118     250    2508 ls_command.rb
