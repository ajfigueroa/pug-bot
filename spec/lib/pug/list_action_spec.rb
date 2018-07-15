# frozen_string_literal: true

require 'pug'
require_relative '../spec_helpers/mock_action'

describe Pug::ListAction do
  describe 'execute' do
    before(:each) do
      action0 = MockAction.new('Action0', false, 'Output0')
      action1 = MockAction.new('Action1', true, 'Output1', 'Desc1')
      @list_action = Pug::ListAction.new([action0, action1])
    end

    it 'should display the list of actions' do
      result = @list_action.execute
      expected = "0: Action0\n1: Action1 # Desc1"
      expect(result).to eq(expected)
    end

    it 'should display no actions if none are setup' do
      list_action = Pug::ListAction.new([])
      result = list_action.execute
      expect(result).to eq(Pug::Strings.no_actions)
    end
  end
end
