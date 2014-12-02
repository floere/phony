# Austria uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
ndcs = [
  # '1', # Vienna
 '89',  # Routing Number
 '316', # Graz
 '463', # Klagenfurt
 '512', # Innsbruck
 '662', # Salzburg
 '732'  # Linz
]

corporate = [
  '57',  # -
  '59',  # -
  '501', # -
  '502', # -
  '503', # -
  '504', # -
  '505', # -
  '506', # -
  '507', # -
  '508', # -
  '509', # -
  '517', # -
  '720', #
]

mobile = [
 '644',
 '650',
 '651',
 '652',
 '653',
 '655',
 '657',
 '659',
 '660',
 '661',
 '664',
 '665',
 '666',
 '667',
 '668',
 '669',
 '676',
 '680',
 '681',
 '688',
 '699',
]

mobile_2digit = [
 '67',
 '68',
 '69',
]


service = [
 '710',
 '711',
 '718',
 '730',
 '740',
 '780',
 '800',
 '802',
 '804',
 '810',
 '820',
 '821',
 '828',
 '900',
 '901',
 '930',
 '931',
 '939'
]

# https://www.rtr.at/en/tk/E129/Austrian_Numbering_Plan_2011-03-30.pdf
#
# TODO Add more details.
#
Phony.define do
  country '43', trunk('0') |
                one_of('1')       >> split(3..12) | # Vienna
                one_of(service)   >> split(9..9) |
                one_of(corporate) >> split(5..5) |
                one_of(ndcs)      >> split(6..6) |
                one_of('663')     >> split(6..6) | # 6 digit mobile.
                one_of(mobile)    >> split(4,3..9) |
                one_of(mobile_2digit) >> split(7..7) | # Separate as mobile contains 676 - 67 violates the prefix rule.
                fixed(4)          >> split(7..7)
end