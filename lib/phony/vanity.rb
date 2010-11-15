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
    
    # Returns true if there is a character in the number
    # after the first four numbers.
    #
    @@vanity_regexp = /\A\d{3}[a-zA-Z]{6,12}\Z/
    def self.vanity? number
      # TODO Normalize before this and use /\A\d{4,}\w\d*\Z/.
      # number !~ /\A[\d\s]{4,}\w\d*\Z/
      !(normalized(number) =~ @@vanity_regexp).nil?
    end
    
    # Vanity-Normalized.
    #
    @@vanity_normalizing_regexp = /^0*|[^\d\w]/
    def self.normalized number
      number.gsub @@vanity_normalizing_regexp, ''
    end
    
  end
end