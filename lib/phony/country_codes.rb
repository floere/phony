module Phony
  
  # Handles determining the correct national code handler.
  #
  class CountryCodes
    
    def normalize number
      # Remove non-digit chars.
      #
      number.gsub! /\D*/, ''
      remove_relative_zeros! number
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
    def format_local space, parts_ary
      parts_ary.join space.to_s
    end
    
    # TODO Speed these methods up.
    #
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
      # TODO raise
    end
    
    # Removes 0s from partially normalized numbers
    # such as 410443643533.
    # 
    # Example:
    #   410443643533 -> 41443643533
    def remove_relative_zeros! phone_number
      _, cc, rest = split_cc phone_number
      '%s%s' % [cc, rest].collect! { |code| code.gsub(/^0+/, '') }
    end
    
    # Cached mapping of all countries.
    #
    def mapping
      @mapping ||= Phony::Countries.mapping
    end
    
  end
  
end