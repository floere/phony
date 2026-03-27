# frozen_string_literal: true

# Rubinius profiling.
# Run with:
#   ruby -Xprofiler.full_report -Xprofiler.graph performance/rubinius.rb

require 'rubinius/profiler'
require_relative '../lib/phony'

def profile
  profiler = Rubinius::Profiler::Instrumenter.new

  profiler.start

  yield

  profiler.stop

  profiler.show # takes on IO object, defaults to STDOUT
end

profile { 10_000.times { Phony.normalize '+81-3-9999-9999' } }
profile { 10_000.times { Phony.format '81399999999' } }
profile { 10_000.times { Phony.plausible? '+81-3-9999-9999' } }
