# frozen_string_literal: true

module Pug
  # Convenience methods for common Results
  class Results
    def self.unknown_input
      Types::Result.error(Strings.unknown_input)
    end

    def self.missing_actions
      Types::Result.error(Strings.no_actions)
    end

    def self.invalid_index(index)
      Types::Result.error(Strings.unable_to_start_action(index))
    end

    def self.enter_inputs(action_name)
      Types::Result.info(Strings.enter_inputs(action_name))
    end

    def self.no_action_running
      Types::Result.error(Strings.no_action_running)
    end
  end
end
