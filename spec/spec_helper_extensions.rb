module SpecHelperExtensions
  
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
  
end
