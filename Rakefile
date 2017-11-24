# Specs.
#
require 'rspec'
require 'rspec/core/rake_task'

# desc 'Run specs'
# RSpec::Core::RakeTask.new :spec do |t|
#   t.ruby_opts = ['-w']
# end
task :spec do |t|
  puts 'Running RSpec'
  system 'rspec'
  puts
end

desc 'Run QED'
task :qed do
  puts 'Running QED'
  system 'qed'
  puts
end

desc 'Run the complete test suite'
task :test => [:qed, :spec]

task :default => :test
