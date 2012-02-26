# Framework.
#
require File.expand_path '../phony/vanity', __FILE__
require File.expand_path '../phony/local_splitters/fixed', __FILE__
require File.expand_path '../phony/local_splitters/regex', __FILE__
require File.expand_path '../phony/national_splitters/dsl', __FILE__
require File.expand_path '../phony/national_splitters/fixed', __FILE__
require File.expand_path '../phony/national_splitters/variable', __FILE__
require File.expand_path '../phony/national_splitters/regex', __FILE__
require File.expand_path '../phony/national_splitters/none', __FILE__
require File.expand_path '../phony/national_splitters/default', __FILE__
require File.expand_path '../phony/national_code', __FILE__
require File.expand_path '../phony/country', __FILE__
require File.expand_path '../phony/country_codes', __FILE__
require File.expand_path '../phony/dsl', __FILE__

# Countries.
#
# The ones that need more space to define.
#
require File.expand_path '../phony/countries/austria', __FILE__
require File.expand_path '../phony/countries/china', __FILE__
require File.expand_path '../phony/countries/germany', __FILE__
require File.expand_path '../phony/countries/ireland', __FILE__
require File.expand_path '../phony/countries/italy', __FILE__
require File.expand_path '../phony/countries/malaysia', __FILE__
require File.expand_path '../phony/countries/netherlands', __FILE__
require File.expand_path '../phony/countries/south_korea', __FILE__
require File.expand_path '../phony/countries/sweden', __FILE__
require File.expand_path '../phony/countries/united_kingdom', __FILE__
#
# All other countries.
#
require File.expand_path '../phony/countries', __FILE__

module Phony

  # Phony uses a single country codes instance.
  #
  @codes = CountryCodes.instance

  class << self

    # Normalizes the given number.
    #
    # Useful before inserting the number into a database.
    #
    def normalize phone_number
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.normalize(number)." unless phone_number
      normalize! phone_number.dup
    end
    def normalize! phone_number
      @codes.normalize phone_number
    end

    # Splits the phone number into pieces according to the country codes.
    #
    def split phone_number
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.split(number)." unless phone_number
      split! phone_number.dup
    end
    def split! phone_number
      @codes.split phone_number
    end

    # Formats a E164 number according to local customs.
    #
    def format phone_number, options = {}
      raise ArgumentError, "Phone number cannot be nil. Use e.g. number && Phony.format(number)." unless phone_number
      formatted! phone_number.dup, options
    end
    def format! phone_number, options = {}
      @codes.formatted phone_number, options
    end
    alias formatted  format
    alias formatted! format!

    # def service? number
    #   @codes.service? number.dup
    # end
    # def mobile? number
    #   @codes.mobile? number.dup
    # end
    # def landline? number
    #   @codes.landline? number.dup
    # end

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
