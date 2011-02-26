module Phony
  
  # Handles determining the correct national code handler.
  #
  class CountryCodes
    
    attr_reader :mapping
    
    def self.instance
      @instance ||= new
    end
    
    def normalize number
      # Remove non-digit chars.
      #
      number.gsub! /\D*/, ''
      national_handler, cc, rest = split_cc number
      '%s%s' % [cc, national_handler.normalize(rest)]
    end
    
    # Splits this number into cc, ndc and locally split number parts.
    #
    def split number
      national_handler, cc, rest = split_cc number
      [cc, *national_handler.split(rest)]
    end
    
    def formatted number, options = {}
      format_cc_ndc_local options[:format], options[:spaces] || ' ', *split(number)
    end
    # Formats country code and national destination code.
    #
    def format_cc_ndc_local format, space, cc, ndc, *parts
      "#{format_cc_ndc(format, space, cc, ndc)}#{format_local(space, parts)}"
    end
    def format_cc_ndc format, space, cc, ndc
      format, split_phone_number = case format
      when nil, :international_absolute, :international, :+
        [ndc.empty? ? '+%s%s' : '+%s%s%s%s', [cc, space, ndc, space]]
      when :international_relative
        [ndc.empty? ? '00%s%s' : '00%s%s%s%s', [cc, space, ndc, space]]
      when :national
        [ndc.empty? ? '' : '0%s%s', [ndc, space]]
      when :local
        ['', []]
      end
      format % split_phone_number
    end
    def format_local space, parts_ary
      parts_ary.join space.to_s
    end
    
    def service? number
      national_handler, cc, rest = split_cc number
      national_handler.service? rest
    end
    def mobile? number
      national_handler, cc, rest = split_cc number
      national_handler.mobile? rest
    end
    def landline? number
      national_handler, cc, rest = split_cc number
      national_handler.landline? rest
    end
    
    # Is the given number a vanity number?
    #
    def vanity? number
      national_handler, _, rest = split_cc number
      national_handler.vanity? rest
    end
    # Converts a vanity number into a normalized E164 number.
    #
    def vanity_to_number vanity_number
      national_handler, cc, rest = split_cc vanity_number
      "#{cc}#{national_handler.vanity_to_number(rest)}"
    end
    
    def split_cc rest
      presumed_cc = ''
      1.upto(3) do |i|
        presumed_cc << rest.slice!(0..0)
        national_code_handler = mapping[i][presumed_cc]
        return [national_code_handler, presumed_cc, rest] if national_code_handler
      end
      # This line is never reached as CCs are in prefix code.
    end
    
    # # TODO
    # #
    # def self.with_cc cc
    #   mapping[cc.size][cc.to_s]
    # end
    
    # Add the given country to the mapping under the
    # given country code.
    #
    def add country_code, country
      country_code = country_code.to_s
      optimized_country_code_access = country_code.size
      
      @mapping ||= {}
      @mapping[optimized_country_code_access] ||= {}
      @mapping[optimized_country_code_access][country_code] = country
    end
    
  end
  
end