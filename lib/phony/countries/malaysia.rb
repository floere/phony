include Phony::DSL

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
service = %w{ 100 101 102 103 104 108 112 991 994 995 999 }

Phony::Countries::Malaysia = one_of(*service)                >> format(3,3) |
                             one_of(*mobile)                 >> format(8)   |
                             one_of(*ndcs, :max_length => 2) >> format(8)
  
  # :mobile   => %w{ 10 11 12 13 14 153 154 156 158 16 17 18 19 },
  # # TODO 4+ digits service numbers
  # #
  # :service  => %w{ 100 101 102 103 104 108 112 991 994 995 999 }