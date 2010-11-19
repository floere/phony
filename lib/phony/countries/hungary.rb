# Hungarian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Hungary
#
Phony::Countries::Hungary = Phony::Country.configured :local_format => [3, 4], # Also captures 3, 3 on a fallback.
                                                      :local_special_format => [3, 3],
                                                      :ndc_fallback_length => 2,
                                                      :ndc_mapping => {
                                                        # 1 is Budapest.
                                                        # All others are captured using
                                                        # the fallback length 2.
                                                        #
                                                        :landline => [
                                                                       '1'
                                                                      ],
                                                        :mobile   => [], # TODO
                                                        :service  => [
                                                                       '104',
                                                                       '105',
                                                                       '107',
                                                                       '112'
                                                                     ]
                                                      }