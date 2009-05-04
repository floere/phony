# Splits a national number into a fixed size NDC and rest.
#
module E164
  module NDC
    
    def self.fixed(national_code_length = 2, options = {})
      klass = Class.new FixedSize
      klass.national_code_length = national_code_length
      klass.format options[:format] || '%s %s %s'
      klass.local options[:local] || [3, 2, 2]
      klass
    end
    
    class FixedSize < Splitter
      
      def self.national_code_length= length
        @national_code_length = length
      end
      
      # Define a format for the country's national format.
      #
      # Default is NN followed by a space.
      #
      def self.ndc_format
        @ndc_format || @ndc_format = '%s' + (@national_code_length == 0 ? '' : ' ')
      end
      
      # A faster split method than the prefix splitter offers.
      #
      def self.split_ndc(number)
        number = number.dup
        @national_code_length.zero? ? ['', number] : [number.slice!(0..@national_code_length-1), number]
      end
      
    end
  end
end