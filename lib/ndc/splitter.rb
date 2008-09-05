# Splits a national number into a fixed size NDC and rest.
#
module E164
  module NDC
    class Splitter
      
      def initialize(national_code_length)
        @national_code_length = national_code_length
      end
      
      # Formats the given E164 Number according to the country specific format / ndcs splitting.
      #
      def self.formatted(number)
        @format % split(number)
      end
      
      # Define a format for the country's ndc-rest format, converting spaces to non breaking spaces
      #
      # e.g. ITU-T E.123 recommends using
      # format '%s %s'
      #
      def self.format(format)
        @format = format.gsub(/ /, ' ')
      end
      format '%s %s %s %s'
      
      #
      #
      def self.split(number)
        number = number.dup
        [number.slice!(0..@national_code_length-1), number]
      end
      
    end
  end
end