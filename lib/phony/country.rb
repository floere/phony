module Phony
  
  #
  #
  class Country
    
    def initialize national_code, special_code = nil, mobile_code = nil
      @national_code = national_code
      @special_code  = special_code
      @mobile_code   = mobile_code
    end
    
    #
    #
    def split national_number
      ndc, *rest = @special_code.split national_number if @special_code
      return [ndc, *rest] if rest && !rest.empty?
      ndc, *rest = @mobile_code.split national_number if @mobile_code
      return [ndc, *rest] if rest && !rest.empty?
      ndc, *rest = @national_code.split national_number
      [ndc, *rest]
    end
    
    # Removes 0s from partially normalized numbers
    # such as 410443643533.
    # 
    # Example:
    #   410443643533 -> 41443643533
    #
    # In some cases it doesn't, like Italy.
    #
    def normalize national_number
      normalized = @special_code.normalize national_number if @special_code
      return normalized if normalized && !normalized.empty?
      normalized = @mobile_code.normalize national_number if @mobile_code
      return normalized if normalized && !normalized.empty?
      @national_code.normalize national_number
    end
    
    # Is this national number a vanity number?
    #
    def vanity? national_number
      Vanity.vanity? national_number
    end
    #
    #
    def vanity_to_number vanity_number
      ndc, *rest = split vanity_number
      "#{ndc}#{Vanity.replace(rest.join)}"
    end
    
    
    # Get a configured country instance.
    #
    # Define your countries like this:
    # Phony::Countries::Austria = Phony::Country.configured <options>
    #
    # Example:
    #  Phony::Country.configured :local_format         => [3, 2, 2],
    #                            :service_local_format => [3, 3],
    #                            :ndc_fallback_length  => 4,
    #                            :ndc_mapping => {
    #                              :normal  => ['44'],
    #                              :service => ['800'],
    #                              :mobile  => ['76']
    #                            }
    #
    # Service numbers can have a special formatting.
    # Cellphones usually use the same as the landline.
    # If that is not the case, I will expand the framework.
    #
    def self.configured options = {}
      normalize            = options[:normalize]
      ndc_fallback_length  = options[:ndc_fallback_length]
      ndc_mapping          = options[:ndc_mapping] || raise("No ndc_mapping given!")
      
      national_splitter = Phony::NationalSplitters::Variable.new ndc_fallback_length, ndc_mapping
      local_splitter    = Phony::LocalSplitter.instance_for options[:local_format] || [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter, normalize
      
      if ndc_mapping[:service]
        service_national_splitter = Phony::NationalSplitters::Variable.new nil, :service => ndc_mapping[:service]
        service_local_splitter    = Phony::LocalSplitter.instance_for options[:service_local_format] || [3, 6]
        service_code              = Phony::NationalCode.new service_national_splitter, service_local_splitter, normalize
      end
      if ndc_mapping[:mobile]
        mobile_local_format      = options[:mobile_local_format] || options[:local_format] || [9]
        mobile_national_splitter = Phony::NationalSplitters::Variable.new nil, :mobile => ndc_mapping[:mobile]
        mobile_local_splitter    = Phony::LocalSplitter.instance_for mobile_local_format
        mobile_code              = Phony::NationalCode.new mobile_national_splitter, mobile_local_splitter, normalize
      end
      
      new national_code, service_code, mobile_code
    end
    
    # Gets a configured country instance with fixed length ndc code.
    #
    # Define your countries like this:
    # Phony::Countries::Switzerland = Phony::Country.fixed <options>
    #
    # Example:
    #  Phony::Country.fixed :ndc_length           => 4,
    #                       :local_format         => [3, 2, 2],
    #                       :service_local_format => [3, 3],
    #                       :service_ndcs         => ['800']
    #
    def self.fixed options = {}
      normalize    = options[:normalize]
      ndc_length   = options[:ndc_length]
      service_ndcs = options[:service_ndcs]
      local_format = options[:local_format]
      
      national_splitter = Phony::NationalSplitters::Fixed.new ndc_length
      local_splitter    = Phony::LocalSplitter.instance_for local_format || [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter, normalize
      
      service_code = nil
      if service_ndcs
        service_local_format      = options[:service_local_format] || local_format || [3, 3]
        service_national_splitter = Phony::NationalSplitters::Variable.new nil, :service => service_ndcs
        service_local_splitter    = Phony::LocalSplitter.instance_for service_local_format
        service_code              = Phony::NationalCode.new service_national_splitter, service_local_splitter, normalize
      end
      
      new national_code, service_code
    end
    
  end
  
end