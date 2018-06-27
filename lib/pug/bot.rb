# frozen_string_literal: true

module Pug
  # Coordinates the Client with the provided Actions
  class Bot
    # Convenience method used to setup the Bot
    # with the user defined Configuration
    # @return [Bot] A new instance of Bot.
    # @see Configuration
    def self.run
      config = Pug.configuration
      config.validate
      client = Clients::Factory.client_for_config(config)
      Bot.new(client, config.actions).start
    end

    # @param client [Interfaces::Client] used to interact with User
    # @param actions [Array<Interfaces::Action>] available actions
    def initialize(client, actions)
      @client = client
      @handler = MessageHandler.default(actions)
    end

    # Starts the handling of all messages received via the Client
    # @return [void]
    def start
      @client.listen do |message|
        handle(message)
      end
    end

    private

    def handle(message)
      result = @handler.handle(message)
      output = output_from_result(result)
      @client.send_message(output) unless output.to_s.empty?
      return if result.type != Types::Result::SUCCESS
      action_name = result.value.action_name
      @client.send_message(Strings.finished_running(action_name))
    end

    def output_from_result(result)
      if result.type == Types::Result::SUCCESS
        result.value.value
      elsif result.type == Types::Result::INFO
        result.value
      else
        result.error
      end
    end
  end
end
