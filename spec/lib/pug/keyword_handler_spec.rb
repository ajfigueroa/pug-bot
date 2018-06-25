# frozen_string_literal: true

require 'pug'
require_relative '../spec_helpers/mock_action'

describe Pug::KeywordHandler do
  describe 'keyword?' do
    it 'returns false for non-keyword' do
      handler = Pug::KeywordHandler.new([])
      expect(handler.keyword?('ALEX')).to be false
    end

    it 'returns true for help keyword' do
      handler = Pug::KeywordHandler.new([])
      expect(handler.keyword?('help')).to be true
    end

    it 'returns true for list keyword' do
      handler = Pug::KeywordHandler.new([])
      expect(handler.keyword?('list')).to be true
    end
  end

  describe 'run_command_for_keyword' do
    before(:each) do
      action0 = MockAction.new('Test0', false, '', 'About0')
      action1 = MockAction.new('Test1', false, '')
      action2 = MockAction.new('Test2', false, '', '')
      actions = [action0, action1, action2]
      @handler = Pug::KeywordHandler.new(actions)
    end

    it 'returns nil if text is not a keyword' do
      expect(@handler.run_command_for_keyword('Alex')).to be nil
    end

    it 'returns list of keywords if text is help' do
      expected = Pug::Strings.help('list')
      expect(@handler.run_command_for_keyword('help')).to eq(expected)
    end

    it 'returns list of actions if text is list' do
      expected = "0: Test0 # About0\n1: Test1\n2: Test2"
      expect(@handler.run_command_for_keyword('list')).to eq(expected)
    end

    it 'returns if there are no actions if text is list' do
      handler = Pug::KeywordHandler.new([])
      expected = Pug::Strings.no_actions
      expect(handler.run_command_for_keyword('list')).to eq(expected)
    end
  end
end
