# frozen_string_literal: true

module Pug
  # Convenience methods for user facing strings
  class Strings
    def self.no_action_running
      'There is no action currently running.'
    end

    def self.error_occurred
      'An error occurred acting on your action'
    end

    def self.finished_running(action_name)
      "Finished running #{action_name}"
    end

    def self.unable_to_start_action(index)
      "Unable to start action at index: #{index}"
    end

    def self.enter_inputs(action_name)
      "Enter inputs for #{action_name}"
    end

    def self.unknown_input
      "Sorry, I don't understand that input."
    end

    def self.no_actions
      'There are no actions available to run. Did you set some up?'
    end

    def self.help(commands)
      "These are available commands:\n#{commands}"
    end
  end
end
