GEMSPEC = Gem::Specification.new do |s| 
  s.name = 'e164'
  s.version = '1.0.1'
  s.author = 'Florian Hanke'
  s.email = 'florian.hanke+e164@gmail.com'
  s.homepage = 'http://github.com/floere'
  s.platform = Gem::Platform::RUBY
  s.summary = 'E164 Number Splitting and Formatting'
  s.files = Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*spec.rb"]
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.textile"]
end