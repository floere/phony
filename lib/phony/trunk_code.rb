module Phony

  class TrunkCode
  
    def initialize code, options = {}
      @trunk_code_replacement = /\A#{code}/
      @normalize = options[:normalize] != false
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
      return [nil, national_number]
    end
    
    def normalize national_number
      return national_number unless @normalize
      national_number.gsub @trunk_code_replacement, EMPTY_STRING
    end
  
  end

end