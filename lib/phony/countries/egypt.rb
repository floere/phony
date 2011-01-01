# Egyptian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Egypt
#
Phony::Countries::Egypt = Phony::Country.configured :local_format => [8],
  :local_special_format => [7],
  :ndc_fallback_length => 2,
  :ndc_mapping => {
    :landline => [
                    '2', # Cairo/Giza
                    '3', # Alexandria
                   '13', # Banha
                   '15', # 10th of Ramadan
                   '45', # Damanhur
                   '46', # Marsa Matruh
                   '47', # Kafer El Sheik
                   '48', # Monufia
                   '50', # Mansoura
                   '55', # Zazazig
                   '56', # Spare
                   '57', # Damiette
                   '62', # Suez
                   '64', # Ismailia
                   '65', # Red Sea
                   '66', # Port Said
                   '68', # El Arish
                   '69', # El-Tor
                   '82', # Beni Suef
                   '84', # Fayoum
                   '86', # Minia
                   '88', # Assiout
                   '92', # Wadi El Gehid
                   '93', # Sohag
                   '95', # Luxor
                   '96', # Qunea
                   '97', # Aswan
                  ],
    :mobile => %w{10 11 12 14 16 17 18 19},
    :service => %w{800} # Not exhaustive.
  }