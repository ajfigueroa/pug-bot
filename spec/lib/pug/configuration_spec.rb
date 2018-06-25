# frozen_string_literal: true

require 'pug'

describe Pug::Configuration do
  describe 'initialize' do
    it 'should default to terminal if type is nil' do
      config = Pug::Configuration.new
      expect(config.type).to eq(Pug::Configuration::TERMINAL)
    end
  end

  describe 'validate' do
    before(:each) { @config = Pug::Configuration.new }

    it 'should raise an error if type is not valid' do
      @config.type = 100
      expect { @config.validate }.to raise_error(RuntimeError)
    end

    it 'should raise an error if telegram type and missing token' do
      @config.type = Pug::Configuration::TELEGRAM
      @config.chat_id = '123'
      expect { @config.validate }.to raise_error(RuntimeError)
    end

    it 'should raise an error if telegram type and missing chat_id' do
      @config.type = Pug::Configuration::TELEGRAM
      @config.token = 'TOKEN'
      expect { @config.validate }.to raise_error(RuntimeError)
    end

    it 'should not raise an error for a valid telegram config' do
      @config.type = Pug::Configuration::TERMINAL
      @config.chat_id = '123'
      @config.token = 'TOKEN'
      @config.actions = []
      expect { @config.validate }.to_not raise_error
    end

    it 'should raise an error if actions are nil' do
      @config.type = Pug::Configuration::TERMINAL
      expect { @config.validate }.to raise_error(RuntimeError)
    end

    it 'should not raise an error for a valid terminal config' do
      @config.type = Pug::Configuration::TERMINAL
      @config.actions = []
      expect { @config.validate }.to_not raise_error
    end
  end
end
