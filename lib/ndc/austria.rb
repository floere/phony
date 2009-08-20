# Splits a national number into a fixed size NDC and rest.
#
module E164
  module NDC
    class Austria < Prefix
      
      length 1..4
      local 10
      
      ndcs '1',# Wient
        '57',  # -
        '59',  # -
        '67',  # Mobile Services
        '68',  # Mobile Services
        '89',  # Routing Number
        '316', # Graz
        '501', # -
        '502', # -
        '503', # -
        '504', # -
        '505', # -
        '506', # -
        '507', # -
        '508', # -
        '509', # -
        '512', # Innsbruck
        '517', # -
        '644', # Mobile Services
        '650', # Mobile Services
        '651', # Mobile Services
        '652', # Mobile Services
        '653', # Mobile Services
        '655', # Mobile Services
        '657', # Mobile Services
        '659', # Mobile Services
        '660', # Mobile Services
        '661', # Mobile Services
        '662', # Salzburg
        '663', # Mobile Services
        '664', # Mobile Services
        '665', # Mobile Services
        '666', # Mobile Services
        '667', # Mobile Services
        '668', # Mobile Services
        '669', # Mobile Services
        '710', # Service Number
        '711', # Service Number
        '718', # Service Number
        '720', #
        '730', # Service Number
        '732', # Linz
        '740', # Service Number
        '780', # Service Number
        '800', # Service Number
        '802', # Service Number
        '804', # Service Number
        '810', # Service Number
        '820', # Service Number
        '821', # Service Number
        '828', # Service Number
        '900', # Service Number
        '901', # Service Number
        '930', # Service Number
        '931', # Service Number
        '939'  # Service Number
      
    end
  end
end