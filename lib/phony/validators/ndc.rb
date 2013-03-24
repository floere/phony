module Phony
  
  class Validators
  
    class NDC
  
      attr_reader :invalids
  
      def initialize options = {}
        @invalids = options[:invalid] || []
      end
  
      def plausible? ndc, _
        @invalids.each do |invalid|
          return false if invalid === ndc
        end
      
        true
      end
    
    end
    
  end
  
end