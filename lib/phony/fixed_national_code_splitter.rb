module Phony
  
  class FixedNationalCodeSplitter
    
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
    
    # Takes a national number and
    #
    def split number
      [number.slice!(0...number.length-1), number]
    end
    
  end
  
end