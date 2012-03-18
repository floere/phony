module Phony
  
  class Validator
  
    attr_reader :ndc_checks 
  
    def initialize
      @ndc_checks = []
    end
  
    def plausible? ndc, rest
      ndc_checks && ndc_checks.each do |ndc_check|
        return false if ndc_check === ndc
      end
      
      true
    end
  
    def ndc_check ndc
      @ndc_checks << ndc
      self
    end
    
  end
  
end