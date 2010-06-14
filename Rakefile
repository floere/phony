# Gemmin'
require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'


load 'e164.gemspec'

spec = GEMSPEC

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true 
end

# Speccin'
desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new() do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end
