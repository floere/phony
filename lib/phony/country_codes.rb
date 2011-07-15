module Phony

  EMPTY_STRING = ''

  # Handles determining the correct national code handler.
  #
  class CountryCodes

    attr_reader   :mapping
    attr_accessor :international_absolute_format, :international_relative_format, :national_format

    def initialize
      @international_absolute_format = '+%s%s%s%s'
      @international_relative_format = '00%s%s%s%s'
      @national_format               = '0%s%s'

      @normalize_format = '%s%s'
      @default_space    = ' '
    end

    def self.instance
      @instance ||= new
    end

    def normalize number
      # Remove non-digit chars.
      #
      number.gsub! /\D*/, EMPTY_STRING
      national_handler, cc, rest = split_cc number
      @normalize_format % [cc, national_handler.normalize(rest)]
    end

    # Splits this number into cc, ndc and locally split number parts.
    #
    def split number
      national_handler, cc, rest = split_cc number
      [cc, *national_handler.split(rest)]
    end

    def formatted number, options = {}
      format_cc_ndc_local options[:format], options[:spaces] || @default_space, *split(number)
    end
    # Formats country code and national destination code.
    #
    def format_cc_ndc_local format, space, cc, ndc, *parts
      cc_ndc = format_cc_ndc(format, space, cc, ndc)
      local  = \
        if parts.empty?
          cc_ndc = cc_ndc.slice(0...cc_ndc.size-1)
          EMPTY_STRING
        else
          format_local(space, parts) unless parts.empty?
        end
      "#{cc_ndc}#{local}"
    end
    def format_cc_ndc format, space, cc, ndc
      case format
      when nil, :international_absolute, :international, :+
        @international_absolute_format % [cc, space, ndc, space]
      when :international_relative
        @international_relative_format % [cc, space, ndc, space]
      when :national
        (ndc.empty? ? EMPTY_STRING : @national_format) % [ndc, space]
      when :local
        EMPTY_STRING
      end
    end
    def format_local space, parts_ary
      parts_ary.join space.to_s
    end

    #
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
