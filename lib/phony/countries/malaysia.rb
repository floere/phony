# Malaysian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Malaysia
#
ndcs = [
  '2', # Singapore
  '3', # Selangor & Federal Territories of Kuala Lumpur & Putrajaya & also Genting Highlands, Pahang
  '4', # Kedah, Penang & Perlis
  '5', # Perak & Cameron Highlands (Pahang)
  '6', # Melaka, Negeri Sembilan & Muar (Johor)
  '7', # Johor (except Muar)
  '9', # Kelantan, Pahang (except Cameron Highlands & Genting Highlands) & Terengganu
]
mobile = %w{ 10 11 12 13 14 153 154 156 158 16 17 18 19 }
service = %w{ 100 101 102 103 104 108 991 994 995 999 }  # Emergeny and Service numbers, only 3 digits long
freephone = %w{ 300 700 800 }

Phony.define do
  country '60', one_of(freephone) >> split(2,4) | # Freephone, Tollfree, Forwarding
                # one_of(service) >>  none  | # Service
                one_of(mobile)  >> split(4,4)   | # Mobile
                one_of(ndcs)    >> split(8)     | # 1-digit NDCs
                fixed(2)        >> split(8),       # 2-digit NDCs (Also, fallback)
                length( 1 => 9, 2 => 10, 3 => 9 )
end