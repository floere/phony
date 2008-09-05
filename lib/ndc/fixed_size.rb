# Splits a national number into a fixed size NDC and rest.
#
module E164
  module NDC
    class FixedSize
  
      class_inheritable_accessor :format
  
      def initialize(national_code_length)
        @national_code_length = national_code_length
      end

      def split(number)
        number = number.dup
        [number.slice!(0..@national_code_length-1), number]
      end

      def formatted(number)
        (format || '%s %s') % split(number)
      end

    end
  end
end