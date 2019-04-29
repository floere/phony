module Phony

  EMPTY_STRING = '' unless defined?(EMPTY_STRING)

  # Handles determining the correct national code handler.
  #
  class CountryCodes

    attr_reader   :countries
    attr_accessor :international_absolute_format, :international_relative_format, :national_format

    # Singleton instance.
    #
    def self.instance
      @instance ||= new
    end
    
    # Add the given country to the mapping under the
    # given country code.
    #
    def add country_code, country
      country_code = country_code.to_s
      optimized_country_code_access = country_code.size

      @countries ||= {}
      @countries[optimized_country_code_access] ||= {}
      @countries[optimized_country_code_access][country_code] = country
    end

    # Get the Country object for the given CC.
    #
    def [] cc
      countries[cc.size][cc]
    end

    # Clean number of all non-numeric characters, initial zeros or (0.
    #
    @@basic_cleaning_pattern = /\A00?|\(0|\D/
    # Clean number of all non-numeric characters, initial zeros or (0 and return it.
    #
    def clean number
      clean! number && number.dup
    end
    # Clean number of all non-numeric characters, initial zeros or (0 and return a copy.
    #
    def clean! number
      number.gsub!(@@basic_cleaning_pattern, EMPTY_STRING) || number
    end

    # 00 for the standard international call prefix.
    # http://en.wikipedia.org/wiki/List_of_international_call_prefixes
    #
    # We can't know from what country that person was calling, so we
    # can't remove the intl' call prefix.
    #
    # We remove:
    #  * 0 or 00 at the very beginning.
    #  * (0) anywhere.
    #  * Non-digits.
    #
    def normalize number, options = {}
      country = if cc = options[:cc]
        self[cc]
      else
        clean! number
        country, cc, number = partial_split number
        country
      end
      number = country.normalize number
      countrify! number, cc
    end

    # Splits this number into cc, ndc and locally split number parts.
    #
    def split number
      # Split the number into country, cc, and national part.
      country, cc, national_number = partial_split number
      
      # Split the national number into ndc and local part.
      _, ndc, *local = country.split national_number
      
      [cc, ndc, *local]
    end

    # Format the number.
    #
    def format number, options = {}
      country, _, national_number = partial_split number
      country.format national_number, options
    end
    alias formatted format

    # Is this number plausible?
    #
    def plausible? number, hints = {}
      normalized = clean number

      # False if it fails the basic check.
      #
      return false unless (4..16) === normalized.size

      country, cc, rest = partial_split normalized

      # Country code plausible?
      #
      cc_needed = hints[:cc]
      return false if cc_needed && !(cc_needed === cc)

      # Country specific tests.
      #
      country.plausible? rest, hints
    rescue StandardError
      return false
    end
    
    # Is the given number a vanity number?
    #
    def vanity? number
      country, _, national = partial_split number
      country.vanity? national
    end
    # Converts a vanity number into a normalized E164 number.
    #
    def vanity_to_number vanity_number
      country, cc, national = partial_split vanity_number
      "#{cc}#{country.vanity_to_number(national)}"
    end

    private
    
      # Return a country for the number.
      #
      def country_for number
        country, _ = partial_split number
        country
      end
          
      # Split off the country and the cc, and also return the national number part.
      #
      def partial_split number
        cc = ''
        1.upto(3) do |i|
          cc << number.slice!(0..0)
          country = countries[i][cc]
          return [country, cc, number] if country
        end
        # This line is never reached as CCs are in prefix code.
      end
      
      # Adds the country code to the front
      # if it does not already start with it.
      #
      # Note: This won't be correct in some cases, but it is the best we can do.
      #
      def countrify number, cc
        countrify!(number, cc) || number
      end
      def countrify! number, cc
        number.sub!(/\A/, cc) # @countrify_regex, @cc
      end

  end

end
