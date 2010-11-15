module Phony
  module Vanity
    
    # Returns a char to number mapping string for the String#tr method.
    #
    def self.mapping
      @@mapping ||= [
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.freeze,
        '2223334445556667777888999922233344455566677778889999'.freeze
      ]
    end
    
    # Replaces vanity characters of passed number with correct digits.
    # Does not check for validity of vanity_number. Simply replaces all characters in the number
    #
    def self.replace number
      number.tr *mapping
    end
    
  end
end