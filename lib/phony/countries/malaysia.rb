# frozen_string_literal: true

# Malaysian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Malaysia
#
ndcs = [
  '2', # Singapore
  '4', # Kedah, Penang & Perlis
  '5', # Perak & Cameron Highlands (Pahang)
  '6', # Melaka, Negeri Sembilan & Muar (Johor)
  '7', # Johor (except Muar)
  '9', # Kelantan, Pahang (except Cameron Highlands & Genting Highlands) & Terengganu
]

ndcs_two_digits = [
  '80', # Domestic access code from East Malaysia to  Brunei
  '81', # Reserved number for future use
  '82', # Sarawak – Kuching, Samarahan and Serian
  '83', # Sarawak – Sri Aman and Betong
  '84', # Sarawak – Sibu, Sarikei, Mukah and Kapit
  '85', # Sarawak – Miri, Limbang and Lawas
  '86', # Sarawak – Bintulu and Belaga
  '87', # Labuan Interior Division,  Sabah
  '88', # Sabah – Kota Kinabalu and Kudat
  '89', # Sabah – Lahad Datu, Sandakan and Tawau
]

mobile = %w{ 10 11 12 13 14 153 154 156 158 16 17 18 19 }
# service = %w{ 100 101 102 103 104 108 991 994 995 999 }  # Emergeny and Service numbers, only 3 digits long
freephone = %w{ 300 700 800 }
ndcs_eight = [
  '3' # Selangor & Federal Territories of Kuala Lumpur & Putrajaya & also Genting Highlands, Pahang
]

Phony.define do
  country '60',
    trunk('0') |
    one_of(freephone) >> split(2,4) | # Freephone, Tollfree, Forwarding
    # one_of(service) >>  none  | # Service
    one_of(mobile)  >> split(3,4..5)   | # Mobile
    one_of(ndcs_two_digits)    >> split(6)     | # 2-digit NDCs
    one_of(ndcs)    >> split(7)     | # 1-digit NDCs
    one_of(ndcs_eight)    >> split(8)     | # 1-digit NDCs
    fixed(2)        >> split(8)       # 2-digit NDCs (Also, fallback)
end
