module Phony
  
  module NationalSplitters
    
    class Variable < Fixed
      
      #
      #
      def initialize fallback, ndc_map
        super fallback
        @ndcs, @special_ndcs = restructure ndc_map
      end
      
      # Takes a national number and splits it into ndc and rest.
      #
      def split national_number
        fallback_number = national_number.dup
        
        presumed_code = ''
        
        # Extract a starting point.
        #
        presumed_code << national_number.slice!(0..@mapped_ndc_min_length-2) if @mapped_ndc_min_length > 1
        
        # Try for all possible mapped.
        #
        @mapped_ndc_min_length.upto(@mapped_ndc_max_length) do |i|
          presumed_code << national_number.slice!(0..0)
          sized_ndcs = @ndcs[i]
          return [presumed_code, national_number] unless sized_ndcs && !sized_ndcs.include?(presumed_code)
        end
        
        # Not found.
        #
        return super(fallback_number)
      end
      
      def service? number
        ndc, _ = split number
        @special_ndcs[:service].include? ndc
      end
      def mobile? number
        ndc, _ = split number
        @special_ndcs[:mobile].include? ndc
      end
      def landline? number
        ndc, _ = split number
        !mobile?(ndc) && !service?(ndc)
      end
      
      private
        
        def restructure ndc_map
          [optimize(ndc_map.values.flatten), extract_special(ndc_map)] # TODO extract_services ndc_map
        end
        
        def extract_special ndc_map
          ndc_map.each_pair do |type, ndc|
            
          end
        end
        
        # Optimizes and restructures the given ndcs array.
        #
        def optimize(ndc_ary)
          ndcs = {}
          ndc_ary.each do |ndc|
            ndcs[ndc.length] ||= []
            ndcs[ndc.length] << ndc
          end
          keys = ndcs.keys
          @mapped_ndc_min_length = keys.min
          @mapped_ndc_max_length = keys.max
          ndcs
        end
      
    end
    
  end
  
end