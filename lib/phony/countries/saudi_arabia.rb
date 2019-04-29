# frozen_string_literal: true

# References:
# http://www.itu.int/oth/T02020000B7/en
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Saudi_Arabia

ndcs_with_7_subscriber_digits = [
  '11', # Riyadh & the greater central region
  '12', # Western region, includes Makkah, Jeddah, Taif, Rabigh
  '13', # The Eastern Province, which includes, Dammam, Khobar, Qatif, Jubail, Dhahran, Hafar Al-Batin & others
  '14', # Al-Madinah, Tabuk, Al-Jawf, Yanbu, Turaif, Skaka and Northern Borders Region
  '16', # Al-Qassim, Buraidah, Majma & Hail
  '17', # Southern regions like Asir, Al-Baha, Jizan, Najran & Khamis Mushait
  '50', # Mobile: STC
  '51', # Mobile: Trunking services
  '52', # Mobile: Reserved for future use
  '53', # Mobile: STC
  '54', # Mobile: Mobily
  '55', # Mobile: STC
  '56', # Mobile: Mobily
  '57', # Mobile
  '58', # Mobile: Zain
  '59', # Mobile: Zain
]

toll_free = [
  '800'
]

universal_access = [
  '9200'
]

Phony.define do
  country '966', trunk('0') |
                 one_of(ndcs_with_7_subscriber_digits)   >> split(3,4) |
                 one_of(toll_free)                       >> split(3,4) |
                 one_of(universal_access)                >> split(5)   |
                 fixed(3)                                >> split(3,4)
end
