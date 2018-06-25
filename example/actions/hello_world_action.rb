# frozen_string_literal: true

require 'pug'

class HelloWorldAction < Pug::Interfaces::Action
  def name
    'Hello, World'
  end

  def requires_input?
    true
  end

  def execute(input)
    "Hello, #{input}"
  end
end
