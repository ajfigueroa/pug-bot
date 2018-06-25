# frozen_string_literal: true

require 'pug'
require_relative '../../spec_helpers/mock_action'

describe Pug::Action::Enumerator do
  describe 'names' do
    it 'should return an empty array for nil actions' do
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.names(nil)).to be_empty
    end

    it 'should return an empty array for empty actions' do
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.names([])).to be_empty
    end

    it 'should return a single enumeration for a single action' do
      action = MockAction.new('Command')
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.names([action])).to eq(['0: Command'])
    end

    it 'should return multiple enumerations for multiple actions' do
      action0 = MockAction.new('Command0')
      action1 = MockAction.new('Command1')
      action2 = MockAction.new('Command2')
      actions = [action0, action1, action2]
      enumerator = Pug::Action::Enumerator.new
      expected = ['0: Command0', '1: Command1', '2: Command2']
      expect(enumerator.names(actions)).to eq(expected)
    end

    it 'should not show the description if it is nil' do
      action = MockAction.new('Command')
      action.mock_description = nil
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.names([action], true)).to eq(['0: Command'])
    end

    it 'should not show the description if it is empty' do
      action = MockAction.new('Command')
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.names([action], true)).to eq(['0: Command'])
    end

    it 'should show the description if it is valid' do
      action = MockAction.new('Command')
      action.mock_description = 'ABOUT'
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.names([action], true)).to eq(['0: Command # ABOUT'])
    end
  end

  describe 'grouped_names' do
    it 'should return an empty array for nil actions' do
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.grouped_names(nil)).to be_empty
    end

    it 'should return an empty array for a negative group size' do
      action = MockAction.new('Command')
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.grouped_names([action], -10)).to eq([])
    end

    it 'should return an empty array for a group size of 0' do
      action = MockAction.new('Command')
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.grouped_names([action], 0)).to eq([])
    end

    it 'should return an empty array for empty actions' do
      enumerator = Pug::Action::Enumerator.new
      expect(enumerator.grouped_names([])).to be_empty
    end

    it 'should return a subarray when less actions than group size' do
      action = MockAction.new('Command')
      enumerator = Pug::Action::Enumerator.new
      expected = [['0: Command']]
      expect(enumerator.grouped_names([action], 10)).to eq(expected)
    end

    it 'should return a subarray when equal actions to group size' do
      action0 = MockAction.new('Command0')
      action1 = MockAction.new('Command1')
      actions = [action0, action1]
      enumerator = Pug::Action::Enumerator.new
      expected = [['0: Command0', '1: Command1']]
      expect(enumerator.grouped_names(actions, 2)).to eq(expected)
    end

    it 'should return multiple subarrays when more actions than group size' do
      action0 = MockAction.new('Command0')
      action1 = MockAction.new('Command1')
      action2 = MockAction.new('Command2')
      actions = [action0, action1, action2]
      enumerator = Pug::Action::Enumerator.new
      expected = [['0: Command0', '1: Command1'], ['2: Command2']]
      expect(enumerator.grouped_names(actions, 2)).to eq(expected)
    end
  end
end
