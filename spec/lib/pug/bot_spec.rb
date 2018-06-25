# frozen_string_literal: true

require 'pug'
require_relative '../spec_helpers/mock_action'
require_relative '../spec_helpers/mock_client'

describe Pug::Bot do
  describe 'start' do
    before(:each) do
      @client = MockClient.new
      action0 = MockAction.new('Action0', false, 'Output0')
      action1 = MockAction.new('Action1', true, 'Output1')
      @bot = Pug::Bot.new(@client, [action0, action1])
    end

    it 'should respond to "help" command' do
      @client.enqueue_message('help')
      expected = Pug::Strings.help('list')
      @bot.start
      expect(@client.last_sent_message).to eq(expected)
    end

    it 'should respond to "list" command' do
      @client.enqueue_message('list')
      expected = "0: Action0\n1: Action1"
      @bot.start
      expect(@client.last_sent_message).to eq(expected)
    end

    describe 'when there are no commands' do
      it 'should indicate there are no commands' do
        client = MockClient.new
        client.enqueue_message('0')
        bot = Pug::Bot.new(client, [])
        expected = Pug::Strings.no_actions
        bot.start
        expect(client.last_sent_message).to eq(expected)
      end
    end

    describe 'when a command is not running' do
      it 'should respond to an unknown input' do
        @client.enqueue_message('asdfadf')
        expected = Pug::Strings.unknown_input
        @bot.start
        expect(@client.last_sent_message).to eq(expected)
      end

      it 'should respond to an action call with no inputs required' do
        @client.enqueue_message('0')
        expected0 = 'Output0'
        expected1 = Pug::Strings.finished_running('Action0')
        @bot.start
        expect(@client.sent_messages).to eq([expected0, expected1])
      end

      it 'should respond to an action call with inputs required' do
        @client.enqueue_message('1')
        expected = Pug::Strings.enter_inputs('Action1')
        @bot.start
        expect(@client.last_sent_message).to eq(expected)
      end
    end

    describe 'when a command is running' do
      it 'should pass the input and run the command awaiting input' do
        @client.enqueue_message('1')
        @client.enqueue_message('Input')
        expected0 = Pug::Strings.enter_inputs('Action1')
        expected1 = 'Output1'
        expected2 = Pug::Strings.finished_running('Action1')
        expected = [expected0, expected1, expected2]
        @bot.start
        expect(@client.sent_messages).to eq(expected)
      end
    end
  end
end
