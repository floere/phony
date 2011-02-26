# # Ideas for a DSL:
# #
# 
# # Switzerland
# #
# country('41', fixed(2) >> local([3,2,2]))
# country(match(/^1.*$/) >> [3,3] || none >> [2,2,2,2])
# 
# # Germany. Too big.
# #
# country('49', Countries::Germany)
# #
# # … and in Germany:
# #
# include Phony::DSL
# Countries::Germany = match(...) >> format([...]) ||
#                      one_of([...], :max_length => 5) >> format([...])
# 
# # Denmark.
# #
# country('45', none >> format([2,2,2,2])) # Denmark.
# 
# # Hungary.
# # 
# country('36',
#         match(/^104|105|107|112/) >> format([3,3]) ||
#         one_of([1], :max_length => 2) >> format([3,4])
# )

module Phony
  
  module DSL

    # 
    #
    def country country_code, *splitters
      codes = []
      splitters.flatten!
      until splitters.empty?
        codes << Phony::NationalCode.new(splitters.shift, splitters.shift)
      end
      country = Phony::Country.new *codes
      Phony::Countries.add country_code, country
    end

    # National matcher & splitters.
    #
    
    # 
    #
    def fixed size
      NationalSplitters::Fixed.instance_for size
    end
    def none
      NationalSplitters::None.instance_for
    end
    def one_of *ndcs
      options = Hash === ndcs.last ? ndcs.pop : {}
      
      NationalSplitters::Variable.new options[:max_length], ndcs
    end
    def match regex, max_length
      NationalSplitters::Regex.instance_for regex, max_length
    end
    
    # Local splitters.
    #
    
    #
    #
    def format *local
      LocalSplitters::Fixed.instance_for local
    end
    def matched_format options = {}
      Phony::LocalSplitters::Regex.instance_for options
    end
    
  end
  
end