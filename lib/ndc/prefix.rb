# Splits a national number using a prefix code.
#
module E164
  module NDC
    class Prefix
      
      class_inheritable_accessor :starting_ndc_size, :max_ndc_size, :ndcs, :format
      
      def self.split(number)
        number = number.dup
        presumed_code = ''
        presumed_code << number.slice!(0..starting_ndc_size-2) if starting_ndc_size && starting_ndc_size > 1
        (starting_ndc_size || 1).upto(max_ndc_size) do |i|
          presumed_code << number.slice!(0..0)
          sized_ndcs = ndcs[i]
          break unless sized_ndcs && !sized_ndcs.include?(presumed_code)
        end
        return [presumed_code, number]
      end
      
      def self.formatted(number)
        (format || '%s %s %s %s') % split(number)
      end
      
    end
  end
end