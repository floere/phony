# frozen_string_literal: true

module Phony
  class TrunkCode
    # Parameters:
    #  * code: The trunk code, e.g. 0.
    #
    # Options:
    #  * normalize: [true (default), false] Remove the trunk code when normalizing (only use if number scheme is defined unambiguously).
    #  * split: [true, false (default)] Remove the trunk code when splitting (only use if number scheme is defined unambiguously).
    #  * format: [true (default), false] Add the trunk code when formatting (passing `false` will not add it).
    #
    def initialize(code, options = {})
      @code = code
      @trunk_code_replacement = /\A#{code.gsub(/%s/, '')}/
      @normalize = options[:normalize] || options[:normalize].nil?
      @split     = options[:split]
      @format    = options[:format] || options[:format].nil?
    end

    # Prepends itself to the other codes.
    #
    def |(other)
      other.codes.unshift self
      other
    end

    # Split gets a number without country code and splits it into
    # its parts.
    #
    def split(national_number)
      return [self, national_number] unless @split

      without_trunk = national_number.gsub @trunk_code_replacement, EMPTY_STRING
      [self, without_trunk]
    end

    # Normalize normalizes the given national number.
    #
    def normalize(national_number, options = {})
      return national_number unless @normalize && options[:cc]

      national_number.gsub @trunk_code_replacement, EMPTY_STRING
    end

    # Format the trunk code using the spaces given.
    #
    def format(space, force = nil)
      return unless force || @format
        if @code.size > 1
          (@code % space).gsub(/\D/, ' ')
        else
          @code
        end
    end
  end
end
