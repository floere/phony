module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class Fixed < DSL
      
      attr_writer :special_splitter
      
      @mapping = {}
      
      # Get a splitter for the given format.
      #
      # Caches the created splitter for the given format.
      #
      def self.instance_for *parameters
        @mapping[parameters] ||= new(*parameters)
      end
      
      def initialize size, options = {}
        @size = size
        @zero = nil # options[:zero] == false ? nil : '0'
      end
      
      # Takes a national number and splits it into ndc and rest.
      #
      def split national_number
        return [@zero, national_number] unless @size
        [@zero, national_number.slice!(0...@size), national_number]
      end
      
      # A valid length.
      #
      def length
        @size
      end
      
    end
    
  end
  
end