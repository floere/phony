module Phony

  #
  #
  class Country
    
    attr_reader :format, :space, :local_space
    attr_accessor :codes

    #
    #
    def initialize *codes
      @codes = codes
    end

    # Chain two codes together.
    #
    def | other
      self.codes = self.codes + other.codes
      self
    end

    # Options.
    #
    # TODO Rewrite.
    #
    def with cc, options = {}
      @cc           = cc
      @invalid_ndcs = options[:invalid_ndcs] || []
      @format       = options[:format]
      @space        = options[:space]
      @local_space  = options[:local_space]
    end

    # A number is split with the code handlers as given in the initializer.
    #
    # Note: If the ndc is nil, it will not return it.
    #
    def split national_number
      trunk = nil
      @codes.each do |code|
        new_trunk, ndc, *rest = code.split national_number
        trunk ||= new_trunk
        return [trunk, ndc, *rest] if rest && !rest.empty?
      end
      # Best effort in error case.
      #
      [trunk, national_number, []]
    end
    def split_ndc national_number
      @codes.each do |code|
        zero, ndc, *rest = code.split national_number
        return [code.local_splitter, zero, ndc, *rest] if rest && !rest.empty?
      end
    end

    # Cleans all non-numeric characters.
    #
    @@basic_cleaning_pattern = /\(0\)|\D/
    # Clean number of all non-numeric characters and return a copy.
    #
    def clean number
      clean! number && number.dup
    end
    # Clean number of all non-numeric characters and return it.
    #
    def clean! number
      number.gsub!(@@basic_cleaning_pattern, EMPTY_STRING) || number
    end

    # Removes 0s from partially normalized numbers
    # such as 410443643533.
    #
    # Example:
    #   410443643533 -> 41443643533
    #
    # In some cases it doesn't, like Italy.
    #
    def normalize national_number
      clean! national_number
      normalized = @codes.reduce national_number do |number, code|
        result = code.normalize number
        break result if result
        number
      end
      normalized
    end

    # Tests for plausibility of this national number.
    #
    def plausible? rest, hints = {}
      local, _, ndc, *rest = split_ndc rest

      # Element based checking.
      #
      # Note: ndc == false means the country has none.
      #
      return false if ndc.nil?
      return false if ndc && ndc.empty?
      return false if @invalid_ndcs.include? ndc # TODO Refactor.

      # # A valid range for the rest is 0 or 3+ total digits.
      # #
      # return false if (1..2) === rest_size

      # National destination code plausible?
      #
      ndc_needed = hints[:ndc]
      return false if ndc_needed && !(ndc_needed === ndc)

      # Local code specific checks.
      #
      return local.plausible? rest, hints
    end

    # Is this national number a vanity number?
    #
    def vanity? national_number
      Vanity.vanity? national_number
    end
    #
    #
    def vanity_to_number vanity_number
      _, ndc, *rest = split vanity_number
      "#{ndc}#{Vanity.replace(rest.join)}"
    end

  end

end
