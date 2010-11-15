begin
  gem 'activesupport', '~> 3.0'
rescue LoadError
  puts "phony requires activesupport ~> 3.0"
end

require 'active_support/core_ext/object/blank'

# Framework.
#
require File.expand_path '../phony/vanity', __FILE__
require File.expand_path '../phony/local_splitter', __FILE__
require File.expand_path '../phony/national_codes/fixed_splitter', __FILE__
require File.expand_path '../phony/national_codes/variable_splitter', __FILE__
require File.expand_path '../phony/national_code', __FILE__

# Countries.
#
# Note: See country_codes.rb for a complete mapping.
#
require File.expand_path '../phony/countries/austria', __FILE__
require File.expand_path '../phony/countries/germany', __FILE__
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
  
  def self.service? number
    
  end
  def self.mobile? number
    
  end
  def self.landline? number
    
  end
  
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