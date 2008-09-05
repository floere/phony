# Splits a national number using a prefix code.
#
# DSL:
#   length: the length range of the dcs. For austria it is 1..4.
#   format: the format of the dcs and rest. For austria it is '%s %s', default is '%s %s %s %s'.
#   ndcs:   an array of the prefix codes. For germany it starts with ['10', '11', '12', '13', '30'…
#
module E164
  module NDC
    class Prefix < Splitter
      
      # Splits the number into ndc and rest.
      #
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
      
      protected
        
        # Define the length range for the country's ndcs.
        #
        def self.length(range)
          @min_ndc_length, @max_ndc_length = range.min, range.max
        end
        
        # Define the list of NDCs.
        #
        # Note: For optimization, if the country has a max ndc length of 4,
        #       only enter ndcs up to the length of 3 letters.
        #       If the algorithm fails to match an ndc, it will assume it is a 4 digit ndc.
        #
        # e.g. We have NDCs '1', '22', '333', and '4444'.
        #      Only set
        #        ndcs '1', '22', '333'
        #      and
        #        length 1..4
        #      '4444' will be "recognized" because the algorithm does not find a shorter ndc (assuming it
        #      is a correct prefix code) and stop at the max ndc length of 4, given by the length method.
        #
        def self.ndcs(*ndcs_ary)
          @ndcs = optimize(ndcs_ary)
        end
        
      private
        
        # Optimizes and restructures the given ndcs array.
        #
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