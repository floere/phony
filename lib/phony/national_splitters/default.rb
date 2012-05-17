module Phony

  module NationalSplitters

    class Default < DSL

      def self.instance_for
        @instance ||= new
      end

      def split national_number
        [nil, nil, national_number]
      end

    end
  end
end
