module Phony
  
  module NationalSplitters
    
    # This is a national splitter for countries
    # which have no NDC / Area Code.
    #
    class None < Default
      
      # Get a splitter. Caches.
      #
      def self.instance_for(*)
        @instance ||= new
      end
      
    end
    
  end
  
end