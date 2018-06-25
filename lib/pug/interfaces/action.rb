# frozen_string_literal: true

module Pug
  module Interfaces
    # Abstract interface representing an Action
    class Action
      # The human readable name for the Action
      # @return [String] Action name
      def name
        raise NoMethodError
      end

      # Optional description for the action
      # @return [String] Action description
      def description
        ''
      end

      # Indicates if the action requires an input
      # @return [Boolean] if input is required
      # @note Defaults to false
      def requires_input?
        false
      end

      # Entry point for Action with provided input if any
      # @param input [String] The optional input for the Action
      # @return [String] The output of running the Action
      # @note This can return nil if there is no output
      def execute(input) # rubocop:disable UnusedMethodArgument
        raise NoMethodError
      end
    end
  end
end
