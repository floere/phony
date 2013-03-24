module Phony
  
  module LocalSplitters
    
    # Local splitter class to split the last part of
    # a number, i.e. minus cc or ndc.
    #
    # Countries can create new instances according to their needs.
    #
    # Note: Countries should use instance_for
    #       to avoid getting new local splitter instances.
    #
    class Fixed
    
      @mapping = {}
    
      # Get a splitter for the given format.
      #
      # Caches the created splitter for the given format.
      #
      def self.instance_for format = nil
        @mapping[format] ||= new(format)
      end
    
      # Initialize with a local format, like [3, 2, 2] (also the default).
      #
      # The format [3, 2, 2] splits a number like '3332222' into ['333', '22', '22'].
      #
      def initialize format = nil
        @format = format && format.dup || [3, 2, 2]
        # @format << @format.pop + 10 # Allow for call-through numbers with an arbitrary size.
      end
    
      # Split a local number according to an assumed country specific format.
      #
      # Examples
      # * split '3643533' # => ['364', '35', '33'] # (Switzerland)
      #
      def split number
        @format.inject([]) do |result, size|
          result << number.slice!(0..size-1)
          return result if number.empty?
          result
        end
      end
      
      # TODO Fix length fudging.
      #
      def plausible? rest, hints = {}
        (length > 10 ? length - 10 : length) === rest.inject(0) { |total, part| total + part.size }
      end
      
      # A valid length.
      #
      def length
        @length ||= @format.inject { |total, part| total + part }
      end
      
    end
    
  end
  
end