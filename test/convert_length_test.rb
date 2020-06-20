# frozen_string_literal: true

require 'minitest/autorun'
require '../lib/convert_length.rb'

class ConvertLengthTest < MiniTest::Test
  def test_convert_length
    assert_equal 39.37, convert_length(1, from: :m, to: :in)
    assert_equal 0.38, convert_length(15, from: :in, from: :m)
    assert_equal 10_670.73, convert_length(35_000, from: :ft, to: :m)
  end
end
