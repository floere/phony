# frozen_string_literal: true

# Myanmar: http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000920003PDFE.pdf
#
# formatting according to Google's libphonenumber library. (r680 7/30/2014)
# except for ANEE SAKHAN area, Yangon ZTE GSM, MEC Tel CDMA 800 Mhz which are
# not correctly handled by the google library

area_codes = [
    '1',
    '2',
    '42',
    '43',
    '44',
    '45',
    '46',
    '52',
    '53',
    '54',
    '57',
    '58',
    '59',
    '61',
    '62',
    '64',
    '65',
    '66',
    '67',
    '69',
    '70',
    '71',
    '72',
    '73',
    '75',
    '81',
    '82',
    '83',
    '84',
    '85',
    '86'
]

Phony.define do
  country '95',
          one_of(area_codes) >> matched_split(
              /\A\d{5}\z/ => [2,3],
              /\A\d{6}\z/ => [3,3],
              /\A\d{7}\z/ => [3,4]
          ) |
          one_of('9') >> matched_split(  # mobile operators
              /\A\d{7}\z/ => [3,4],
              /\A\d{8}\z/ => [4,4],
              /\A\d{9}\z/ => [3,3,3]
          )
end
