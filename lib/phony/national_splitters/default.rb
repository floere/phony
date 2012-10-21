module Phony

  module NationalSplitters

    class Default < DSL

      def self.instance_for
        @instance ||= new
      end

      def split national_number
        [national_number]
      end

    end
  end
end
