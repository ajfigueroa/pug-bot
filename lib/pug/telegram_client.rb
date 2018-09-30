# frozen_string_literal: true

require 'telegram/bot'

module Pug
  # The client for Telegram interactions
  class TelegramClient < Interfaces::Client
    # @param token [String] API token for Telegram bot
    # @param chat_id [String] Chat id for Telegram bot
    def initialize(token, chat_id)
      @token = token
      @chat_id = chat_id
    end

    # Configures keyboard with provided markup
    # This can be useful to make shortcuts for Commands
    # @param keyboard_markup [Array<Array<String>>]
    #   A 2D array of strings used to populate on the keyboard
    def configure_keyboard(keyboard_markup)
      @keyboard_markup = keyboard_markup || []
    end

    # Override of {Interfaces::Client#listen}
    # @yieldparam [String] text
    def listen
      perform_with_bot do |bot|
        bot.listen do |message|
          next if message.nil?
          text = message.text
          next if text.nil?
          yield text
        end
      end
    end

    # Override of {Interfaces::Client#send_message}
    # @return [void]
    def send_message(message)
      return if message.to_s.empty?
      send_telegram_message(message)
    end

    private

    def send_telegram_message(message)
      perform_with_bot do |bot|
        bot.api.send_message(
          chat_id: @chat_id,
          text: message,
          reply_markup: reply_markup,
          disable_web_page_preview: true
        )
      end
    end

    def reply_markup
      Telegram::Bot::Types::ReplyKeyboardMarkup.new(
        keyboard: @keyboard_markup || []
      )
    end

    def client
      return @client if @client
      raise 'No Telegram token provided' if @token.to_s.empty?
      @client = Telegram::Bot::Client.new(@token)
    end

    def perform_with_bot
      yield client
    rescue StandardError => ex
      puts 'Error performing task with Telegram'
      puts ex
      puts ex.backtrace
    end
  end
end
