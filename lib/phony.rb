# Framework.
#
require File.expand_path '../phony/vanity', __FILE__
require File.expand_path '../phony/local_splitter', __FILE__
require File.expand_path '../phony/national_splitters/fixed', __FILE__
require File.expand_path '../phony/national_splitters/variable', __FILE__
require File.expand_path '../phony/national_code', __FILE__
require File.expand_path '../phony/country', __FILE__

# Countries.
#
# Note: See country_codes.rb for a complete mapping.
#
require File.expand_path '../phony/countries/all_other', __FILE__
require File.expand_path '../phony/countries/austria', __FILE__
require File.expand_path '../phony/countries/chile', __FILE__
require File.expand_path '../phony/countries/egypt', __FILE__
require File.expand_path '../phony/countries/germany', __FILE__
require File.expand_path '../phony/countries/greece', __FILE__
require File.expand_path '../phony/countries/hungary', __FILE__
require File.expand_path '../phony/countries/italy', __FILE__
require File.expand_path '../phony/countries/netherlands', __FILE__
require File.expand_path '../phony/countries/peru', __FILE__
require File.expand_path '../phony/countries/romania', __FILE__
require File.expand_path '../phony/countries/sweden', __FILE__

require File.expand_path '../phony/country_codes', __FILE__

module Phony
  
  # Phony uses a single country codes instance.
  #
  @codes = CountryCodes.new
  
  # Normalizes the given number.
  #
  # Useful before inserting the number into a database.
  #
  def self.normalize phone_number
    normalize! phone_number.dup
  end
  def self.normalize! phone_number
    @codes.normalize phone_number
  end
  
  # Splits the phone number into pieces according to the country codes.
  #
  def self.split phone_number
    split! phone_number.dup
  end
  def self.split! phone_number
    @codes.split phone_number
  end
  
  # Formats a E164 number according to local customs.
  #
  def self.formatted phone_number, options = {}
    formatted! phone_number.dup, options
  end
  def self.formatted! phone_number, options = {}
    @codes.formatted phone_number, options
  end
  
  # def self.service? number
  #   @codes.service? number.dup
  # end
  # def self.mobile? number
  #   @codes.mobile? number.dup
  # end
  # def self.landline? number
  #   @codes.landline? number.dup
  # end
  
  # Returns true if there is a character in the number
  # after the first four numbers.
  #
  def self.vanity? phone_number
    @codes.vanity? phone_number.dup
  end
  
  # Converts any character in the vanity_number to its numeric representation.
  # Does not check if the passed number is a valid vanity_number, simply does replacement.
  #
  def self.vanity_to_number vanity_number
    @codes.vanity_to_number vanity_number.dup
  end
  
end