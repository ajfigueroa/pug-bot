# frozen_string_literal: true

require 'pug'
require_relative './actions/hello_world_action'

Pug.configure do |config|
  config.type = Pug::Configuration::TELEGRAM
  config.token = ENV['TELEGRAM_TOKEN']
  config.chat_id = ENV['TELEGRAM_CHAT_ID']
  config.actions = [HelloWorldAction.new]
end

Pug::Bot.run
