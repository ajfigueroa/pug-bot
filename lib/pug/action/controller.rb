# frozen_string_literal: true

module Pug
  module Action
    # Controls the execution of an Action serially
    class Controller
      # @param actions [Array<Pug::Interfaces::Action>] The actions to manage
      def initialize(actions)
        @current_action = nil
        @actions = actions || []
      end

      # Indicates if there are any actions to manage
      # @return [Boolean] If there are any actions
      def actions?
        !@actions.empty?
      end

      # Indicates if there is a currently running Action
      # @return [Boolean] if there is an action currently running
      def running_action?
        !@current_action.nil?
      end

      # Provides information about the Action's input requirements
      # @return [Input] describing the requirements
      def action_input
        raise Strings.no_action_running unless running_action?
        input_required = @current_action.requires_input?
        Input.new(@current_action.name, input_required)
      end

      # Determines if an Action can start for a given index
      # @param index [Integer] the index of the Action in actions
      # @return [Boolean] indicating if an Action can be started at this index
      # @note This will return false if there is a currently running action
      def can_start_action?(index)
        return false if index.negative? || index >= @actions.length
        !running_action?
      end

      # Starts up the Action at the given index if possible
      # @param index [Integer] the index of the Action in actions
      def start_action(index)
        return unless can_start_action?(index)

        action = @actions[index]
        @current_action = action
      end

      # Runs the Action prepared by #start_action with provided input
      # @param input [String] the input to pass to the Action
      # @return [Pug::Types::Result] indicating the execution result
      def run_action(input)
        return Results.no_action_running unless running_action?

        requires_input = @current_action.requires_input?
        result = @current_action.execute(requires_input ? input : nil)
        output = Output.new(@current_action.name, result || '')
        @current_action = nil
        Types::Result.success(output)
      end
    end
  end
end
