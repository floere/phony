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
      
      attr_reader :on_fail_take, :regex
      
      # Get a splitter for the given format.
      #
      # Note: Not cached.
      #
      def self.instance_for regex, on_fail_take = nil, options = {}
        new regex, on_fail_take, options
      end

      def initialize regex, on_fail_take = nil, options = {}
        super on_fail_take, options

        @regex = regex
      end
    
      # Split a local number according to an assumed country specific format.
      #
      # Examples
      # * split '3643533' # => ['364', '35', '33'] # (Switzerland)
      #
      def split national_number
        # Improve matching.
        #
        return [@zero, national_number.slice!(0..$1.size-1), national_number] if national_number =~ regex
        
        # Not found.
        #
        super national_number
      end
      
      # A valid length.
      #
      def length
        # raise "#{self.class.name} has no length that can be automatically extracted."
      end
      
    end
    
  end
  
end