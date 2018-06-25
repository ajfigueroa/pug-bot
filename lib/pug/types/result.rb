# frozen_string_literal: true

module Pug
  module Types
    # Encapsulates a sucess/failure result
    # @!attribute type
    #   @return [Integer] the type of the Result
    #   @see Result::SUCCESS
    #   @see Result::INFO
    #   @see Result::ERROR
    # @!attribute value
    #   @return [String] the value of the Result
    #   @note exists only for SUCCESS and INFO types
    # @!attribute error
    #   @return [String] the output of the Action
    #   @note exists only for ERROR type
    class Result
      attr_reader :type, :value, :error
      private_class_method :new

      # @!group Types
      SUCCESS = 0
      INFO = 1
      ERROR = 2
      # @!endgroup

      # @!visibility private
      def initialize(type, value, error)
        raise 'Invalid type' unless [SUCCESS, INFO, ERROR].include?(type)
        @type = type
        @value = value
        @error = error
      end

      # Defines a SUCCESS Result
      # @param value [String] value for Result
      # @return [Result] with value and no error
      def self.success(value)
        new(SUCCESS, value, nil)
      end

      # Defines an INFO Result
      # @param value [String] value for Result
      # @return [Result] with value and no error
      def self.info(value)
        new(INFO, value, nil)
      end

      # Defines an ERROR Result
      # @param error [String] error for Result
      # @return [Result] with error and no value
      def self.error(error)
        new(ERROR, nil, error)
      end
    end
  end
end
