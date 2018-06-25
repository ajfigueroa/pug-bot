# frozen_string_literal: true

module Pug
  # Coordinates between messages provided from Bot
  # to actions via the Controller
  class MessageHandler
    # A convenice initializer for provided actions
    # @param actions [Array<Interfaces::Action>] actions to coordinate
    # @return [MessageHandler] A new instance of MessageHandler
    def self.default(actions)
      controller = Action::Controller.new(actions)
      keyword_handler = KeywordHandler.new(actions)
      MessageHandler.new(controller, NumberParser.new, keyword_handler)
    end

    # @param controller [Action::Controller] to control Action flow
    # @param parser [NumberParser] to parse numeric text
    # @param keyword_handler [KeywordHandler] to handle keywords
    def initialize(controller, parser, keyword_handler)
      @controller = controller
      @parser = parser
      @keyword_handler = keyword_handler
    end

    # Parses and coordinates the given message with the Controller
    # @param message [String] message to handle
    # @return [Types::Result] result of handling message
    def handle(message)
      return Results.missing_actions unless @controller.actions?
      return Results.unknown_input if message.to_s.empty?
      if @controller.running_action?
        run_action_with_inputs(message)
      elsif @keyword_handler.keyword?(message)
        handle_keyword(message)
      else
        parse_message_for_index(message)
      end
    end

    private

    def can_start_action?(index)
      @controller.can_start_action?(index)
    end

    def run_action_with_inputs(inputs = nil)
      @controller.run_action(inputs || '')
    end

    def parse_message_for_index(message)
      index = @parser.number_from_text(message)
      return Results.unknown_input if index.nil?
      return Results.invalid_index(index) unless can_start_action?(index)

      @controller.start_action(index)
      request_input_if_needed(message)
    end

    def request_input_if_needed(message)
      input = @controller.action_input
      if input.required?
        Results.enter_inputs(input.action_name)
      else
        run_action_with_inputs(message)
      end
    rescue RuntimeError => ex
      Types::Result.error(ex)
    end

    def handle_keyword(keyword)
      response = @keyword_handler.run_command_for_keyword(keyword)
      return Results.unknown_input if response.nil?
      Types::Result.info(response)
    end
  end
end
