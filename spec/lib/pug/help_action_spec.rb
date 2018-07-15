# frozen_string_literal: true

require 'pug'
require_relative '../spec_helpers/mock_action'

describe Pug::HelpAction do
  describe 'execute' do
    before(:each) do
      action0 = MockAction.new('Action0', false, 'Output0')
      action1 = MockAction.new('Action1', true, 'Output1', 'Desc1')
      @help_action = Pug::HelpAction.new([action0, action1])
    end

    it 'should display the list of actions' do
      result = @help_action.execute
      expected = Pug::Strings.help("Action0\nAction1 # Desc1")
      expect(result).to eq(expected)
    end

    it 'should display no actions if none are setup' do
      help_action = Pug::HelpAction.new([])
      result = help_action.execute
      expect(result).to eq(Pug::Strings.no_help_commands)
    end
  end
end
