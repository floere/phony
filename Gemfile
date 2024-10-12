source "http://rubygems.org"

gem 'rake', require: false
gem 'coveralls', require: false

group :test do
  gem 'qed'
  gem 'ae'
  gem 'rspec'
  gem 'pippi', platforms: [:mri_20, :mri_21]
end

group :release do
  gem 'gem-release'
end

# platforms :rbx do
#   gem 'rubysl'
#   gem 'json'
#   gem 'rubinius-developer_tools'
# end

gem 'rubocop', '~> 1.66'
gem 'rubocop-performance'
gem 'rubocop-rspec'
