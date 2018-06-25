# frozen_string_literal: true.

require 'pug/version'
require 'yard'

desc 'Prepares and installs gem'
task :prepare do
  sh %{ gem build pug-bot.gemspec }
  sh %{ gem install pug-bot-#{Pug::VERSION}.gem }
end

desc 'Run tests for the gem'
task :test do
  sh %{ rspec spec }
end

desc 'Run Rubocop check for the gem'
task :cop do
  sh %{ rubocop }
end

desc 'Verify everything is good before merge'
task :flightcheck => [:cop, :test] do
end

desc 'Generate documentation'
task :document do
  sh %{ yardoc 'lib/**/*.rb' }
end
