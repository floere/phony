# Gemmin'

require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = 'e164'
  s.version = '0.0.4'
  s.author = 'Florian Hanke'
  s.email = 'florian.hanke+e164@gmail.com'
  s.homepage = 'github.com/floere'
  s.platform = Gem::Platform::RUBY
  s.summary = 'E164 Number Splitting and Formatting'
  s.files = Dir["lib/**/*.rb"]
  s.test_files = Dir["spec/**/*spec.rb"]
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end

# Speccin'

desc 'Run all specs'
task :spec do
  specs = Dir['spec/lib/**/*_spec.rb']
  system "ruby #{specs.join(' ')}"
end