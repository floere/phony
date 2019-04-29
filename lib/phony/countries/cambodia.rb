# frozen_string_literal: true

# Cambodia (Kingdom of)
# http://en.wikipedia.org/wiki/Telecommunications_in_Cambodia#Mobile_networks
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Cambodia
# http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000230001MSWE.doc
# http://www.khmerdigitalpost.com/national-numbering-plans-in-cambodia-by-2014/
# http://www.khmerdigitalpost.com/mobile-operators-in-cambodia-by-2015/

ndcs = [
  '23', # Phnom Penh
  '24', # Kandal
  '25', # Kampong Speu
  '26', # Kampong Chhnang
  '32', # Takeo
  '33', # Kampot
  '34', # Preah Sihanouk
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
  '10', # Smart
  '11', # Mobitel
  '13', # qb
  '14', # Mobitel
  '15', # Smart
  '16', # Smart
  '17', # Mobitel
  '60', # Metfone
  '61', # Mobitel
  '66', # Metfone
  '67', # Metfone
  '68', # Metfone
  '69', # Smart
  '70', # Smart
  '77', # Mobitel
  '78', # Mobitel
  '80', # qb
  '81', # Smart
  '83', # qb
  '84', # qb
  '85', # Mobitel
  '86', # Smart
  '87', # Smart
  '89', # Mobitel
  '90', # Metfone
  '93', # Smart
  '95', # Mobitel
  '98', # Smart
  '99', # Mobitel
]

six_digit_extended_range_mobile_prefixes = [
  '92' # Mobitel
]

seven_digit_mobile_prefixes = [
  '31', # Metfone
  '38', # CooTel
  '39', # EMAXX
  '71', # Metfone
  '76', # Mobitel
  '88', # Metfone
  '96', # Smart
  '97', # Metfone
]

variable_length_extended_range_mobile_prefixes = [
  '12' # Mobitel
]

mobile_prefixes_with_variable_length = [
  '18' # Seatel
]

six_digit_total_single_digit_fixed_line_prefixes = [
  '2',  # Telecom Cambodia
  '3',  # Mobitel
  '7',  # Telecom Cambodia
  '8',  # Telecom Cambodia
  '9',  # Camintel
]

six_digit_total_double_digit_fixed_line_prefixes = [
  '40', # Telecom Cambodia
  '41', # Telecom Cambodia
  '42', # Telecom Cambodia
  '43', # Telecom Cambodia
  '44', # Telecom Cambodia
]

seven_digit_total_single_digit_fixed_line_prefixes = [
  '6',  # Metfone
]

seven_digit_total_double_digit_fixed_line_prefixes = [
  '45', # Smart
  '46', # Metfone
  '47', # CooTel
  '48', # Excell
  '49', # qb
  '50', # Mobitel
  '51', # Mobitel
  '52', # Mobitel
  '53', # Mobitel
  '54', # Mobitel
  '55', # Mobitel
  '56', # Smart
]

Phony.define do
  country '855', trunk('0', :normalize => true) |
                 one_of(mobile_prefixes_with_variable_length) >> matched_split(/^9/ => [3, 4], /^[2-8]/ => [3, 3]) |
                 one_of(variable_length_extended_range_mobile_prefixes) >> matched_split(/^1/ => [3, 4], /^[2-9]/ => [3, 3]) |
                 one_of(six_digit_mobile_prefixes)   >> matched_split(/^[2-9]/ => [3, 3]) |
                 one_of(six_digit_extended_range_mobile_prefixes) >> matched_split(/^[1-9]/ => [3, 3]) |
                 one_of(seven_digit_mobile_prefixes) >> matched_split(/^[2-9]/ => [3, 4]) |
                 one_of(ndcs) >> matched_split(/^(#{seven_digit_total_double_digit_fixed_line_prefixes.join('|')})\d{5}$/ => [3, 4], /^(#{seven_digit_total_single_digit_fixed_line_prefixes.join('|')})\d{6}$/ => [3, 4], /^(#{six_digit_total_double_digit_fixed_line_prefixes.join('|')})\d{4}$/ => [3, 3], /^(#{six_digit_total_single_digit_fixed_line_prefixes.join('|')})\d{5}$/ => [3, 3])
end
