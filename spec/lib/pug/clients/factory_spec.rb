# frozen_string_literal: true

require 'pug'

describe Pug::Clients::Factory do
  describe 'client_for_config' do
    it 'should return terminal for a nil config' do
      client = Pug::Clients::Factory.client_for_config(nil)
      expect(client).to be_an_instance_of(Pug::TerminalClient)
    end

    it 'should return terminal for a terminal config' do
      config = Pug::Configuration.new(Pug::Configuration::TERMINAL)
      client = Pug::Clients::Factory.client_for_config(config)
      expect(client).to be_an_instance_of(Pug::TerminalClient)
    end

    it 'should return telegram for a telegram config' do
      config = Pug::Configuration.new(Pug::Configuration::TELEGRAM)
      client = Pug::Clients::Factory.client_for_config(config)
      expect(client).to be_an_instance_of(Pug::TelegramClient)
    end
  end
end
