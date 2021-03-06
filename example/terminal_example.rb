# frozen_string_literal: true

require 'pug'
require_relative './actions/hello_world_action'

Pug.configure do |config|
  config.type = Pug::Configuration::TERMINAL
  config.actions = [HelloWorldAction.new]
end

Pug::Bot.run
