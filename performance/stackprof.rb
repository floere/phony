# frozen_string_literal: true

# Run with:
#   ruby stackprof.rb
#
require 'stackprof'
require_relative '../lib/phony'

def profile(thing, &)
  profile = StackProf.run(mode: thing.to_sym, &)
  path = "/tmp/stackprof-#{thing}-phony.dump"
  File.binwrite(path, Marshal.dump(profile))
  puts `stackprof #{path}`
end

%w[cpu object].each do |thing|
  profile thing do
    10_000.times { Phony.normalize '+81-3-9999-9999' }
  end
  profile thing do
    10_000.times { Phony.format '81399999999' }
  end
end
