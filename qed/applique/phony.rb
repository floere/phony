require 'phony/config'

# Plausibility Helpers

# A helper which expresses the test more succinctly.
#
def plausible? examples
  # Succeeding expectations.
  #
  succeeding = [*examples[:true]]
  succeeding.each do |numbers|
    [*numbers].each do |number|
      Phony.assert.plausible?(number)
    end
  end
  
  # Generate failing examples.
  #
  fabricated_failing = succeeding.map do |s|
    s = if s.respond_to?(:to_ary)
      s.min_by { |x| x.scan(/\d/).length }
    else
      s
    end
    s.sub(/\d\s*\z/, '')
  end
  
  # Explicitly failing expectations + fabricated.
  #
  ([*examples[:false]] + fabricated_failing).each do |number|
    Phony.refute.plausible?(number)
  end
end

# Benchmarking.

# performance_of { do something here }.should < 0.0001
#
require 'benchmark'
# Try to load the Phony::PerformanceRatio from
# the file spec/performance_ratio.rb - set it to the
# ratio you think it is compared to my MacBook 2.66GHz i7.
#
# Example:
#   Phony::PerformanceRatio = 0.8 # for 80% of my MacBook speed.
#
begin
  require File.expand_path '../performance_ratio', __FILE__
rescue LoadError
  Phony::PerformanceRatio = 0 # Ignore speed tests by default.
end
def performance_of &block
  GC.disable
  result = Benchmark.realtime(&block)
  GC.enable
  result * Phony::PerformanceRatio
end