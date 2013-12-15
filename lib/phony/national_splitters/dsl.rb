module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class DSL
      
      #
      #
      def >> local_splitter
        if local_splitter.respond_to? :split
          country_for local_splitter, true
        else
          local_splitter.national_splitter = self
          local_splitter
        end
      end
      
      def country_for local_splitter, normalize, trunk = '0'
        Phony::Country.new Phony::NationalCode.new(self, local_splitter, normalize, trunk)
      end
      
    end
    
  end
  
end