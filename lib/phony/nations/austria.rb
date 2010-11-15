# Splits a national number into a fixed size NDC and rest.
#
module Phony
  module Nations
    class Austria < Phony::NationalCode
      
      def initialize
        splitter  = 
        formatter = Formatter.new
        
        super splitter, formatter
      end
      
    end
  end
end