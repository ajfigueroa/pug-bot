# frozen_string_literal: true

require 'pug/action/controller'
require 'pug/action/enumerator'
require 'pug/action/input'
require 'pug/action/output'
require 'pug/clients/factory'
require 'pug/interfaces/action'
require 'pug/interfaces/client'
require 'pug/types/result'
require 'pug/bot'
require 'pug/configuration'
require 'pug/keyword_handler'
require 'pug/message_handler'
require 'pug/number_parser'
require 'pug/results'
require 'pug/strings'
require 'pug/telegram_client'
require 'pug/terminal_client'
require 'pug/version'

# An automation framework for repetitive dev tasks
# @!attribute configuration
#   @return [Configuration] the Pug config object
module Pug # :nodoc:
  class << self
    attr_writer :configuration
  end

  # Grabs the current Pug configuration
  # @return [Configuration] the Pug config object
  def self.configuration
    default_type = Configuration::TELEGRAM
    @configuration ||= Configuration.new(default_type)
  end

  # @yieldparam [Configuration] configuration
  def self.configure
    yield(configuration)
  end
end
