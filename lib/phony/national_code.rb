module Phony
  
  # This is the superclass of all special national number handlers.
  #
  # NationalCodes have a NationalCodeSplitter and a LocalCodeSplitter.
  #
  class NationalCode
    
    # ndcs = {}, local_format = [], service_ndcs = []
    #
    def initialize national_splitter, local_splitter
      @national_splitter = national_splitter
      @local_splitter    = local_splitter
    end
    
    # Split gets a number without country code and splits it into
    # its parts.
    #
    def split national_number
      ndc, rest = @national_splitter.split national_number
      [ndc, *@local_splitter.split(rest)]
    end
    
    def service? national_number
      @national_splitter.service? national_number
    end
    def mobile? national_number
      @national_splitter.mobile? national_number
    end
    def landline? national_number
      !mobile?(ndc) && !service?(ndc)
    end
    
    # Is this national number a vanity number?
    #
    def vanity? national_number
      Vanity.vanity? national_number
    end
    def vanity_to_number vanity_number
      
    end
    
  end
  
end