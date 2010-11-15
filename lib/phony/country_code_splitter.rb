module Phony
  
  # Handles determining the correct national code handler.
  #
  class CountryCodeSplitter
    
    def initialize
      
    end
    
    def split number
      national_handler, cc, rest = split_cc number
      [cc, *national_handler.split(rest)]
    end
    
    def normalize number
      
    end
    
    def formatted number
      
    end
    
    def vanity? number
      national_handler, _, _ = split_cc number
      national_handler.vanity? number
    end
    
    
    
    # # Removes 0s from partially normalized numbers such as:
    # # 410443643533
    # # 
    # # Example:
    # #   410443643533 -> 41443643533
    # #
    # def self.remove_relative_zeros! number
    #   
    #   '%s%s' % split_cc(number).collect! { |code| code.gsub(/^0+/, '') }
    # end
    
    def split_cc number
      rest = phone_number.dup
      presumed_cc = ''
      1.upto(3) do |i|
        presumed_cc << rest.slice!(0..0)
        national_code_handler = mapping[i][presumed_cc]
        return [national_code_handler, presumed_cc, rest] if national_code_handler
      end
      # TODO raise
    end
    
    # 
    #
    def fixed size, options = {}
      local_format = options[:local] || [13] # Default is no format.
      
      splitter  = FixedNationalCodeSplitter.new size
      formatter = 
      
      NationalCode.new splitter, formatter
    end
    def mapping
      @mapping ||= {
        
      }
    end
    
  end
  
end