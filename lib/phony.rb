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

# Countries
#
# Note: See country_codes.rb for a complete mapping.
#
require File.expand_path '../phony/countries/austria', __FILE__
require File.expand_path '../phony/countries/germany', __FILE__
require File.expand_path '../phony/country_codes', __FILE__

# require File.expand_path '../phony/ndc/splitter', __FILE__
# require File.expand_path '../phony/ndc/fixed_size', __FILE__
# require File.expand_path '../phony/ndc/prefix', __FILE__

# # Prefix code countries
# #
# require File.expand_path '../phony/ndc/austria', __FILE__
# require File.expand_path '../phony/ndc/germany', __FILE__

# require 'Phony'

module Phony
  
  @codes = CountryCodes.new
  
  # Normalizes the given number.
  #
  # Useful before inserting the number into a database.
  #
  def self.normalize phone_number
    # Remove zeros at the beginning and non-digit chars
    #
    phone_number = phone_number.gsub(/\D*/, '').gsub!(/^0+/, '') # Is the 0 replacing necessary?
    remove_relative_zeros! phone_number
  end
  
  # Splits the phone number into pieces according to the country codes.
  #
  def self.split phone_number
    phone_number = phone_number.dup
    @codes.split phone_number
    # splitter_or_number, country_code, ndc, local = split_internal(phone_number) do |splitter, cc, ndc_local|
    #   [splitter, cc, splitter.split_ndc(ndc_local)].flatten
    # end
    # return splitter_or_number if local.nil?
    # 
    # [country_code, ndc, splitter_or_number.split_local(local)].flatten
  end
  
  # Formats a E164 number according to local customs.
  #
  def self.formatted phone_number, options = {}
    phone_number = phone_number.dup
    @codes.formatted phone_number
    # splitter_or_number, cc, ndc, local = split_internal(phone_number) do |splitter, cc, ndc_local|
    #   [splitter, cc, splitter.split_ndc(ndc_local)].flatten
    # end
    # return splitter_or_number if local.nil?
    # 
    # space = options[:spaces] || ' '
    # formatted_cc_ndc(cc, ndc, options[:format], space) + splitter_or_number.locally_formatted(local, space)
  end
    
  # Returns true if there is a character in the number
  # after the first four numbers.
  #
  def self.vanity? phone_number
    phone_number = phone_number.dup
    @codes.vanity? phone_number
    # # TODO Split into cc/noncc parts and test noncc.
    # Vanity.vanity? phone_number.gsub(' ', '')
  end
  
  # Converts any character in the vanity_number to its numeric representation.
  # Does not check if the passed number is a valid vanity_number, simply does replacement.
  #
  def self.vanity_to_number vanity_number
    phone_number = phone_number.dup
    @codes.vanity_to_number phone_number
  end
  
  private
    
    # Removes 0s from partially normalized numbers such as:
    # 410443643533
    # 
    # Example:
    #   410443643533 -> 41443643533
    def self.remove_relative_zeros!(phone_number, format = nil)
      '%s%s' % split_cc(phone_number).collect! { |code| code.gsub(/^0+/, '') }
    end
    
    # Formats country code and national destination code.
    #
    def self.formatted_cc_ndc(cc, ndc, format, space = nil)
      space ||= ' ' 
      format, split_phone_number = case format
      when nil, :international_absolute, :international, :+
        [ndc.blank? ? '+%s%s' : '+%s%s%s%s', [cc, space, ndc, space]]
      when :international_relative
        [ndc.blank? ? '00%s%s' : '00%s%s%s%s', [cc, space, ndc, space]]
      when :national
        [ndc.blank? ? '' : '0%s%s', [ndc, space]]
      when :local
        ['', []]
      end
      format % split_phone_number
    end
    
    # def self.split_cc(phone_number)
    #   split_internal(phone_number) do |splitter, cc, ndc_local|
    #     [cc, ndc_local]
    #   end
    # end
    # 
    # def self.split_cc_ndc(phone_number)
    #   split_internal(phone_number) do |splitter, cc, ndc_local|
    #     splitter ? [cc, splitter.split_ndc(ndc_local)].flatten : [cc, ndc_local, '']
    #   end
    # end
    # 
    # def self.split_internal(phone_number)
    #   number = phone_number.dup
    #   presumed_code = ''
    #   1.upto(3) do |i|
    #     presumed_code << number.slice!(0..0)
    #     splitter = @@country_codes[i][presumed_code]
    #     return yield(splitter, presumed_code, number) if splitter
    #   end
    #   return yield(nil, '', '')
    # end
    
end