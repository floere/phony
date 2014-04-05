begin
  require 'bundler'
rescue LoadError
  require 'rubygems'
  require 'bundler'
end
Bundler.setup :test
Bundler.require

require 'coveralls'
Coveralls.wear!

require File.expand_path '../../lib/phony', __FILE__

require 'spec_helper_extensions'
include SpecHelperExtensions