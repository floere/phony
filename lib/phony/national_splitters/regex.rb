module Phony
  
  module NationalSplitters
    
    # National splitter class to split the ndc-local part of a number.
    #
    # Countries can create new instances according to their needs.
    #
    # Note: Countries should use instance_for
    #       to avoid getting new local splitter instances.
    #
    class Regex < Fixed
      
      attr_reader :max_length, :regex
      
      # Get a splitter for the given format.
      #
      # Note: Not cached.
      #
      def self.instance_for regex, max_length = nil
        new regex, max_length
      end
    
      # Initialize with a regex => format mapping.
      #
      def initialize regex, max_length = nil
        @max_length = max_length
        @regex      = regex
      end
    
      # Split a local number according to an assumed country specific format.
      #
      # Examples
      # * split '3643533' # => ['364', '35', '33'] # (Switzerland)
      #
      def split number
        return [number.slice!(0..max_length-1), number] if number =~ regex
        
        # Not found.
        #
        super max_length
      end
      
    end
    
  end
  
end