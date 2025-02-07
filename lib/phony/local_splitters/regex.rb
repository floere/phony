# frozen_string_literal: true

module Phony
  module LocalSplitters
    # Local splitter class to split the last part of
    # a number, i.e. minus cc or ndc.
    #
    # Countries can create new instances according to their needs.
    #
    # Note: Countries should use instance_for
    #       to avoid getting new local splitter instances.
    #
    class Regex
      attr_reader :fallback, :mapping

      # Get a splitter for the given format.
      #
      # Note: Not cached.
      #
      def self.instance_for(mapping)
        new mapping
      end

      # Initialize with a regex => format mapping.
      #
      def initialize(mapping)
        @fallback = mapping.delete(:fallback) || [12]
        @mapping  = mapping
      end

      # Split a local number according to an assumed country specific format.
      #
      # Examples
      # * split '3643533' # => ['364', '35', '33'] # (Switzerland)
      #
      def split(number)
        mapping.each do |regex, format|
          next unless number&.match?(regex)

          return split_with(number, format)
        end
        split_with number, fallback
      end

      def plausible?(rest, _hints = {})
        number = rest.sum('')
        mapping.each do |regex, format|
          next unless number&.match?(regex)

          return plausible_with? number, format
        end
        plausible_with? number, fallback
      end

      private

      def split_with(number, format)
        cursor = 0
        format.each_with_object([]) do |size, result|
          result << number.slice(cursor...cursor + size)
          cursor += size
          return result if cursor >= number.size
        end << number
      end

      def plausible_with?(number, format)
        length = format.sum
        number.length == length
      end
    end
  end
end
