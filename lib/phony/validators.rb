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
  
  class Validators

    attr_accessor :country_validators

    def initialize
      @country_validators = {}
    end


    def self.instance
      @instance ||= new
    end
    
    # Add a specific country validator (or an array of validators)
    #
    def add cc, validator
      @country_validators[cc] = validator
    end
    
    # Is the given number plausible?
    #
    def plausible? number, hints = {}
      normalized = CountryCodes.instance.clean number
      
      # False if it fails the basic check.
      #
      return false unless (4..15) === normalized.size
      
      # Hint based checking.
      #
      cc, ndc, *rest = Phony.split normalized
      
      # Element based checking.
      #
      # Note: ndc == false means the country has none.
      #
      return false if ndc.nil?
      return false if ndc && ndc.empty?
      
      # A valid range for the rest is 0 or 3+ total digits.
      #
      return false if (1..2) === rest.reduce(0) { |total, string| total + string.size }
      
      # CC.
      #
      cc_needed = hints[:cc]
      return false if cc_needed && !(cc_needed === cc)
      
      # NDC.
      #
      ndc_needed = hints[:ndc]
      return false if ndc_needed && !(ndc_needed === ndc)
      
      # Country specific checks.
      #
      validators = [*validator_for(cc)]
      valid = validators.map do |validator|
                validator.plausible? ndc, rest
      end
      return false if valid.include? false

      true
    rescue StandardError
      return false
    end
    
    def validator_for cc
      @country_validators[cc] || default_validator
    end
    
    def default_validator
      @default_validator ||= Validator.new
    end
    
  end
  
end