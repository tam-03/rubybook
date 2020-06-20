# frozen_string_literal: true

class FileDetails
  require 'etc'
  def initialize
    files = Dir.children('.').sort
    @files = files
    all_files = Dir.entries('.').sort
    @all_files = all_files
  end

  def file_block
    block = []
    @files.each do |s|
      block << File.stat(s).blocks
    end
    block.sum
  end

  def file_block_all
    block = []
    @all_files.each do |s|
      block << File.stat(s).blocks
    end
    block
    block.sum
  end

  def file_type_to_s
    type = File.ftype(n)
    case type
    when 'file'
      '-'
    when 'directory'
      'd'
    when 'link'
      'l'
    end
  end

  def file_parmission
    mode = File.stat(n).world_readable?
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
    # print " " +"#{file_link.rjust(3)}" + " "
  end

  def file_uid_name
    Etc.getpwuid(File.stat(n).uid).name
    # print Etc.getpwuid(File.stat(n).uid).name + " "
  end

  def file_uid_name
    Etc.getgrgid(File.stat(n).gid).name
    # print Etc.getgrgid(File.stat(n).gid).name + " "
  end

  def file_size
    file_size = File.stat(n).size
    file_size.to_s.rjust(5)
    # print file_size.to_s.rjust(5) + " "
  end

  def file_update_day
    mtime = File.stat(n).mtime
    mtime_a = mtime.to_a
    mtime_s = mtime.strftime('%R')
    (mtime_a[4].to_s.rjust(2) + mtime_a[3].to_s.rjust(3)).to_s + ' ' + mtime_s + ' '
  end
end
