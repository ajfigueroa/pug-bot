lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pug/version'

Gem::Specification.new do |s|
  s.name          = 'pug-bot'
  s.version       = Pug::VERSION
  s.authors       = ['Alex Figueroa']
  s.email         = 'alexjfigueroa [ at ] gmail [ dot ] com'

  s.summary       = 'An automation framework for repetitive dev tasks'
  s.homepage      = 'https://github.com/ajfigueroa/pug-bot'
  s.license       = 'MIT'

  s.files         = Dir['lib/**/*'] + %w(Gemfile LICENSE README.md Rakefile pug-bot.gemspec)
  s.test_files    = Dir['spec/**/*']
  s.require_paths = ['lib']
  s.executables   << 'pug'

  s.required_ruby_version = '>= 2.3'

  s.add_runtime_dependency 'telegram-bot-ruby', '~> 0.8.6'

  s.add_development_dependency 'rspec', '~> 3.7.0'
  s.add_development_dependency 'rubocop', '~> 0.53.0'
  s.add_development_dependency 'yard', '~> 0.9.2'
  s.add_development_dependency 'rake', '~> 10.4.2'
end
