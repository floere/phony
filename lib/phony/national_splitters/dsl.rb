module Phony
  
  module NationalSplitters
    
    # TODO
    #
    class DSL
      
      # TODO normalize option!
      #
      def >> local_splitter
        national_code = Phony::NationalCode.new self, local_splitter
        Phony::Country.new national_code
      end
      
    end
    
  end
  
end