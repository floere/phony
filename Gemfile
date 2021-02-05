source "http://rubygems.org"

gem 'rake', require: false
gem 'coveralls', require: false

group :test do
  gem 'qed'
  gem 'ae'
  gem 'rspec', '~> 2.0'
  gem 'pippi', platforms: [:mri_20, :mri_21]
end

group :release do
  gem 'gem-release'
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'json'
  gem 'rubinius-developer_tools'
end
