# frozen_string_literal: true

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

corporate_2digit = [
  '57',
  '59'
]

corporate = [
  '501',
  '502',
  '503',
  '504',
  '505',
  '506',
  '507',
  '508',
  '509',
  '517'
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
 '670',
 '676',
 '677',
 '678',
 '680',
 '681',
 '688',
 '690',
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

# https://www.rtr.at/en/tk/E129/2312_Austrian_Numbering_Plan_2011-03-30.pdf
#
# TODO Add more details.
#
Phony.define do
  country '43', trunk('0')                                |
                one_of('1')              >> split(3..12)  | # Vienna
                one_of(service)          >> split(9..9)   |
                one_of('720')            >> split(6..10)  | # VoIP number length is 9..13
                one_of('800')            >> split(6..10)  | # Free number length is 9..13
                one_of(corporate_2digit) >> split(3..11)  | # Corporate number length is 5..13
                one_of(corporate)        >> split(2..10)  | # Corporate number length is 5..13
                one_of(ndcs)             >> split(6..10)  |
                one_of('663')            >> split(6..8)   | # 6..8 digit mobile.
                one_of(mobile)           >> split(4,3..9) |
                one_of(mobile_2digit)    >> split(7..7)   | # Separate as mobile contains 676 - 67 violates the prefix rule.
                fixed(4)                 >> split(3..9)     # Number length is 7..13.
end
