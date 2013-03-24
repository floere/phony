module Phony

  module NationalSplitters
    
    # TODO Default = Fixed.new(...)?
    #
    class Default < DSL

      def self.instance_for
        @instance ||= new
      end

      def split national_number
        [national_number]
      end
      
      def plausible? rest, size, hints = {}
        true
      end
      
      # A valid length (at least 3).
      #
      def length
        3
      end

    end
  end
end
