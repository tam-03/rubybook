# frozen_string_literal: true

# diceメソッド 1が出たら「もう一回」
def dice
  a = [1, 2, 3, 4, 5, 6].sample
  return a unless a == 1

  puts 'もう一回'
end
puts dice

# Gem読み込み
# require "awesome_print"
# ap ["カフェラテ", "モカ", "コーヒー"]
#
#
# module3.rbでmodule ChocolateChipインクルードし"モカチョコレートチップ"と表示
#
# module WhippedCream
#     def self.whipped_cream
#         "ホイップクリーム"
#     end
# end
#
# puts WhippedCream.whipped_cream
# モジュールEspressoShotを定義して定数Priceに100代入、表示
# module EspressoShot
#     Price = 100
# end
# puts EspressoShot::Price
#
# class Drink
#     include WhippedCream
#     def name
#         @name
#     end
#     def initialize
#         @name = "モカ"
#     end
# end
#
# mocha = Drink.new
# mocha.whipped_cream
# puts mocha.name
# 別ファイルから読み込み
# require_relative "sample3"
# class Drink
#     include ChocolateChip
#     def initialize(name)
#         @name = name
#     end
#     def name
#         @name
#     end
# end
#
# drink = Drink.new("モカ")
# drink.chocolate_chip
# puts drink.name
#
