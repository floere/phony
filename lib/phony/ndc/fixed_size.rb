# Splits a national number into a fixed size NDC and rest.
#
module Phony
  module NDC
    
    def self.fixed(national_code_length = 2, options = {})
      klass = Class.new FixedSize
      split_sizes, service_ndcs = klass.extract options
      klass.service_ndc_strategy Phony::NDC::ServiceNdcStrategy.new(national_code_length, service_ndcs)
      klass.fixed_ndc_strategy Phony::NDC::FixedNdcStrategy.new(national_code_length, split_sizes)
      klass.format options[:format] || '%s%s%s%s%s'
      klass.local_format split_sizes
      klass
    end
    
    class FixedSize < Splitter
      
      def self.extract options
        [options[:local] || [3, 2, 2], options[:service_ndcs] || []]
      end
      
      # Sets the strategy object to handle service numbers
      def self.service_ndc_strategy strategy 
        @service_ndc_strategy = strategy
      end
      
      # Sets the strategy object to handle normal numbers (non service)
      def self.fixed_ndc_strategy strategy
        @fixed_ndc_strategy = strategy
        @ndc_strategy = @fixed_ndc_strategy
      end
        
      # Returns true if the number is a service number
      def self.service_ndc? number
        @service_ndc_strategy.service_ndc? number
      end
      
      # Define a format for the country's national format.
      #
      # Default is NN followed by a space.
      #
      def self.ndc_format
        @ndc_format || @ndc_format = @ndc_strategy.ndc_format
      end
      
      # A faster split method than the prefix splitter offers.
      #
      def self.split_ndc number
        number = number.dup
        @ndc_strategy = if service_ndc? number
          @service_ndc_strategy
        else
          @fixed_ndc_strategy
        end
        @ndc_strategy.split_ndc number
      end
      
      def self.split_local number
        @ndc_strategy.split_local number
      end
            
    end
    
    # Base class for all Strategies
    class NdcStrategy
      attr_reader :split_sizes
      
      def initialize national_code_length, split_sizes
        @national_code_length = national_code_length
        @split_sizes = split_sizes
      end

      def split_local number
        local = []
        split_sizes.each do |size|
          local << number.slice!(0..size-1)
          break if number.empty?
        end
        local
      end

      def ndc_format
        '%s' + (@national_code_length == 0 ? '' : '%s')
      end
      
    end
    
    class ServiceNdcStrategy < NdcStrategy
      def initialize national_code_length, service_ndcs
        super national_code_length, [2, 2, 2]
        @service_ndcs = service_ndcs.flatten
        @service_ndc_regexp = Regexp.compile "^(#{@service_ndcs.join('|')})"
      end
      
      def service_ndc? number
        @service_ndcs && !@service_ndcs.empty? && @match = @service_ndc_regexp.match(number)
      end
      
      def split_ndc number
        [number.slice!(0..@match[0].length-1), number]
      end
    end
    
    class FixedNdcStrategy < NdcStrategy

      def split_ndc number
        @national_code_length.zero? ? ['', number] : [number.slice!(0..@national_code_length-1), number]
      end
      
    end
    
  end
end