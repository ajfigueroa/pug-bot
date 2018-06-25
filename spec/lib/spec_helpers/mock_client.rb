# frozen_string_literal: true

require 'pug'

class MockClient < Pug::Interfaces::Client
  attr_accessor :message_queue, :sent_messages

  def initialize
    @sent_messages = []
    @message_queue = []
  end

  # Overrides
  def listen
    queue = @message_queue
    yield queue.shift until queue.empty?
  end

  def send_message(message)
    @sent_messages.push(message)
  end

  # Helpers
  def enqueue_message(message)
    @message_queue.push(message)
  end

  def last_sent_message
    return nil if @sent_messages.empty?
    @sent_messages.pop
  end
end
