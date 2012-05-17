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
  rescue LoadError => e
    Phony::PerformanceRatio = 0 # Ignore speed tests by default.
  end
  def performance_of &block
    GC.disable
    result = Benchmark.realtime &block
    GC.enable
    result * Phony::PerformanceRatio
  end
  
  # Allows the definition of "describe-wide" examples and describes.
  # 
  # Case for "it". Use in the describe block
  #   shared :it_should_behave_like_having_a_labels_class do
  #     response.should have_tag('.labels')
  #   end
  # Then, call it in the describe block or nested describe blocks as such
  #   it_should_behave_like_having_a_labels_class
  #
  # Case for "describe". Use in the describe block
  #   shared :describe_an_update_stream_item do
  #     before(:each) do
  #       # ...
  #     end
  #     it "bla" do
  #       response.should have_tag('.labels')
  #     end
  #   end
  # Then, call it in the describe block or nested describe blocks as such
  #   describe_an_update_stream_item
  #
  def shared(name, &block)
    self.class.class_eval do
      define_method name do
        name_ary = name.to_s.split('_')
        method_name = name_ary.first.to_sym
        descr_name  = name_ary[1..-1].join(" ")
        if [:describe, :it].include? method_name
          self.send(method_name, descr_name, &block)
        else
          raise ArgumentError, "Shared it or describe needs to start with 'it_' or 'describe_'."
        end
      end
    end
  end

  # Used to test private methods.
  #
  # The idea is to replace
  #   instance.send :private_method.
  # with
  #   in_the instance do
  #     private_method
  #   end
  #
  # Note: Now it is rather like "We have the scenario that we are in the given instance."
  #
  def in_the(instance, &block)
    instance.instance_eval(&block)
  end
  
end