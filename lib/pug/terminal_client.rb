# frozen_string_literal: true

module Pug
  # The client for Terminal interactions
  class TerminalClient < Interfaces::Client
    # Override of {Interfaces::Client#listen}
    # @yieldparam [String] text
    def listen
      loop do
        message = gets
        yield message.chomp
      end
    end

    # Override of {Interfaces::Client#send_message}
    # @return [void]
    def send_message(message)
      return if message.to_s.empty?
      puts message.green
    end
  end
end

# Helper class used to spice up Terminal output
class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def green
    colorize(32)
  end
end
