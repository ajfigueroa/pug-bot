# frozen_string_literal: true

module Pug
  module Action
    # Defines input requirements for an Action
    # @!attribute action_name
    #   @return [String] the name of the Action
    # @!attribute required
    #   @return [Boolean] if Action requires input
    class Input
      attr_reader :action_name, :required

      # @param action_name [String] The name of the Action
      # @param required [Boolean] if Action requires input
      def initialize(action_name, required)
        @action_name = action_name
        @required = required
      end

      # @return [Boolean] if Action requires input
      def required?
        @required
      end
    end
  end
end
