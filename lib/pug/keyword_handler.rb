# frozen_string_literal: true

require 'set'

module Pug
  # Responds to keywords that provide hints to the User
  class KeywordHandler
    # @param actions [Array<Interfaces::Action>]
    #   user provided actions
    def initialize(actions)
      list_action = ListAction.new(actions)
      @keyword_map = {
        'help' => HelpAction.new([list_action]),
        'list' => list_action
      }
    end

    # Determines if a given text is a keyword
    # @param text [String] text to test
    # @return [Boolean] if text is a keyword
    def keyword?(text)
      @keyword_map.include?(text)
    end

    # Runs the command corresponding to text
    # if it is a keyword
    # @param text [String] text to run command for
    # @return [String, nil] output of command or nil
    def run_command_for_keyword(keyword)
      return nil unless keyword?(keyword)
      command = @keyword_map[keyword]
      command.execute
    end
  end
end
