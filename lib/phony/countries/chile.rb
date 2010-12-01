# Chilean phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Chile
# http://www.wtng.info/wtng-56-cl.html
#
# TODO Totally unsure about this one, as I get contradicting infos.
#      As usual, best effort.
#
Phony::Countries::Chile = Phony::Country.configured :local_format => [8],
                                                    :local_special_format => [3, 3],
                                                    :ndc_fallback_length => 2,
                                                    :ndc_mapping => {
                                                      :landline => [
                                                                    '2', # Santiago
                                                                   ],
                                                      :mobile   => [
                                                                    '9',
                                                                   ],
                                                      :service  => %w{130 131 132 133 134 135 136 137 139 147 149}
                                                    }