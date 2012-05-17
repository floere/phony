module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class DSL
      
      #
      #
      def >> local_splitter
        country_for local_splitter, true
      end
      
      private
      
        def country_for local_splitter, with_zero
          national_code = Phony::NationalCode.new self, local_splitter, with_zero
          Phony::Country.new national_code
        end
      
    end
    
  end
  
end