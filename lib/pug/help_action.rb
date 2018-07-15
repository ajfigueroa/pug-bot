# frozen_string_literal: true

module Pug
  # Lists all the system defined actions
  class HelpAction < Interfaces::Action
    # @param actions [Array<Interfaces::Action>]
    #   system provided actions
    def initialize(actions)
      @actions = actions
    end

    # Action overrides

    # Override of {Interfaces::Action#name}
    # @return [String]
    def name
      ''
    end

    # Override of {Interfaces::Action#execute}
    # @return [String]
    def execute
      return Strings.no_help_commands if @actions.empty?
      actions = @actions.map do |action|
        if action.description.to_s.empty?
          action.name
        else
          "#{action.name} # #{action.description}"
        end
      end
      Strings.help(actions.join("\n"))
    end
  end
end
