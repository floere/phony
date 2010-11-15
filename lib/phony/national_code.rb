module Phony
  
  # This is the superclass of all special national number handlers.
  #
  # NationalCodes have a LocalSplitter and a Formatter.
  #
  class NationalCodeSplitter
    
    def initialize splitter, formatter # ndcs = {}, local_format = [], service_ndcs = []
      @splitter  = splitter
      @formatter = formatter
    end
    
    # Split gets a number without country code and splits it into
    # .
    #
    def split number
      
    end
    
    def vanity? number
      
    end
    
  end
  
end