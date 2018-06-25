# frozen_string_literal: true

module Pug
  module Clients
    # Factory for building Clients based on a configuration
    class Factory
      # Builds a Client for the given config
      # @param config [Configuration] parameters to build Client from
      # @return [Interfaces::Client] The client from the config parameters
      def self.client_for_config(config)
        if !config.nil? && config.type == Configuration::TELEGRAM
          enumerator = Action::Enumerator.new
          markup = enumerator.grouped_names(config.actions)
          client = TelegramClient.new(config.token, config.chat_id)
          client.configure_keyboard(markup)
          client
        else
          TerminalClient.new
        end
      end
    end
  end
end
