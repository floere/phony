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
      
      # A valid length.
      #
      def length
        1
      end

    end
  end
end
