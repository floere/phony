# Sweden uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Note: Sweden use a variable ndc format from length 2 to 3.
#       To save space, we only use ndcs of length 1 and 2 (and use the fallback of 3 to handle the rest).
#
# Taken from: http://en.wikipedia.org/wiki/Telephone_numbers_in_Sweden
#             http://www.pts.se/upload/Ovrigt/Tele/Nummerfragor/bilaga-2b.pdf
#

ndcs = [
 '7',  # Non-geographic
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
]
mobile = [
 '70', # Mobile
 '71', # Telematics
 '72', # Mobile
 '73', # Mobile
 '74', # Pagers
 '76', # Mobile
]
service = [
    '99', # Premium Rate
   '112', # Emergency Service
   '116', # Psychological Help
   '118', # Number enquiries
   '900', # Premium Rate
   '939', # Premium Rate
   '944', # Premium Rate
  '1177', # Health Care Advice
 '11414', # Police
]

Phony.define do
  country '46', one_of(service)       >> split(3,3) |
                one_of(ndcs + mobile) >> split(8)   |
                fixed(3)              >> split(8)     # catchall
end