# frozen_string_literal: true

module SpecHelperExtensions
  # performance_of { do something here }.should < 0.0001
  #
  require 'benchmark'
  # Try to load the Phony::PERFORMANCE_RATIO from
  # the file spec/performance_ratio.rb - set it to the
  # ratio you think it is compared to my MacBook 2.66GHz i7.
  #
  # Example:
  #   Phony::PERFORMANCE_RATIO = 0.8 # for 80% of my MacBook speed.
  #
  begin
    require File.expand_path 'performance_ratio', __dir__
  rescue LoadError
    # Ignore speed tests by default.
    Phony::PERFORMANCE_RATIO = 0 unless Phony.constants.include?(:PERFORMANCE_RATIO)
  end
  def performance_of(&)
    GC.disable
    result = Benchmark.realtime(&)
    GC.enable
    result * Phony::PERFORMANCE_RATIO
  end
end
