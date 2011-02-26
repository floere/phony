include Phony::DSL

# TODO Move this into the country definitions.

# Egyptian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Egypt
#
ndcs = [
  '2', # Cairo/Giza
  '3', # Alexandria
]

# TODO Change how one_of works. max_length should be optional.
#
Phony::Countries::Egypt = one_of('800') >> split(7) |
                          one_of(*ndcs, :max_length => 2) >> split(8)