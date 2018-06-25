# frozen_string_literal: true

module Pug
  module Interfaces
    # Abstract interface for a Client that Pug can talk to
    # such as Telegram or Terminal
    class Client
      # Listens for and passes text via a block
      # @yieldparam [String] text
      def listen
        raise NoMethodError
      end

      # Sends a message to the User via the Client
      # @param message [String] the message to send
      # @return [void]
      def send_message(message) # rubocop:disable UnusedMethodArgument
        raise NoMethodError
      end
    end
  end
end
