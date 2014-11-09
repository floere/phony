module Phony

  class TrunkCode
  
    # Parameters:
    #  * code: The trunk code, e.g. 0.
    #
    # Options:
    #  * normalize: Remove the trunk code when normalizing (only use if number scheme is defined unambiguously).
    #  * split: Remove the trunk code when splitting (only use if number scheme is defined unambiguously).
    #
    def initialize code, options = {}
      @code = code
      @trunk_code_replacement = /\A#{code.gsub(%r{%s}, '')}/
      @normalize = options[:normalize] || options[:normalize].nil?
      @split     = options[:split]
    end
    
    # Prepends itself to the other codes.
    #
    def | other
      other.codes.unshift self
      other
    end

    # Split gets a number without country code and splits it into
    # its parts.
    #
    def split national_number
      national_number.gsub! @trunk_code_replacement, EMPTY_STRING if @split
      return [@code, national_number]
    end
    
    def normalize national_number
      national_number.gsub! @trunk_code_replacement, EMPTY_STRING if @normalize
      return national_number
    end
  
  end

end