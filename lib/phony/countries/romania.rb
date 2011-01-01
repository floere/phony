# Romanian phone numbers.
#
# http://en.wikipedia.org/wiki/Romania_telephone_area_codes
#
Phony::Countries::Romania = Phony::Country.configured :local_format => [3, 4], # Also captures 3, 3 on a fallback.
  :local_special_format => [3, 3],
  :ndc_fallback_length => 3,
  :ndc_mapping => {
    :landline => [
                   '21', # Bucureşti
                   '31', # Bucureşti
                  ],
    :mobile   => [
                  '71',
                  '72',
                  '73',
                  '74',
                  '75',
                  '76',
                  '77',
                  '78',
                 ],
    :service  => [
                  '112',
                  '800',
                  '900',
                  '903',
                  '906',
                 ]
  }