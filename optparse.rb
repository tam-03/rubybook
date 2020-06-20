# frozen_string_literal: true

require 'optparse'

class File1
  options = {}
  opt = OptionParser.new
  opt.on('-a', '引数なし') { |v| options[:a] = v }
  opt.on('-r', '引数なし') { |v| options[:r] = v }
  opt.on('-l', '引数なし') { |v| options[:l] = v }
  opt.parse!(ARGV)

  def no_option_files
    Dir.glob('*').sort
  end

  def a_option_files
    Dir.glob('*', File::FNM_DOTMATCH).sort
  end

  def r_option_files
    Dir.glob('*').sort.reverse
  end

  def a_r_option_files
    Dir.glob('*', File::FNM_DOTMATCH).sort.reverse
  end

  # 表示メソッド(横に表示)
  def print_array_horizon(array)
    array.each_with_index do |x, index|
      if index == array.size - 1
        printf('%-20s', x)
        puts ''
      else
        printf('%-20s', x)
      end
    end
  end

  def select_option
    if options[:a] && options[:r]
      print_array_horizon(a_r_option_files)
    elsif options[:a]
      print_array_horizon(a_option_files)
    elsif options[:r]
      print_array_horizon(a_option_files)
    else
      print_array_horizon(no_option_files)
    end
  end
end

file1 = File1.new
file1.select_option

#  def a_option
#     a_files_0 = []
#     a_files_1 = []
#     a_files_2 = []
#     a_files_3 = []
#     a_files_4 = []
#     a_files_5 = []
#     @all_files.each_slice(6) { |a_files|
#       a_files_0 << a_files[0]
#       a_files_1 << a_files[1]
#       a_files_2 << a_files[2]
#       a_files_3 << a_files[3]
#       a_files_4 << a_files[4]
#       a_files_5 << a_files[5]
#     }
#     a_files_0.each {|n| print n + "  "}
#     a_files_1.each {|n| print n + "  "}
#     print a_files_2
#     print a_files_3
#     print a_files_4
#     print a_files_5
#       #(0..5).each { |i|
#         #print "#{n[i]}"
#       #}
#
#   end

# def a_option
#     a_files = []
#     @all_files.each_slice(6) {|a|
#       a_files << a
#     }
#     a_files[0].each {|n| puts n.ljust(10) }
#     puts a_files[1]
#     puts a_files[2]
#     puts a_files[3]
#     puts a_files[4]
# end
