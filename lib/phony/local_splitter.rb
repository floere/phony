module Phony
  
  # Local splitter class to split the last part of
  # a number, i.e. minus cc or ndc.
  #
  # Countries can create new instances according to their needs.
  #
  # Note: Countries should use instance_for to avoid getting new
  #
  class LocalSplitter
    
    @mapping = {}
    
    # Get a splitter for the given format.
    #
    # Caches the created splitter for the given format.
    #
    def self.instance_for format
      @mapping[format] ||= new(format)
    end
    
    def initialize format
      @format = format
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
    
  end
  
end