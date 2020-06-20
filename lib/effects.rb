# frozen_string_literal: true

module Effects
  def self.reverse
    lambda do |words|
      words.split(' ').map(&:reverse).join(' ')
    end
  end

  def self.echo(rate)
    lambda do |words|
      words.chars.map { |c| c == ' ' ? c : c * rate }.join
    end
  end

  def self.loud(level)
    lambda do |words|
      words.split(' ').map { |word| word.upcase + '!' * level }.join(' ')
    end
  end
end
