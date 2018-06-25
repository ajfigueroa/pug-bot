# frozen_string_literal: true

module Pug
  module Action
    # Formats actions to an enumerated text representation
    class Enumerator
      # Enumerates Action names with an optional description
      # @param actions [Array<Interfaces::Action>] Action names to enumerate
      # @param show_description [Boolean] optional flag that adds descriptions
      # @return [Array<String>] enumerated names with optional description
      def names(actions, show_description = false)
        return [] if actions.nil?
        actions.each_with_index.map do |action, index|
          if show_description && !action.description.to_s.empty?
            "#{index}: #{action.name} # #{action.description}"
          else
            "#{index}: #{action.name}"
          end
        end
      end

      # Enumerates and groups Action names into a 2D array
      # @param actions [Array<Interfaces::Action>] Action names to enumerate
      # @param group_size [Integer] optional count indicating subarray size
      # @return [Array<Array<String>>] enumerated and grouped names
      # @note This does not support descriptions at the moment
      def grouped_names(actions, group_size = 2)
        return [] if group_size <= 0
        names(actions).each_slice(group_size).to_a
      end
    end
  end
end
