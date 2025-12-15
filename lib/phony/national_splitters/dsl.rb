# frozen_string_literal: true

module Phony
  module NationalSplitters
    # TODO
    #
    class DSL
      def >>(other)
        country_for other
      end

      def country_for(local_splitter)
        Phony::Country.new Phony::NationalCode.new(self, local_splitter)
      end

      # TODO: Remove?
      #
      def reserved; end
    end
  end
end
