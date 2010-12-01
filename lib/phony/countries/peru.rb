# Peruvian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Peru
#
Phony::Countries::Peru = Phony::Country.configured :local_format => [4, 4],
                                                   :local_special_format => [3, 3],
                                                   :ndc_fallback_length => 2,
                                                   :ndc_mapping => {
                                                     :landline => [
                                                                   '1', # Lima
                                                                  ],
                                                     :mobile   => [
                                                                   '9',
                                                                  ],
                                                     :service  => [
                                                                   '103',
                                                                   '105',
                                                                  ]
                                                   }