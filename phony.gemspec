Gem::Specification.new do |s|
  s.name = 'phony'
  s.version = '1.0.0'
  s.authors = ['Florian Hanke', 'Andreas Schacke']
  s.email = 'florian.hanke+phony@gmail.com'
  s.homepage = 'http://github.com/floere/phony'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Phony Number Splitting and Formatting'
  s.files = Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*spec.rb"]
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.textile"]
end