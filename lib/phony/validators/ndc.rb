module Phony
  
  class Validators
  
    class NDC
  
      attr_reader :invalids
  
      def initialize
        @invalids = []
      end
  
      def plausible? ndc, rest
        @invalids && @invalids.each do |invalid|
          return false if invalid === ndc
        end
      
        true
      end
  
      def invalid ndc
        @invalids << ndc
        self
      end
    
    end
    
  end
  
end