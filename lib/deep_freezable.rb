# frozen_string_literal: true

module DeepFreezable
  def deep_freeze(array_or_hash)
    case array_or_hash
    when Array
      array_or_hash.each(&:freeze)
    when Hash
      array_or_hash.each do |key, value|
        key.freeze
        value.freeze
      end
    end
    array_or_hash.freeze
  end
end
