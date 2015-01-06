module Phony

  EMPTY_STRING = ''

  # Handles determining the correct national code handler.
  #
  class CountryCodes

    attr_reader   :countries
    attr_accessor :international_absolute_format, :international_relative_format, :national_format

    def initialize
      @international_absolute_format = '+%s%s%s%s%s'
      @international_relative_format = '00%s%s%s%s%s'
      @national_format               = '%s%s%s%s'

      @default_space = ' '
      @default_local_space = ' '
    end

    def self.instance
      @instance ||= new
    end

    # Get the Country object for the given CC.
    #
    def [] cc
      countries[cc.size][cc]
    end

    # Clean number of all non-numeric characters, initial zeros or (0).
    #
    @@basic_cleaning_pattern = /\A00?|\(0\)|\D/
    # Clean number of all non-numeric characters, initial zeros or (0) and return it.
    #
    def clean number
      clean! number && number.dup
    end
    # Clean number of all non-numeric characters, initial zeros or (0) and return a copy.
    #
    def clean! number
      number.gsub!(@@basic_cleaning_pattern, EMPTY_STRING) || number
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
        country, cc, number = split_cc number
        country
      end
      number = country.normalize number
      countrify! number, cc
    end

    # Splits this number into cc, ndc and locally split number parts.
    #
    def split number
      country, *cc_split_rest = internal_split number
      cc_split_rest
    end
    
    def internal_split number
      country, cc, rest = split_cc number
      [country, cc, *country.split(rest)]
    end

    def format number, options = {}
      country, *split_number = internal_split number
      format_cc_ndc_local \
        options[:format]       || country.format,
        options[:spaces]       || country.space                           || @default_space,
        options[:local_spaces] || country.local_space || options[:spaces] || @default_local_space,
        *split_number
    end
    alias formatted format

    # Formats country code and national destination code.
    #
    def format_cc_ndc_local format, space, local_space, cc, trunk, ndc, *parts
      local = if parts.empty?
                EMPTY_STRING
              else
                format_local(local_space, parts) unless parts.empty?
              end
      format_cc_ndc format, space, cc, trunk, ndc, local
      
      # cc_ndc = cc_ndc.slice 0...cc_ndc.rindex(space.to_s) if parts.empty?
    end
    def format_cc_ndc format, space, cc, trunk, ndc, local
      case format
      when String
        format % { :cc => cc, :ndc => ndc, :local => local }
      when nil, :international_absolute, :international, :+
        ndc ?
          @international_absolute_format % [cc, space, ndc, space, local] :
          @international_absolute_format % [cc, space, local, nil, nil]
      when :international_relative
        ndc ?
          @international_relative_format % [cc, space, ndc, space, local] :
          @international_relative_format % [cc, space, local, nil, nil]
      when :national
        # Replaces the %s in the trunk code with a "space".
        trunk = trunk % space if trunk && trunk.size > 1
        ndc && !ndc.empty? ?
          @national_format % [trunk, ndc, space, local] :
          @national_format % [trunk, nil, nil, nil]
      when :local
        local
      end
    end
    def format_local local_space, parts_ary
      parts_ary.compact!
      parts_ary.join local_space.to_s
    end

    #
    #
    def service? number
      country, _, rest = split_cc number
      country.service? rest
    end
    def mobile? number
      country, _, rest = split_cc number
      country.mobile? rest
    end
    def landline? number
      country, _, rest = split_cc number
      country.landline? rest
    end

    # Is the given number a vanity number?
    #
    def vanity? number
      country, _, rest = split_cc number
      country.vanity? rest
    end
    # Converts a vanity number into a normalized E164 number.
    #
    def vanity_to_number vanity_number
      country, cc, rest = split_cc vanity_number
      "#{cc}#{country.vanity_to_number(rest)}"
    end

    def split_cc rest
      presumed_cc = ''
      1.upto(3) do |i|
        presumed_cc << rest.slice!(0..0)
        country = countries[i][presumed_cc]
        return [country, presumed_cc, rest] if country
      end
      # This line is never reached as CCs are in prefix code.
    end

    def plausible? number, hints = {}
      normalized = clean number

      # False if it fails the basic check.
      #
      return false unless (4..15) === normalized.size

      country, cc, rest = split_cc normalized

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

      @countries ||= {}
      @countries[optimized_country_code_access] ||= {}
      @countries[optimized_country_code_access][country_code] = country
    end

  end

end
