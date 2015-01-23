# Cambodia (Kingdom of)
# http://en.wikipedia.org/wiki/Telecommunications_in_Cambodia#Mobile_networks
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Cambodia
# http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000230001MSWE.doc

ndcs = [
  '23', # Phnom Penh
  '24', # Kandal
  '25', # Kampong Speu
  '26', # Kampong Chhnang
  '32', # Takeo
  '33', # Kampot
  '34', # Sihanoukville
  '35', # Koh Kong
  '36', # Kep
  '42', # Kampong Cham
  '43', # Prey Veng
  '44', # Svay Rieng
  '52', # Pursat
  '53', # Battambang
  '54', # Banteay Meanchey
  '55', # Pailin
  '62', # Kampong Thom
  '63', # Siem Reap
  '64', # Preah Vihear
  '65', # Oddar Meanchey
  '72', # Kratie
  '73', # Mondulkiri
  '74', # Stung Treng
  '75', # Ratanakiri
]

six_digit_mobile_prefixes = [
  '60', # Beeline
  '66', # Beeline
  '67', # Beeline
  '68', # Beeline
  '90', # Beeline
  '11', # Mobitel
  '17', # Mobitel
  '61', # Mobitel
  '77', # Mobitel
  '78', # Mobitel
  '85', # Mobitel
  '89', # Mobitel
  '92', # Mobitel
  '95', # Mobitel
  '99', # Mobitel
  '18', # Excell
  '13', # qb
  '80', # qb
  '83', # qb
  '84', # qb
  '10', # Smart
  '15', # Smart
  '16', # Smart
  '69', # Smart
  '70', # Smart
  '81', # Smart
  '86', # Smart
  '87', # Smart
  '93', # Smart
  '98', # Smart
]

seven_digit_mobile_prefixes = [
  '31', # Beeline
  '38', # CooTel
  '71', # Metfone
  '76', # Mobitel
  '88', # Metfone
  '96', # Smart
  '97', # Metfone
]

six_or_seven_digit_mobile_prefixes = [
  '12' # Mobitel
]

Phony.define do
  country '855', trunk('0', :normalize => true) | one_of(six_digit_mobile_prefixes)   >> matched_split(/^[1-9]/ => [3, 3]) |
                 one_of(seven_digit_mobile_prefixes) >> matched_split(/^[2-9]/ => [3, 4]) |
                 one_of(six_or_seven_digit_mobile_prefixes) >> matched_split(
                   /^[2-9]\d{5}$/ => [3, 3], /^[1-9]\d{6}$/ => [3, 4]
                 ) |
                 one_of(ndcs) >> matched_split(/^[2-9]\d{5}$/ => [3, 3], /^[2-9]\d{6}$/ => [3, 4])
end
