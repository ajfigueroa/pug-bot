# frozen_string_literal: true

require 'set'

module Pug
  # Responds to keywords that provide hints to the User
  class KeywordHandler
    # @!group Keywords
    HELP = 'help'
    LIST = 'list'
    # @!endgroup

    # @param actions [Array<Interfaces::Action>]
    #   user provided actions
    def initialize(actions)
      @actions = actions
      @keywords = Set[HELP, LIST]
      @enumerator = Action::Enumerator.new
    end

    # Determines if a given text is a keyword
    # @param text [String] text to test
    # @return [Boolean] if text is a keyword
    def keyword?(text)
      @keywords.include?(text)
    end

    # Runs the command corresponding to text
    # if it is a keyword
    # @param text [String] text to run command for
    # @return [String, nil] output of command or nil
    def run_command_for_keyword(text)
      return nil unless keyword?(text)
      map_keyword_to_command(text)
    end

    private

    def keywords_excluding_help
      @keywords.to_a.reject { |keyword| keyword == HELP }
    end

    def map_keyword_to_command(keyword)
      return help_response if keyword == HELP
      return list_response if keyword == LIST
      nil
    end

    def help_response
      commands = keywords_excluding_help.join("\n")
      Strings.help(commands)
    end

    def list_response
      return Strings.no_actions if @actions.empty?
      @enumerator.names(@actions, true).join("\n")
    end
  end
end
