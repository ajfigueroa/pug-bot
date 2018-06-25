# frozen_string_literal: true

module Pug
  # Parses numeric values from text
  class NumberParser
    # Indicates if a text starts with a number
    # @param text [String] text to test
    # @return [Boolean] if text starts with numeric text
    def starts_with_numeric_text?(text)
      text.to_i.positive? || text.strip.start_with?('0')
    end

    # Extracts number from text if it starts with
    # a number
    # @param text [String] text to extract number from
    # @return [Integer, nil] number from text or nil
    def number_from_text(text)
      return nil unless starts_with_numeric_text?(text)
      text.to_i
    end
  end
end
