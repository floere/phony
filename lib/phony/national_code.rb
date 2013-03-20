module Phony

  # NationalCodes have a special numbers splitter, a national code splitter and a local code splitter.
  #
  class NationalCode
    
    attr_reader :local_splitter
    
    #
    #
    def initialize national_splitter, local_splitter, normalize = nil, trunk_code = '0'
      @national_splitter = national_splitter
      @local_splitter    = local_splitter
      @normalize         = normalize != false
      @trunk_code        = trunk_code
    end

    # Split gets a number without country code and splits it into
    # its parts.
    #
    def split national_number
      zero, ndc_or_rest, rest = @national_splitter.split national_number.dup
      return [zero, ndc_or_rest] unless rest
      [zero, ndc_or_rest, *@local_splitter.split(rest)]
    end

    # Split gets a number without country code and removes a relative zero.
    #
    # Note: Some cases, like Italy, don't remove the relative zero.
    #
    def normalize national_number
      return national_number unless @normalize
      national_number.gsub(/^#{@trunk_code}+/, '')
    end

  end

end