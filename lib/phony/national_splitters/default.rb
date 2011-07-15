module Phony

  module NationalSplitters

    class Default < DSL

      def self.instance_for
        new
      end

      def split number
        number
      end

    end
  end
end
