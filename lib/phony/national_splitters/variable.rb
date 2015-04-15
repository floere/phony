module Phony
  
  module NationalSplitters
    
    class Variable < Fixed
      
      #
      #
      def initialize fallback, ndcs, options = {}
        super fallback, options
        @ndcs = optimize ndcs
      end
      
      # Takes a national number and splits it into ndc and rest.
      #
      def split national_number
        fallback_number = national_number.dup
        
        # Extract a starting point.
        #
        # This if can possibly be removed.
        #
        presumed_code = if @mapped_ndc_min_length > 0
          presumed_code = national_number.slice!(0..@mapped_ndc_min_length-1)
        else
          ''
        end
        
        # Try for all possible mapped.
        #
        @mapped_ndc_min_length.upto @mapped_ndc_max_length do |i|
          ndcs_of_size_i = @ndcs[i]
          return [@zero, presumed_code, national_number] unless ndcs_of_size_i && !ndcs_of_size_i.include?(presumed_code)
          presumed_code << national_number.slice!(0..0)
        end
        
        # Not found.
        #
        super fallback_number
      end
      
      # A valid length.
      #
      def length
        (@mapped_ndc_min_length..@mapped_ndc_max_length)
      end
      
      private
        
        # Optimizes and restructures the given ndcs array.
        #
        def optimize ndc_ary
          ndcs = {}
          ndc_ary.each do |ndc|
            ndcs[ndc.length] ||= []
            ndcs[ndc.length] << ndc
          end
          keys = ndcs.keys
          @mapped_ndc_min_length = keys.min # || 1
          @mapped_ndc_max_length = keys.max
          ndcs
        end
      
    end
    
  end
  
end