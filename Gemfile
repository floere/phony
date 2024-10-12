source 'http://rubygems.org'

gem 'rake', require: false
gem 'rubocop', '~> 1.66'
gem 'rubocop-performance'
gem 'rubocop-rake'
gem 'rubocop-rspec'

group :test do
  gem 'ae'
  gem 'pippi', platforms: [:mri_20, :mri_21]
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

# platforms :rbx do
#   gem 'rubysl'
#   gem 'json'
#   gem 'rubinius-developer_tools'
# end
