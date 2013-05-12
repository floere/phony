module Phony
  
  module CountryDetectors
  
    class NanpCountryDetector

      NANP_CODES = {
        CA: [ # Canada
          # Alberta
          403, 587, 780, 825,
          # British Columbia
          236, 250, 604, 672, 778,
          # Manitoba
          204, 431,
          # New Brunswick
          506,
          # Newfoundland and Labrador
          709,
          # Nova Scotia
          902,
          # Ontario
          226, 249, 289, 343, 365, 416, 437, 519, 613, 647, 705, 807, 905,
          # Prince Edward Island
          902,
          # Quebec
          418, 438, 450, 514, 579, 581, 819, 873,
          # Saskatchewan
          306, 639,
          # Yukon, Northwest Territories, and Nunavut
          867
        ].map { |code| code.to_s },
        AS: %w( 684 ), # American Samoa
        AI: %w( 264 ), # Anguila
        AG: %w( 268 ), # Antigua & Barbuda
        BS: %w( 242 ), # The Bahamas
        BB: %w( 246 ), # Barbados
        BM: %w( 441 ), # Bermuda
        VG: %w( 284 ), # British Virgin Islands
        KY: %w( 345 ), # Cayman Islands
        DM: %w( 767 ), # Dominica
        DO: %w( 809, 829, 849 ), # Dominican Republic
        GD: %w( 473 ), # Grenada
        GU: %w( 671 ), # Guam
        JM: %w( 876 ), # Jamaica
        MS: %w( 664 ), # Montserrat
        KN: %w( 869 ), # St Kitts & Nevis
        MP: %w( 670 ), # Northern Mariana Islands
        PR: %w( 787, 939 ), # Puerto Rico
        LC: %w( 758 ), # St. Lucia
        VC: %w( 784 ), # St Vincent & the Grenadines
        SX: %w( 721 ), # Sint Martin
        TT: %w( 868 ), # Trinidad & Tobago
        TC: %w( 649 ), # Turks & Caicos Islands
        VI: %w( 340 ) # US Virgin Islands
      }.freeze

      def country number
        # Split the given number unless it is an array (assumes that is has already been split)
        number = Phony.split(number) unless number.is_a?(Array)
        
        # Loop over all NANP countries to detect 
        NANP_CODES.each do |alpha2, codes|
          return alpha2 if codes.include? number[1]
        end
        
        return :US # If not found in the prior lists, assume US
      end
      
      def recognized_countries
        NANP_CODES.keys + [ :US ]
      end

    end

  end # CountryDetectors

end # Phony
