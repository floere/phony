module Phony
  
  # NationalCodes have a special numbers splitter, a national code splitter and a local code splitter.
  #
  class NationalCode
    
    #
    #
    def initialize national_splitter, local_splitter, normalize = nil
      @national_splitter = national_splitter
      @local_splitter    = local_splitter
      @normalize         = normalize != false
    end
    
    # Split gets a number without country code and splits it into
    # its parts.
    #
    def split national_number
      ndc, rest = @national_splitter.split national_number.dup
      return ndc unless rest
      [ndc, *@local_splitter.split(rest)]
    end
    
    # Split gets a number without country code and removes a relative zero.
    #
    # Note: Some cases, like Italy, don't remove the relative zero.
    #
    def normalize national_number
      return national_number unless @normalize
      national_number.gsub(/^0+/, '')
    end
    
  end
  
end