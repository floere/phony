module Phony
  
  module NationalSplitters
    
    # This is simply for experiments.
    #
    # TODO Rename.
    #
    class DSL
      
      # TODO Or call it or?
      #
      def >> local_splitter
        ary = [self, local_splitter]
        class << ary
          def |(other)
            self + other
          end
        end
        ary
      end
      
    end
    
  end
  
end