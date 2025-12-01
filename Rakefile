require 'rspec'
require 'rspec/core/rake_task'

desc 'Run RSpec and QED tests'
task :test do
  puts 'Running RSpec & QED'
  abort unless system 'bundle exec qed && bundle exec rspec'
end

task default: :test
