module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class Fixed
      
      attr_writer :special_splitter
      
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
      end
      
      # Takes a national number and splits it into ndc and rest.
      #
      def split national_number
        return [national_number] unless @size
        [national_number.slice!(0...@size), national_number]
      end
      
    end
    
  end
  
end