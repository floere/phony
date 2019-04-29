begin
  require 'bundler'
rescue LoadError
  require 'rubygems'
  require 'bundler'
end
Bundler.setup :test
Bundler.require

# Pippi.
#
if ENV['PIPPI']
  require 'pippi'
  Pippi::AutoRunner.new(:checkset => ENV['PIPPI_CHECKSET'] || 'basic')
end

require 'coveralls'
Coveralls.wear!

# NOTE We use Kernel.load here, as we do have specs which test Phony::Config.
load File.expand_path('../../lib/phony.rb', __FILE__)