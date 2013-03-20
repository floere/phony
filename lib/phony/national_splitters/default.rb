module Phony

  module NationalSplitters

    class Default < DSL

      def self.instance_for
        @instance ||= new
      end

      def split national_number
        [national_number]
      end
      
      # A valid length.
      #
      def length
        1
      end

    end
  end
end
