module Phony
  
  module NationalSplitters
    
    # This is a national splitter for countries
    # which have no NDC / Area Code.
    #
    class None < DSL
      
      # Get a splitter. Caches.
      #
      def self.instance_for(*)
        @instance ||= new
      end
      
      # Takes a national number and splits it into ndc and rest.
      #
      def split national_number
        [nil, national_number]
      end
      
    end
    
  end
  
end