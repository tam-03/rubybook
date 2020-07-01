# frozen_string_literal: true

require 'optparse'
require 'etc'

class FileDetails
  def file_block(array)
    block = []
    array.map do |f|
      block << File.stat(f).blocks
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
  def l_option(array)
    l_files = FileDetails.new
    l_files.file_block(array)
    array.map do |f|
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

class Print < Ls
  def print_row(array)
    str_max_length = array.map(&:size).max + 2
    (0..6).map do |num|
      lines = []
      array.each_slice(7) do |files|
        lines << files[num]
      end
      lines.map do |file|
        if file.nil?
          print ' '
        else
          print file.ljust(str_max_length)
        end
      end
      puts "\n"
    end
  end
end

class Command < Ls
  def select_option
    horizontal = Print.new
    list = Ls.new
    files = ARGV.getopts('arl')
    file = Dir.entries('.').sort - Dir['.*']
    file = Dir.entries('.').sort if files['a']
    file.reverse! if files['r']
    if files['l']
      list.l_option(file)
    else
      horizontal.print_row(file)
    end
  end
end

file = Command.new
file.select_option
