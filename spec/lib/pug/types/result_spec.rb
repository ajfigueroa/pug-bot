# frozen_string_literal: true

require 'pug'

describe Pug::Types::Result do
  describe 'success' do
    it 'should return a success result' do
      success = Pug::Types::Result.success('Hello')
      expect(success.type).to eq(Pug::Types::Result::SUCCESS)
      expect(success.value).to eq('Hello')
      expect(success.error).to be nil
    end
  end

  describe 'info' do
    it 'should return an info result' do
      info = Pug::Types::Result.info('Info')
      expect(info.type).to eq(Pug::Types::Result::INFO)
      expect(info.value).to eq('Info')
      expect(info.error).to be nil
    end
  end

  describe 'error' do
    it 'should return an error result' do
      error = Pug::Types::Result.error('Oops')
      expect(error.type).to eq(Pug::Types::Result::ERROR)
      expect(error.value).to be nil
      expect(error.error).to eq('Oops')
    end
  end
end
