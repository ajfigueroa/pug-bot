# frozen_string_literal: true

require 'pug'
require_relative '../spec_helpers/mock_action'

describe Pug::MessageHandler do
  describe 'when there are no actions' do
    before(:each) do
      @handler = Pug::MessageHandler.default([])
    end

    it 'should return a message about lack of actions' do
      result = @handler.handle('something')
      expect(result.type).to eq(Pug::Types::Result::ERROR)
      expect(result.error).to eq(Pug::Strings.no_actions)
    end
  end

  describe 'when there are some actions' do
    before(:each) do
      action = MockAction.new('Cmd', false, 'Yo')
      @handler = Pug::MessageHandler.default([action])
    end

    it 'should return unknown input result for an empty message' do
      result = @handler.handle('')
      expect(result.type).to eq(Pug::Types::Result::ERROR)
      expect(result.error).to eq(Pug::Strings.unknown_input)
    end

    it 'should return unknown input result for an invalid action message' do
      result = @handler.handle('-1: An invalid action')
      expect(result.type).to eq(Pug::Types::Result::ERROR)
      expect(result.error).to eq(Pug::Strings.unknown_input)
    end

    it 'should return unable to start commmand for invalid index' do
      result = @handler.handle('10: Some out of bounds action')
      expect(result.type).to eq(Pug::Types::Result::ERROR)
      expect(result.error).to eq(Pug::Strings.unable_to_start_action(10))
    end
  end

  describe 'when running a action that does not require input' do
    before(:each) do
      action = MockAction.new('Cmd', false, 'Done!')
      @handler = Pug::MessageHandler.default([action])
    end

    it 'should return the success output' do
      result = @handler.handle('0')
      expect(result.type).to eq(Pug::Types::Result::SUCCESS)
      expect(result.value.action_name).to eq('Cmd')
      expect(result.value.value).to eq('Done!')
    end
  end

  describe 'when running a action that requires input' do
    before(:each) do
      action = MockAction.new('Cmd', true, 'Done!')
      @handler = Pug::MessageHandler.default([action])
    end

    it 'should return info result informing that input is needed' do
      result = @handler.handle('0')
      expect(result.type).to eq(Pug::Types::Result::INFO)
      expect(result.value).to eq(Pug::Strings.enter_inputs('Cmd'))
    end

    it 'should return a success result when input has been received' do
      @handler.handle('0')
      result = @handler.handle('Some input now')
      expect(result.type).to eq(Pug::Types::Result::SUCCESS)
      expect(result.value.action_name).to eq('Cmd')
      expect(result.value.value).to eq('Done!')
    end
  end
end
