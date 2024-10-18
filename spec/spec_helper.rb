begin
  require 'bundler'
rescue LoadError
  require 'rubygems'
  require 'bundler'
end
Bundler.setup :test
Bundler.require

unless ENV['NO_COVERAGE']
  require 'simplecov'
  require 'simplecov-console'
  require 'simplecov-cobertura'

  SimpleCov.minimum_coverage 90

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::CoberturaFormatter,
      SimpleCov::Formatter::Console
    ]
  )

  SimpleCov.start
end

# Pippi.
#
if ENV['PIPPI']
  require 'pippi'
  Pippi::AutoRunner.new(checkset: ENV['PIPPI_CHECKSET'] || 'basic')
end

# NOTE: We use Kernel.load here, as we do have specs which test Phony::Config.
load File.expand_path('../lib/phony.rb', __dir__)
