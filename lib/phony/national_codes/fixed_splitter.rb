module Phony
  
  module NationalCodes
    
    class FixedSplitter
      
      attr_writer :service_ndcs, :mobile_ndcs
      
      @mapping = {}
      
      # Get a splitter for the given format.
      #
      # Caches the created splitter for the given format.
      #
      def self.instance_for size
        @mapping[size] ||= new(size)
      end
      
      def initialize size
        @size = size
        @service_ndcs = []
        @mobile_ndcs  = []
      end
      
      # Takes a national number and splits it into ndc and rest.
      #
      def split national_number
        [national_number.slice!(0...@size), national_number]
      end
      
      
      def service? number
        ndc, _ = split number
        @service_ndcs.include? ndc
      end
      def mobile? number
        ndc, _ = split number
        @mobile_ndcs.include? ndc
      end
      def landline? number
        ndc, _ = split number
        !mobile?(ndc) && !service?(ndc)
      end
      
    end
    
  end
  
end