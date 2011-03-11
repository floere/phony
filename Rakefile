# Specs.
#
require 'rake'

require 'rspec'
require 'rspec/core/rake_task'

spec_root = File.join File.dirname(__FILE__), 'spec'
desc "Run specs"
RSpec::Core::RakeTask.new :spec

task :default => :spec