module Phony

  module NationalSplitters
    
    # TODO Default = Fixed.new(...)?
    #
    class Default < DSL

      def self.instance_for
        @instance ||= new
      end
      
      # "Splits" the national part of a phone number into a single piece.
      #
      # @param [String] national_number An national part of a number.
      #
      # @return [Array<String>] An Array with the given number part as its element.
      #
      # @example Split the national part of a Swiss number.
      #   Phony.split("1234567") # => ["1234567"]
      #
      def split national_number
        [nil, national_number]
      end
      
      # By default, the national part of a number is always plausible.
      #
      # @param [String] rest An national part of a number (ignored).
      # @param [Fixnum] size Size (ignored).
      # @param [Hash] hints Hints (ignored).
      #
      # @return [Boolean] Always true.
      #
      # @example Split the national part of a Swiss number.
      #   Phony.plausible?("1234567") # => true
      #
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
