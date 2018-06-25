# frozen_string_literal: true

module Pug
  # Defines parameters used to setup Pug
  # @!attribute type
  #   @return [Integer] the type of client to setup
  #   @see Configuration::TERMINAL
  #   @see Configuration::TELEGRAM
  # @!attribute token
  #   @return [String] the API token for Telegram
  #   @note This is optional if type is TERMINAL
  # @!attribute chat_id
  #   @return [String] the chat_id for Telegram
  #   @note This is optional if type is TERMINAL
  # @!attribute actions
  #   @return [Array<Interfaces::Action>] user defined actions
  class Configuration
    attr_accessor :type, :token, :chat_id, :actions

    # @!group Client Types
    TERMINAL = 0
    TELEGRAM = 1
    # @!endgroup

    # @param type [Integer] type of client to setup
    def initialize(type = TERMINAL)
      @type = type
    end

    # Validates if attributes are correctly setup for Pug
    # @raise RuntimeError if type is not a valid Client type
    # @raise RuntimeError if Telegram client and no token & chat_id
    # @raise RuntimeError if provided actions are nil
    # @return [void]
    def validate
      valid_type = [TERMINAL, TELEGRAM].include?(type)
      raise 'Invalid client type' unless valid_type
      bad_config = @token.nil? || @chat_id.nil?
      raise 'Invalid Telegram config' if @type == TELEGRAM && bad_config
      raise 'No actions provided' if @actions.nil?
    end
  end
end
