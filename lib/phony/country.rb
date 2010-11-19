module Phony
  
  #
  #
  class Country
    
    def initialize national_code, special_code = nil
      @national_code = national_code
      @special_code  = special_code
    end
    
    #
    #
    def split national_number
      ndc, *rest = @special_code.split national_number if @special_code
      ndc, *rest = @national_code.split national_number unless rest && !rest.empty?
      [ndc, *rest]
    end
    
    # Get a configured country instance.
    #
    # Define your countries like this:
    # Phony::Countries::Austria = Phony::Country.configured <options>
    #
    # Example:
    #  Phony::Country.configured :local_format         => [3, 2, 2],
    #                            :special_local_format => [3, 3],
    #                            :ndc_fallback_length  => 4,
    #                            :ndc_mapping => {
    #                              :normal  => ['44'],
    #                              :service => ['800'],
    #                              :mobile  => ['76']
    #                            }
    #
    def self.configured options = {}
      ndc_fallback_length  = options[:ndc_fallback_length]
      ndc_mapping          = options[:ndc_mapping]
      
      # TODO Extract ndcs.
      #
      
      national_splitter = Phony::NationalSplitters::Variable.new ndc_fallback_length, ndc_mapping
      local_splitter    = Phony::LocalSplitter.instance_for options[:local_format] || [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter
      
      special_national_splitter = Phony::NationalSplitters::Variable.new nil, ndc_mapping
      special_local_splitter    = Phony::LocalSplitter.instance_for local_special_format || [3, 3]
      special_code              = Phony::SpecialCode.new special_national_splitter, special_local_splitter
      
      new national_code, special_code
    end
    
    # Gets a configured country instance with fixed length ndc code.
    #
    # Define your countries like this:
    # Phony::Countries::Switzerland = Phony::Country.fixed <options>
    #
    def self.configured options = {}
      ndc_fallback_length  = options[:ndc_fallback_length]
      ndc_mapping          = options[:ndc_mapping]
      
      # TODO Extract ndcs.
      #
      
      national_splitter = Phony::NationalSplitters::Variable.new ndc_fallback_length, ndc_mapping
      local_splitter    = Phony::LocalSplitter.instance_for options[:local_format] || [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter
      
      special_national_splitter = Phony::NationalSplitters::Variable.new nil, ndc_mapping
      special_local_splitter    = Phony::LocalSplitter.instance_for local_special_format || [3, 3]
      special_code              = Phony::SpecialCode.new special_national_splitter, special_local_splitter
      
      new national_code, special_code
    end
    
  end
  
end