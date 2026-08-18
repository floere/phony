source 'http://rubygems.org'

gem 'rake', require: false

group :test do
  gem 'ae'
  gem 'benchmark'
  gem 'pippi', platforms: %i[mri_20 mri_21]
  gem 'qed'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
  gem 'simplecov-console', require: false
  gem 'rexml'
end

group :release do
  gem 'gem-release'
end

platforms :ruby do
  gem 'rubocop', '~> 1.66'
  gem 'rubocop-performance'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

# platforms :rbx do
#   gem 'rubysl'
#   gem 'json'
#   gem 'rubinius-developer_tools'
# end
