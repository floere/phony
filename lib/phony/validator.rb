# # Number: A possible phone number, E164 or not.
# # Hints: Information that helps or constricts the plausibility check.
# #
# plausible? number, hints = {}
#

# plausible? number # Uses the definitions from the country definition to plausibility check.
# plausible? number, cc: 1 # => Checks cc.
# plausible? number, pattern: /[^5]/ # Uses def, checks against split.
# plausible? number, country: 1, pattern: [3, 4, 3] # Uses given country – adds cc.
#

# Basic plausibility is:
# * Max digits are 15.
# * Min digits are 2 (?)
#

module Phony
  
  class Validator
    
    # TODO Beautify.
    #
    def plausible? number, hints = {}
      normalized = normalize number
      
      # False if it fails the basic check.
      #
      return false unless normalized.size === (2..15)
      
      # Hint based checking.
      #
      cc, ndc, *rest = split normalized
      
      # CC.
      #
      cc_needed = hints[:cc]
      return false if cc_needed && cc_needed != cc
      
      # NDC.
      #
      ndc_needed = hints[:ndc]
      return false if ndc_needed && ndc_needed != ndc
      
      # Country specific checks?
      #
      
      # Get the country.
      #
      
      # Check.
      #
      
    rescue StandardError
      return false
    end
    
    def normalize number
      number
    end
    
  end
  
end