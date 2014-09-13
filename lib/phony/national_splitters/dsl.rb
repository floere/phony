module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class DSL
      
      #
      #
      def >> local_splitter
        if local_splitter.respond_to? :split
          country_for local_splitter
        else
          local_splitter.national_splitter = self
          local_splitter
        end
      end
      
      def country_for local_splitter
        Phony::Country.new Phony::NationalCode.new(self, local_splitter)
      end
      
      def reserved
        
      end
      
    end
    
  end
  
end