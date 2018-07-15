# frozen_string_literal: true

module Pug
  # Lists all the user defined actions
  class ListAction < Interfaces::Action
    # @param actions [Array<Interfaces::Action>]
    #   user provided actions
    def initialize(actions)
      @actions = actions
      @enumerator = Action::Enumerator.new
    end

    # Action overrides

    # Override of {Interfaces::Action#name}
    # @return [String]
    def name
      'list'
    end

    # Override of {Interfaces::Action#description}
    # @return [String]
    def description
      Strings.list_description
    end

    # Override of {Interfaces::Action#execute}
    # @return [String]
    def execute
      return Strings.no_actions if @actions.empty?
      @enumerator.names(@actions, true).join("\n")
    end
  end
end
