# Run with:
#   ruby stackprof.rb
#
require 'stackprof'
require_relative '../lib/phony'

def profile thing, &block
  profile = StackProf.run mode: thing.to_sym, &block
  path = "/tmp/stackprof-#{thing}-phony.dump"
  File.open(path, 'wb'){ |f| f.write Marshal.dump(profile) }
  puts `stackprof #{path}`
end

%w[cpu object].each do |thing|
  profile thing do
    10000.times { Phony.normalize '+81-3-9999-9999' }
  end
end
%w[cpu object].each do |thing|
  profile thing do
    10000.times { Phony.format '81399999999' }
  end
end