# frozen_string_literal: true

require 'pug/number_parser'

describe Pug::NumberParser do
  describe 'starts_with_numeric_text?' do
    it 'returns false if the text does not start with a number' do
      parser = Pug::NumberParser.new
      expect(parser.starts_with_numeric_text?('alex')).to be false
    end

    it 'returns true if the text is 0' do
      parser = Pug::NumberParser.new
      expect(parser.starts_with_numeric_text?('0')).to be true
    end

    it 'returns true if the text is just a number' do
      parser = Pug::NumberParser.new
      expect(parser.starts_with_numeric_text?('10')).to be true
    end

    it 'returns true if text starts with number' do
      parser = Pug::NumberParser.new
      expect(parser.starts_with_numeric_text?('1. Alex')).to be true
    end
  end

  describe 'number_from_text' do
    it 'returns nil if the text does not contain a number' do
      parser = Pug::NumberParser.new
      expect(parser.number_from_text('Alex')).to be nil
    end

    it 'returns nil if the text does not start with a number' do
      parser = Pug::NumberParser.new
      expect(parser.number_from_text('Alex 10')).to be nil
    end

    it 'returns the number if the text does start with a number' do
      parser = Pug::NumberParser.new
      expect(parser.number_from_text('10. Alex')).to eq(10)
    end
  end
end
