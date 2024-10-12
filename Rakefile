# Specs.
#
require 'rspec'
require 'rspec/core/rake_task'

task :test do
  puts 'Running RSpec & QED'
  abort unless system 'bundle exec qed && bundle exec rspec'
end

task default: :test
