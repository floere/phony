# Portuguese phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Portugal
#
Phony::Countries::Portugal = Phony::Country.configured :local_format => [3, 4],
  :local_special_format => [3, 3],
  :ndc_fallback_length => 3,
  :ndc_mapping => {
    :landline => [
      '21', # Lisboa
      '22', # Porto
    ],
    :mobile => ('90'..'99').to_a,
    :service => %w{700 800} # Not exhaustive.
  }