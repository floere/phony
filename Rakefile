# Gemmin'

require 'rake/gempackagetask'
load 'e164.gemspec'

spec = GEMSPEC

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true 
end

# Speccin'

desc 'Run all specs'
task :spec do
  specs = Dir['spec/lib/**/*_spec.rb']
  system "ruby #{specs.join(' ')}"
end