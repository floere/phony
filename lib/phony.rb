# frozen_string_literal: true

# NOTE We use Kernel.load here, as it's possible to redefine Phony via Phony::Config.

# Framework.
#
load File.expand_path '../phony/config.rb', __FILE__
load File.expand_path '../phony/vanity.rb', __FILE__
load File.expand_path '../phony/local_splitters/fixed.rb', __FILE__
load File.expand_path '../phony/local_splitters/regex.rb', __FILE__
load File.expand_path '../phony/national_splitters/dsl.rb', __FILE__
load File.expand_path '../phony/national_splitters/fixed.rb', __FILE__
load File.expand_path '../phony/national_splitters/variable.rb', __FILE__
load File.expand_path '../phony/national_splitters/regex.rb', __FILE__
load File.expand_path '../phony/national_splitters/default.rb', __FILE__
load File.expand_path '../phony/national_splitters/none.rb', __FILE__
load File.expand_path '../phony/national_code.rb', __FILE__
load File.expand_path '../phony/country.rb', __FILE__
load File.expand_path '../phony/trunk_code.rb', __FILE__
load File.expand_path '../phony/country_codes.rb', __FILE__
load File.expand_path '../phony/dsl.rb', __FILE__

# Countries.
#
# The ones that need more space to define.
#
load File.expand_path '../phony/countries/argentina.rb', __FILE__
load File.expand_path '../phony/countries/austria.rb', __FILE__
load File.expand_path '../phony/countries/bangladesh.rb', __FILE__
load File.expand_path '../phony/countries/belarus.rb', __FILE__
load File.expand_path '../phony/countries/brazil.rb', __FILE__
load File.expand_path '../phony/countries/cambodia.rb', __FILE__
load File.expand_path '../phony/countries/croatia.rb', __FILE__
load File.expand_path '../phony/countries/china.rb', __FILE__
load File.expand_path '../phony/countries/georgia.rb', __FILE__
load File.expand_path '../phony/countries/germany.rb', __FILE__
load File.expand_path '../phony/countries/guinea.rb', __FILE__
load File.expand_path '../phony/countries/india.rb', __FILE__
load File.expand_path '../phony/countries/indonesia.rb', __FILE__
load File.expand_path '../phony/countries/ireland.rb', __FILE__
load File.expand_path '../phony/countries/italy.rb', __FILE__
load File.expand_path '../phony/countries/japan.rb', __FILE__
load File.expand_path '../phony/countries/kyrgyzstan.rb', __FILE__
load File.expand_path '../phony/countries/latvia.rb', __FILE__
load File.expand_path '../phony/countries/libya.rb', __FILE__
load File.expand_path '../phony/countries/malaysia.rb', __FILE__
load File.expand_path '../phony/countries/moldova.rb', __FILE__
load File.expand_path '../phony/countries/montenegro.rb', __FILE__
load File.expand_path '../phony/countries/myanmar.rb', __FILE__
load File.expand_path '../phony/countries/namibia.rb', __FILE__
load File.expand_path '../phony/countries/nepal.rb', __FILE__
load File.expand_path '../phony/countries/netherlands.rb', __FILE__
load File.expand_path '../phony/countries/pakistan.rb', __FILE__
load File.expand_path '../phony/countries/paraguay.rb', __FILE__
load File.expand_path '../phony/countries/russia_kazakhstan_abkhasia_south_ossetia.rb', __FILE__
load File.expand_path '../phony/countries/saudi_arabia.rb', __FILE__
load File.expand_path '../phony/countries/serbia.rb', __FILE__
load File.expand_path '../phony/countries/somalia.rb', __FILE__
load File.expand_path '../phony/countries/south_korea.rb', __FILE__
load File.expand_path '../phony/countries/sweden.rb', __FILE__
load File.expand_path '../phony/countries/taiwan.rb', __FILE__
load File.expand_path '../phony/countries/tajikistan.rb', __FILE__
load File.expand_path '../phony/countries/turkmenistan.rb', __FILE__
load File.expand_path '../phony/countries/vietnam.rb', __FILE__
load File.expand_path '../phony/countries/ukraine.rb', __FILE__
load File.expand_path '../phony/countries/united_kingdom.rb', __FILE__
load File.expand_path '../phony/countries/uruguay.rb', __FILE__
load File.expand_path '../phony/countries/zimbabwe.rb', __FILE__

# All other countries.
#
load File.expand_path '../phony/countries.rb', __FILE__

# Phony is the main module and is generally used to process
# E164 phone numbers directly.
#
module Phony

  # Raised in case Phony can't normalize a given number.
  #
  # @example
  #   Phony.normalize("Fnork!") # Raises a Phony::NormalizationError.
  #
  class NormalizationError < ArgumentError
    def initialize
      super %Q{Phony could not normalize the given number. Is it a phone number?}
    end
  end
  
  # Raised in case Phony can't split a given number.
  #
  # @example
  #   Phony.split("Fnork!") # Raises a Phony::SplittingError.
  #
  class SplittingError < ArgumentError
    def initialize number
      super %Q{Phony could not split the given number. Is #{(number.nil? || number == '') ? 'it' : number.inspect} a phone number?}
    end
  end
  
  # Raised in case Phony can't format a given number.
  #
  # @example
  #   Phony.format("Fnork!") # Raises a Phony::FormattingError.
  #
  class FormattingError < ArgumentError
    def initialize
      super %Q{Phony could not format the given number. Is it a phone number?}
    end
  end

  # Phony uses a single country codes instance.
  #
  @codes = CountryCodes.instance

  class << self

    # Get the Country for the given CC.
    #
    # @param [String] cc A valid country code.
    #
    # @return [Country] for the given CC.
    #
    # @example Country for the NANP (includes the US)
    #   nanp = Phony['1']
    #   normalized_number = nanp.normalize number
    #
    def [] cc
      @codes[cc]
    end

    # Normalizes the given number into a digits-only String.
    #
    # Useful before inserting the number into a database.
    #
    # @param [String] phone_number An E164 number.
    # @param [Hash] options An options hash (With :cc as the only used key).
    #
    # @return [String] A normalized E164 number.
    #
    # @raise [Phony::NormalizationError] If phony can't normalize the given number.
    #
    # @example Normalize a Swiss number.
    #   Phony.normalize("+41 (044) 123 45 67") # => "41441234567"
    #
    # @example Normalize a phone number assuming it's a NANP number.
    #   Phony.normalize("301 555 0100", cc: '1') # => "13015550100"
    #
    def normalize phone_number, options = {}
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.normalize(number)." unless phone_number
      
      normalize! phone_number.dup, options
    end
    # A destructive version of {#normalize}.
    #
    # @see #normalize
    #
    # @param [String] phone_number An E164 number.
    # @param [Hash] options An options hash (With :cc as the only used key).
    #
    # @return [String] The normalized E164 number.
    #
    # @raise [Phony::NormalizationError] If phony can't normalize the given number.
    #
    # @example Normalize a Swiss number.
    #   Phony.normalize!("+41 (044) 123 45 67") # => "41441234567"
    #
    # @example Normalize a phone number assuming it's a NANP number.
    #   Phony.normalize!("301 555 0100", cc: '1') # => "13015550100"
    #
    def normalize! phone_number, options = {}
      @codes.normalize phone_number, options
    rescue
      raise NormalizationError.new
    end

    # Splits the phone number into pieces according to the country codes.
    #
    # Useful for manually processing the CC, NDC, and local pieces.
    #
    # @param [String] phone_number An E164 number.
    #
    # @return [Array<String>] The pieces of a phone number.
    #
    # @example Split a Swiss number.
    #   Phony.split("41441234567") # => ["41", "44", "123", "45", "67"]
    #
    # @example Split a NANP number.
    #   Phony.split("13015550100") # => ["1", "301", "555", "0100"]
    #
    def split phone_number
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.split(number)." unless phone_number
      
      split! phone_number.dup, phone_number
    end
    # A destructive version of {#split}.
    #
    # @see #split
    #
    # @param [String] phone_number An E164 number.
    #
    # @return [Array<String>] The pieces of the phone number.
    #
    # @example Split a Swiss number.
    #   Phony.split!("41441234567") # => ["41", "44", "123", "45", "67"]
    #
    # @example Split a NANP number.
    #   Phony.split!("13015550100") # => ["1", "301", "555", "0100"]
    #
    def split! phone_number, error_number = nil
      @codes.split phone_number
    rescue
      # NB The error_number (reference) is used because phone_number is destructively handled.
      raise SplittingError.new(error_number)
    end

    # Formats a normalized E164 number according to a country's formatting scheme.
    #
    # Absolutely needs a normalized E164 number.
    #
    # @param [String] phone_number A normalized E164 number.
    # @param [Hash] options See the README for a list of options.
    #
    # @return [Array<String>] The pieces of a phone number.
    #
    # @example Format a Swiss number.
    #   Phony.format("41441234567") # => "+41 44 123 45 67"
    #
    # @example Format a NANP number.
    #   Phony.format("13015550100") # => "+1 301 555 0100"
    #
    # @example Format a NANP number in local format.
    #   Phony.format("13015550100", :format => :local) # => "555 0100"
    #
    # @example Format a NANP number in a specific format.
    #   Phony.format("13015550100", :format => '%{cc} (%{trunk}%{ndc}) %{local}') # => "555 0100"
    #
    def format phone_number, options = {}
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.format(number)." unless phone_number
      format! phone_number.dup, options
    end
    # A destructive version of {#format}.
    #
    # @see #format
    #
    # Formats a normalized E164 number according to a country's formatting scheme.
    #
    # Absolutely needs a normalized E164 number.
    #
    # @param [String] phone_number A normalized E164 number.
    # @param [Hash] options See the README for a list of options.
    #
    # @return [Array<String>] The pieces of the phone number.
    #
    # @example Format a Swiss number.
    #   Phony.format!("41441234567") # => "+41 44 123 45 67"
    #
    # @example Format a NANP number.
    #   Phony.format!("13015550100") # => "+1 301 555 0100"
    #
    # @example Format a NANP number in local format.
    #   Phony.format!("13015550100", :format => :local) # => "555 0100"
    #
    def format! phone_number, options = {}
      @codes.format phone_number, options
    rescue
      raise FormattingError.new
    end
    alias formatted  format
    alias formatted! format!

    # Makes a plausibility check.
    #
    # If it returns false, it is not plausible.
    # If it returns true, it is unclear whether it is plausible,
    # leaning towards being plausible.
    #
    def plausible? number, hints = {}
      @codes.plausible? number, hints
    end

    # Returns true if there is a character in the number
    # after the first four numbers.
    #
    def vanity? phone_number
      @codes.vanity? phone_number.dup
    end

    # Converts any character in the vanity_number to its numeric representation.
    # Does not check if the passed number is a valid vanity_number, simply does replacement.
    #
    # @param [String] vanity_number A vanity number.
    #
    # @return [String] The de-vanitized phone number.
    #
    # @example De-vanitize a number.
    #   Phony.vanity_to_number("1-800-HELLOTHERE") # => "1-800-4355684373"
    #
    def vanity_to_number vanity_number
      @codes.vanity_to_number vanity_number.dup
    end

  end

end
