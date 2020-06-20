# frozen_string_literal: true

require 'optparse'
require 'etc'

class FileDetails
  def initialize
    files = Dir.children('.').sort
    @files = files
    all_files = Dir.entries('.').sort
    @all_files = all_files
  end

  def file_block
    block = []
    @files.each do |f|
      block << File.stat(f).blocks
    end
    puts "total #{block.sum}"
  end

  def file_block_all
    block = []
    @all_files.each do |s|
      block << File.stat(s).blocks
    end
    puts "total #{block.sum}"
  end

  def file_type_to_s(f)
    type = File.ftype(f)
    case type
    when 'file'
      '-'
    when 'directory'
      'd'
    when 'link'
      'l'
    end
  end

  def file_parmission(f)
    mode = File.stat(f).world_readable?
    parmission = format('%o', mode)
    pms = parmission.to_s.split(//).to_a
    (0..2).each do |i|
      if pms[i] == '7'
        pms[i] = 'rwx'
      elsif pms[i] == '6'
        pms[i] = 'rw-'
      elsif pms[i] == '5'
        pms[i] = 'r-x'
      elsif pms[i] == '4'
        pms[i] = 'r--'
      elsif pms[i] == '3'
        pms[i] = '-wx'
      elsif pms[i] == '2'
        pms[i] = '-w-'
      elsif pms[i] == '1'
        pms[i] = '--x'
      end
      return pms.join if i == 2
    end
  end

  def file_link(f)
    file_link = File.stat(f).nlink.to_s
    ' ' + file_link.rjust(3).to_s + ' '
  end

  def file_uid_name(f)
    Etc.getpwuid(File.stat(f).uid).name
  end

  def file_gid_name(f)
    Etc.getgrgid(File.stat(f).gid).name
  end

  def file_size(f)
    file_size = File.stat(f).size
    file_size.to_s.rjust(5)
  end

  def file_update_day(f)
    mtime = File.stat(f).mtime
    mtime_a = mtime.to_a
    mtime_s = mtime.strftime('%R')
    (mtime_a[4].to_s.rjust(2) + mtime_a[3].to_s.rjust(3)).to_s + ' ' + mtime_s + ' '
  end
end

class Ls < FileDetails
  def no_option
    @files.each do |n|
      puts n
    end
  end

  def a_option
    str_max_length = @all_files.map(&:size).max + 2
    (0..5).each do |num|
      lines = []
      @all_files.each_slice(6) do |a_files|
        lines << a_files[num]
      end
      lines.each do |file|
        if file.nil?
          print ' '
        else
          print file.ljust(str_max_length)
        end
      end
      puts "\n"
    end
  end

  def r_option
    str_max_length = @files.map(&:size).max + 2
    (0..5).each do |num|
      lines = []
      @files.reverse_each.each_slice(6) do |a_files|
        lines << a_files[num]
      end
      lines.each do |file|
        if file.nil?
          print ' '
        else
          print file.ljust(str_max_length)
        end
      end
      puts "\n"
    end
  end

  def l_option
    l_files = FileDetails.new
    l_files.file_block
    @files.each do |f|
      l_files = FileDetails.new
      print l_files.file_type_to_s(f)
      print l_files.file_parmission(f)
      print l_files.file_link(f)
      print l_files.file_uid_name(f) + ' '
      print l_files.file_gid_name(f) + ' '
      print l_files.file_size(f) + ' '
      print l_files.file_update_day(f)
      puts f
    end
  end

  def a_r_option
    str_max_length = @all_files.map(&:size).max + 2
    (0..5).each do |num|
      lines = []
      @all_files.reverse_each.each_slice(6) do |a_files|
        lines << a_files[num]
      end
      lines.each do |file|
        if file.nil?
          print ' '
        else
          print file.ljust(str_max_length)
        end
      end
      puts "\n"
    end
  end

  def l_a_option
    l_files = FileDetails.new
    l_files.file_block
    @all_files.each do |f|
      l_files = FileDetails.new
      print l_files.file_type_to_s(f)
      print l_files.file_parmission(f)
      print l_files.file_link(f)
      print l_files.file_uid_name(f) + ' '
      print l_files.file_gid_name(f) + ' '
      print l_files.file_size(f) + ' '
      print l_files.file_update_day(f)
      puts f
    end
  end

  def l_r_option
    l_files = FileDetails.new
    l_files.file_block
    @files.reverse_each.each do |f|
      l_files = FileDetails.new
      print l_files.file_type_to_s(f)
      print l_files.file_parmission(f)
      print l_files.file_link(f)
      print l_files.file_uid_name(f) + ' '
      print l_files.file_gid_name(f) + ' '
      print l_files.file_size(f) + ' '
      print l_files.file_update_day(f)
      puts f
    end
  end

  def a_l_r_option
    l_files = FileDetails.new
    l_files.file_block
    @all_files.reverse_each.each do |f|
      l_files = FileDetails.new
      print l_files.file_type_to_s(f)
      print l_files.file_parmission(f)
      print l_files.file_link(f)
      print l_files.file_uid_name(f) + ' '
      print l_files.file_gid_name(f) + ' '
      print l_files.file_size(f) + ' '
      print l_files.file_update_day(f)
      puts f
    end
  end
end

class Command
  def initialize
    @options = {}
    opt = OptionParser.new
    opt.on('-a') { |v| @options[:a] = v }
    opt.on('-r') { |v| @options[:r] = v }
    opt.on('-l') { |v| @options[:l] = v }
    opt.parse!(ARGV)
  end

  def select_option
    if @options[:a] && @options[:l] && @options[:r]
      file = Ls.new
      file.a_l_r_option
    elsif @options[:a] && @options[:r]
      file = Ls.new
      file.a_r_option
    elsif @options[:l] && @options[:a]
      file = Ls.new
      file.l_a_option
    elsif @options[:r] && @options[:l]
      file = Ls.new
      file.l_r_option
    elsif @options[:a]
      file = Ls.new
      file.a_option
    elsif @options[:l]
      file = Ls.new
      file.l_option
    elsif @options[:r]
      file = Ls.new
      file.r_option
    else
      file = Ls.new
      file.no_option
    end
  end
end

ls_command = Command.new
ls_command.select_option
