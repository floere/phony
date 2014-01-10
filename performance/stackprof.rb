# Run with:
#   ruby stackprof.rb
#
require 'stackprof'
require_relative '../lib/phony'

%w|cpu object|.each do |thing|
  profile = StackProf.run(mode: thing.to_sym) do
    10000.times { Phony.normalize "+81 08 123 12 12" }
  end
  path = "/tmp/stackprof-#{thing}-phony.dump"
  File.open(path, 'wb'){ |f| f.write Marshal.dump(profile) }
  puts `stackprof #{path}`
end
# %w|cpu object|.each do |thing|
#   profile = StackProf.run(mode: thing.to_sym) do
#     10000.times { people.search 'florian' }
#   end
#   path = "/tmp/stackprof-#{thing}-picky.dump"
#   File.open(path, 'wb'){ |f| f.write Marshal.dump(profile) }
#   puts `stackprof #{path}`
# end