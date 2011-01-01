# Greece uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Note: Greece uses a variable ndc format from length 2 to 4.
#       To save space, we only use ndcs of length up to 3 (and use the fallback).
#
Phony::Countries::Greece = Phony::Country.configured :local_format => [6],
  :ndc_fallback_length => 4,
  :ndc_mapping => {
    :landline => [
                  '21',  # Athens
                  '231', # Thessaloniki
                  '241', # Larissa
                  '251', # Kavala
                  '261', # Patras
                  '271', # Tripoli
                  '281', # Heraklion
                  ],
    :mobile => [
                '690',
                '693',
                '694',
                '695',
                '697',
                '698',
                '699'
               ],
    :service => [ # TODO
                 '800'
                ]
  }