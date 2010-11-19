module Phony
  
  # Does handling of special numbers, like 0800.
  #
  class SpecialCode < NationalCode
    
    # def initialize ndc_map_and_options = {}
    #   # TODO Actually, there is no fallback. Make option.
    #   #
    #   local_format = ndc_map_and_options.delete :local_format
    #   super NationalSplitters::Variable.new(4, ndc_map_and_options),
    #         LocalSplitter.instance_for(local_format || [3,3])
    # end
    
    # @@not_found = [nil, nil]
    # def split national_number
    #   ndc, rest = @national_splitter.split national_number
    #   return @@not_found unless rest
    #   [ndc, *@local_splitter.split(rest)]
    # end
    
    def service? number
      ndc, _ = split number
      @service_ndcs.include? ndc
    end
    def mobile? number
      ndc, _ = split number
      @mobile_ndcs.include? ndc
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