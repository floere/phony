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
# Countries::Germany = match(...) >> split([...]) ||
#                      one_of([...], :max_length => 5) >> split([...])
# 
# # Denmark.
# #
# country('45', none >> split([2,2,2,2])) # Denmark.
# 
# # Hungary.
# # 
# country('36',
#         match(/^104|105|107|112/) >> split([3,3]) ||
#         one_of([1], :max_length => 2) >> split([3,4])
# )

module Phony
  
  module DSL

    # 
    #
    def country country_code, country
      Phony::CountryCodes.instance.add country_code, country
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
    def match regex, options = {}
      NationalSplitters::Regex.instance_for regex, options[:on_fail_take]
    end
    
    # Local splitters.
    #
    
    #
    #
    def split *local
      LocalSplitters::Fixed.instance_for local
    end
    def matched_split options = {}
      Phony::LocalSplitters::Regex.instance_for options
    end
    
  end
  
end