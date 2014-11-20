# Framework.
#
require File.expand_path '../phony/vanity', __FILE__
require File.expand_path '../phony/local_splitters/fixed', __FILE__
require File.expand_path '../phony/local_splitters/regex', __FILE__
require File.expand_path '../phony/national_splitters/dsl', __FILE__
require File.expand_path '../phony/national_splitters/fixed', __FILE__
require File.expand_path '../phony/national_splitters/variable', __FILE__
require File.expand_path '../phony/national_splitters/regex', __FILE__
require File.expand_path '../phony/national_splitters/default', __FILE__
require File.expand_path '../phony/national_splitters/none', __FILE__
require File.expand_path '../phony/national_code', __FILE__
require File.expand_path '../phony/country', __FILE__
require File.expand_path '../phony/trunk_code', __FILE__
require File.expand_path '../phony/country_codes', __FILE__

require File.expand_path '../phony/dsl', __FILE__

# Countries.
#
# The ones that need more space to define.
#
require File.expand_path '../phony/countries/austria', __FILE__
require File.expand_path '../phony/countries/bangladesh', __FILE__
require File.expand_path '../phony/countries/belarus', __FILE__
require File.expand_path '../phony/countries/brazil', __FILE__
require File.expand_path '../phony/countries/cambodia', __FILE__
require File.expand_path '../phony/countries/croatia', __FILE__
require File.expand_path '../phony/countries/china', __FILE__
require File.expand_path '../phony/countries/georgia', __FILE__
require File.expand_path '../phony/countries/germany', __FILE__
require File.expand_path '../phony/countries/guinea', __FILE__
require File.expand_path '../phony/countries/india', __FILE__
require File.expand_path '../phony/countries/indonesia', __FILE__
require File.expand_path '../phony/countries/ireland', __FILE__
require File.expand_path '../phony/countries/italy', __FILE__
require File.expand_path '../phony/countries/japan', __FILE__
require File.expand_path '../phony/countries/kyrgyzstan', __FILE__
require File.expand_path '../phony/countries/latvia', __FILE__
require File.expand_path '../phony/countries/libya', __FILE__
require File.expand_path '../phony/countries/malaysia', __FILE__
require File.expand_path '../phony/countries/moldova', __FILE__
require File.expand_path '../phony/countries/montenegro', __FILE__
require File.expand_path '../phony/countries/namibia', __FILE__
require File.expand_path '../phony/countries/nepal', __FILE__
require File.expand_path '../phony/countries/netherlands', __FILE__
require File.expand_path '../phony/countries/pakistan', __FILE__
require File.expand_path '../phony/countries/paraguay', __FILE__
require File.expand_path '../phony/countries/russia_kazakhstan_abkhasia_south_ossetia', __FILE__
require File.expand_path '../phony/countries/serbia', __FILE__
require File.expand_path '../phony/countries/somalia', __FILE__
require File.expand_path '../phony/countries/south_korea', __FILE__
require File.expand_path '../phony/countries/sweden', __FILE__
require File.expand_path '../phony/countries/taiwan', __FILE__
require File.expand_path '../phony/countries/tajikistan', __FILE__
require File.expand_path '../phony/countries/turkmenistan', __FILE__
require File.expand_path '../phony/countries/vietnam', __FILE__
require File.expand_path '../phony/countries/ukraine', __FILE__
require File.expand_path '../phony/countries/united_kingdom', __FILE__
require File.expand_path '../phony/countries/uruguay', __FILE__
require File.expand_path '../phony/countries/zimbabwe', __FILE__
#
# All other countries.
#
require File.expand_path '../phony/countries', __FILE__

module Phony

  class NormalizationError < StandardError
    def initialize
      super %Q{Phony could not normalize the given number. Is it a phone number?}
    end
  end

  # Phony uses a single country codes instance.
  #
  @codes = CountryCodes.instance

  class << self

    # Get the Country for the given CC.
    #
    # Example:
    #   us = Phony['1']
    #   normalized_number = us.normalize number
    #
    def [] cc
      @codes[cc]
    end

    # Normalizes the given number.
    #
    # Useful before inserting the number into a database.
    #
    def normalize phone_number, options = {}
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.normalize(number)." unless phone_number
      normalize! phone_number.dup, options
    end
    def normalize! phone_number, options = {}
      @codes.normalize phone_number, options
    rescue
      raise NormalizationError.new
    end

    # Splits the phone number into pieces according to the country codes.
    #
    def split phone_number
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.split(number)." unless phone_number
      split! phone_number.dup
    end
    def split! phone_number
      parts = @codes.split phone_number
      parts.delete_at 1
      parts
    end

    # Formats a E164 number according to local customs.
    #
    def format phone_number, options = {}
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.format(number)." unless phone_number
      format! phone_number.dup, options
    end
    def format! phone_number, options = {}
      @codes.format phone_number, options
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
    def vanity_to_number vanity_number
      @codes.vanity_to_number vanity_number.dup
    end

  end

end
