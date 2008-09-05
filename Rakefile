require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = 'E164'
  s.version = '0.0.1'
  s.author = 'Florian Hanke'
  s.email = 'florian.hanke+e164@gmail.com'
  s.homepage = 'florianhanke.blogspot.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'E164 Number Splitting and Formatting'
  s.files = Dir["lib/**/*"]
  s.require_path = 'lib'
  # s.autorequire = "e164"
  s.test_files = Dir["spec/**/*spec.rb"]
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
  # s.add_dependency("dependency", ">= 0.x.x")
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 
