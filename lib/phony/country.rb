# frozen_string_literal: true

module Phony

  #
  #
  class Country
    
    attr_accessor :codes

    @@international_absolute_format = '+%s%s%s%s%s'
    @@international_relative_format = '00%s%s%s%s%s'
    @@national_format               = '%s%s%s%s'
  
    @@default_space = ' '
    @@default_local_space = ' '
    @@default_parentheses = false

    # TODO Doc.
    #
    def initialize *codes
      @codes = codes
    end

    # DSL method.
    #
    # Chain two codes together.
    #
    def | other
      self.codes = self.codes + other.codes
      self
    end

    # Options.
    #
    # TODO Rewrite.
    #
    def with cc, options = {}
      @cc           = cc
      
      @invalid_ndcs = options[:invalid_ndcs]
      
      @format       = options[:format]
      @space        = options[:space]
      @local_space  = options[:local_space]
      @parentheses  = options[:parentheses]
    end

    # A number is split with the code handlers as given in the initializer.
    #
    # Note: If the ndc is nil, it will not return it.
    #
    # @return [Trunk, String (ndc), Array<String> (national pieces)]
    #
    def split national_number
      _, trunk, ndc, *rest = internal_split national_number
      [trunk, ndc, *rest]
    end
    #
    #
    # @return [Splitters::Local, Trunk, String (ndc), Array<String> (national pieces)]
    #
    def internal_split national_number
      trunk = nil
      @codes.each do |national_splitter|
        new_trunk, ndc, *rest = national_splitter.split national_number
        trunk ||= new_trunk
        return [national_splitter.local_splitter, trunk, ndc, *rest] if rest && !rest.empty?
      end
      
      # Best effort.
      [nil, trunk, national_number, []]
    end
    
    # Format the number, given the national part of it.
    #
    def format national_number, options = {}
      type         = options[:format]       || @format
      space        = options[:spaces]       || @space       || @@default_space
      local_space  = options[:local_spaces] || @local_space || space           || @@default_local_space
      parentheses  = options[:parentheses]
      parentheses  = @parentheses || @@default_parentheses if parentheses.nil?
      use_trunk    = options[:trunk]
      
      trunk, ndc, *local_pieces = split national_number
      
      local = format_local local_pieces, local_space
      
      format_cc_ndc trunk, ndc, local, type, space, parentheses, use_trunk
    end
    def format_local local, local_space
      if local.empty?
        EMPTY_STRING
      else
        local.compact!
        local.join local_space.to_s
      end
    end
    def format_cc_ndc trunk, ndc, local, type, space, parentheses, use_trunk
      case type
      when String
        trunk &&= trunk.format(space, use_trunk)
        type % { :trunk => trunk, :cc => @cc, :ndc => ndc, :local => local }
      when nil, :international_absolute, :international, :+
        if ndc
          format_with_ndc(@@international_absolute_format, @cc, format_ndc(ndc, parentheses), local, space)
        else
          format_without_ndc(@@international_absolute_format, @cc, local, space)
        end
      when :international_relative
        if ndc
          format_with_ndc(@@international_relative_format, @cc, format_ndc(ndc, parentheses), local, space)
        else
          format_without_ndc(@@international_relative_format, @cc, local, space)
        end
      when :national
        trunk &&= trunk.format(space, use_trunk)
        if ndc && !ndc.empty?
          @@national_format % [trunk, format_ndc(ndc, parentheses), space, local]
        else
          @@national_format % [trunk, nil, nil,   local]
        end
      when :local
        local
      end
    end
    def format_ndc ndc, parentheses
      parentheses ? "(#{ndc})" : ndc
    end
    def format_with_ndc format, cc, ndc, local, space
      format % [cc, space, ndc, space, local]
    end
    def format_without_ndc format, cc, local, space
      format % [cc, space, local, nil, nil]
    end

    # Cleans all non-numeric characters.
    #
    @@basic_cleaning_pattern = /\(0|\D/
    # Clean number of all non-numeric characters and return a copy.
    #
    def clean number
      clean! number && number.dup
    end
    # Clean number of all non-numeric characters and return it.
    #
    def clean! number
      number.gsub!(@@basic_cleaning_pattern, EMPTY_STRING) || number
    end

    # Removes 0s from partially normalized numbers
    # such as 410443643533.
    #
    # Example:
    #   410443643533 -> 41443643533
    #
    # In some cases it doesn't, like Italy.
    #
    def normalize national_number
      clean! national_number
      normalized = @codes.reduce national_number do |number, code|
        result = code.normalize number
        break result if result
        number
      end
      normalized
    end

    # Tests for plausibility of this national number.
    #
    def plausible? rest, hints = {}
      local, _, ndc, *rest = internal_split rest
      
      # Element based checking.
      #
      # Note: ndc == false means the country has none.
      #
      return false if ndc.nil?
      return false if ndc && ndc.empty?
      return false if @invalid_ndcs && @invalid_ndcs === ndc

      # # A valid range for the rest is 0 or 3+ total digits.
      # #
      # return false if (1..2) === rest_size

      # National destination code plausible?
      #
      ndc_needed = hints[:ndc]
      return false if ndc_needed && !(ndc_needed === ndc)
      
      # If there is no local part, we can assume it's not a plausible number.
      # (Or, not defined correctly in Phony yet)
      return false unless local

      # Local code specific checks.
      #
      return local.plausible? rest, hints
    end

    # Is this national number a vanity number?
    #
    def vanity? national_number
      Vanity.vanity? national_number
    end
    #
    #
    def vanity_to_number vanity_number
      _, ndc, *rest = split vanity_number
      "#{ndc}#{Vanity.replace(rest.join)}"
    end

  end

end
