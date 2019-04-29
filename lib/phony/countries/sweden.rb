# frozen_string_literal: true

# Sweden uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Note: Sweden use a variable ndc format from length 2 to 3.
#       To save space, we only use ndcs of length 1 and 2 (and use the fallback of 3 to handle the rest).
#
# Taken from: http://en.wikipedia.org/wiki/Telephone_numbers_in_Sweden
#             http://www.pts.se/upload/Ovrigt/Tele/Nummerfragor/bilaga-2b.pdf
#

ndcs = [
 # '7',  # Non-geographic - conflicts with mobile
  '8',  # Stockholm
  '10', # VOIP
  '11', # Norrköping
  '13', # Linköping
  '16', # Eskilstuna-Torshälla
  '18', # Uppsala
  '19', # Örebro-Kumla
  '20', # toll-free
  '21', # Västerås
  '23', # Falun
  '26', # Gävle-Sandviken
  '31', # Göteborg
  '33', # Borås
  '35', # Halmstad
  '36', # Jönköping-Huskvarna
  '40', # Malmö
  '42', # Helsingborg-Höganäs
  '44', # Kristianstad
  '46', # Lund
  '54', # Karlstad
  '60', # Sundsvall-Timrå
  '63', # Östersund
  '90', # Umeå
  '77', # Dalarna
]
mobile = [
 '70', # Mobile
 '71', # Telematics
 '72', # Mobile
 '73', # Mobile
 '74', # Pagers
 '76', # Mobile
 '79', # Mobile
]
services = [
    '112', # Emergency Service
   '1177', # Health Care Advice
  '11414', # Police
]
service_ndcs = [
  '99',  # Premium Rate
  '900', # Premium Rate
  '939', # Premium Rate
  '944', # Premium Rate
]
three_digit_service = [
  '116', # Psychological Help (116 xxx)
  '118', # Number enquiries (118 xxx)
]

Phony.define do
  country '46',
    trunk('0') |
    match(/^(#{services.join('|')})$/) >> split(0) |
    one_of(service_ndcs)       >> split(3,3) |
    match(/^(#{three_digit_service.join('|')})\d{3}$/) >> split(3) |
    one_of(ndcs + mobile)      >> matched_split(
      /^\d{5}$/ => [3, 2],
      /^\d{6}$/ => [2, 2, 2],
      /^\d{7}$/ => [3, 2, 2],
      /^\d{8}$/ => [3, 2, 3]
    ) |
    fixed(3)                   >> matched_split(
      /^\d{5}$/ => [3, 2],
      /^\d{6}$/ => [2, 2, 2]
    )
end
