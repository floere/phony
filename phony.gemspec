Gem::Specification.new do |s|
  s.name = 'phony'
  s.version = '2.18.5'
  s.authors = ['Florian Hanke']
  s.email = 'florian.hanke+phony@gmail.com'
  s.homepage = 'http://github.com/floere/phony'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Fast international phone number (E164 standard) normalizing, splitting and formatting.'
  s.description = "Fast international phone number (E164 standard) normalizing, splitting and formatting. Lots of formatting options: International (+.., 00..), national (0..), and local."
  s.files = Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*spec.rb"]
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.textile"]
end
