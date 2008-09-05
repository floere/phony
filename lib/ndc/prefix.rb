# Splits a national number using a prefix code.
#
# DSL:
#   length: the length range of the dcs. For austria it is 1..4.
#   format: the format of the dcs and rest. For austria it is '%s %s', default is '%s %s %s %s'.
#   ndcs:   an array of the prefix codes. For germany it starts with ['10', '11', '12', '13', '30'…
#
module E164
  module NDC
    class Prefix
      
      def self.length(range)
        @min_ndc_length, @max_ndc_length = range.min, range.max
      end
      def self.format(format)
        @format = format
      end
      def self.ndcs(ndcs_ary)
        @ndcs = optimize(ndcs_ary)
      end
      
      def self.split(number)
        number = number.dup
        presumed_code = ''
        presumed_code << number.slice!(0..@min_ndc_length-2) if @min_ndc_length && @min_ndc_length > 1
        (@min_ndc_length || 1).upto(@max_ndc_length) do |i|
          presumed_code << number.slice!(0..0)
          sized_ndcs = @ndcs[i]
          break unless sized_ndcs && !sized_ndcs.include?(presumed_code)
        end
        return [presumed_code, number]
      end
      
      def self.formatted(number)
        (@format || '%s %s %s %s') % split(number)
      end
      
      private
        
        def self.optimize(ndcs_ary)
          ndcs = {}
          ndcs_ary.each do |ndc|
            ndcs[ndc.length] ||= []
            ndcs[ndc.length] << ndc
          end
          ndcs
        end
      
    end
  end
end