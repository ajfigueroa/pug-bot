# frozen_string_literal: true.

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :flightcheck

desc 'Run Rubocop check for the gem'
task :cop do
  sh %{ rubocop }
end

desc 'Generate documentation'
task :document do
  sh %{ yardoc 'lib/**/*.rb' }
end
