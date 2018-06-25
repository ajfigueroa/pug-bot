# frozen_string_literal: true

require 'pug'

class MockAction < Pug::Interfaces::Action
  attr_accessor :mock_name,
                :mock_requires_input,
                :mock_output,
                :mock_description

  def initialize(
    name = nil,
    requires_input = nil,
    output = nil,
    description = nil
  )
    @mock_name = name || ''
    @mock_requires_input = requires_input || false
    @mock_output = output || ''
    @mock_description = description || ''
  end

  # Action Interface
  def name
    @mock_name
  end

  def description
    @mock_description
  end

  def requires_input?
    @mock_requires_input
  end

  def execute(___)
    @mock_output
  end
end
