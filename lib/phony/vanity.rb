module Phony
  
  # Helper module that maps vanity numbers to digit numbers.
  #
  module Vanity
    
    # Returns a char to number mapping string for the String#tr method.
    #
    def self.mapping
      @@mapping ||= [
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.freeze,
        '2223334445556667777888999922233344455566677778889999'.freeze
      ]
    end
    
    # Replaces (and normalizes) vanity characters of passed number with correct digits.
    #
    def self.replace number
      number.tr(*mapping)
    end
    
    # Returns true if there is a character in the number
    # after the first three numbers.
    #
    @@vanity_regexp = /\A\d{3}[a-zA-Z]{6,12}\Z/
    def self.vanity? number
      !(normalized(number) =~ @@vanity_regexp).nil?
    end
    
    # Vanity-Normalized.
    #
    @@vanity_normalizing_regexp = /^0*|[^\w]/
    def self.normalized number
      number.gsub @@vanity_normalizing_regexp, ''
    end
    
  end
end