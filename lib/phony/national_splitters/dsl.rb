module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class DSL
      
      #
      #
      def >> local_splitter
        country_for local_splitter
      end
      
      #
      #
      def country_for local_splitter
        Phony::Country.new Phony::NationalCode.new(self, local_splitter)
      end

      # TODO Remove?
      #
      def reserved

      end
      
    end
    
  end
  
end