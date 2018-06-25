# frozen_string_literal: true

module Pug
  module Action
    # Defines output of running an Action
    # @!attribute action_name
    #   @return [String] the name of the Action
    # @!attribute value
    #   @return [String] the output of the Action
    class Output
      attr_reader :action_name, :value

      # @param action_name [String] the name of the Action
      # @param value [String] the output of the Action
      def initialize(action_name, value)
        @action_name = action_name
        @value = value
      end
    end
  end
end
