# Belgium uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Taken from: http://en.wikipedia.org/wiki/Telephone_numbers_in_Belgium
#
Phony::Countries::Belgium = Phony::Country.configured :local_format => [3, 5],
 :mobile_local_format => [6],
 :ndc_fallback_length => 2,
 :ndc_mapping => {
   :landline => [
                 '2', # Brussels (Bruxelles/Brussel)
                 '3', # Antwerpen (Antwerp), Sint-Niklaas
                 '4', # Liège (Luik), Voeren (Fourons)
                 '9', # Gent (Ghent/Gand)
                ],
   :mobile => [
                '470', # Mobistar
                '471', # Mobistar
                '472', # Mobistar
                '473', # Mobistar
                '474', # Mobistar
                '475', # Mobistar
                '476', # Mobistar
                '477', # Mobistar
                '478', # Mobistar
                '479', # Mobistar
                '480', # Base
                '481', # Base
                '482', # Base
                '483', # Base
                '484', # Base
                '485', # Base
                '486', # Base
                '487', # Base
                '488', # Base
                '489', # Base
                '490', # Proximus
                '491', # Proximus
                '492', # Proximus
                '493', # Proximus
                '494', # Proximus
                '495', # Proximus
                '496', # Proximus
                '497', # Proximus
                '498', # Proximus
                '499', # Proximus
              ],
   :service => [
                 '70', # Specialty numbers, i.e. bus information or bank information
                '800', # Tollfree
                '900', # Premium
                '901', # Premium
                '902', # Premium
                '903', # Premium
                '904', # Premium
                '905', # Premium
                '906', # Premium
                '907', # Premium
                '908', # Premium
                '909'  # Premium
               ]
 }