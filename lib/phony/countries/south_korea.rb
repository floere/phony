# frozen_string_literal: true

# South Korean (Republic of Korea) phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_South_Korea
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=KR
#

# TODO 4-digit services, like "unreasonable infringement of livelihood report" number :)
#

special = %w(100 101 105 106 107 108 109 111 112 113 114 115 116 117 118 119 120 121 122 123 125 127 128 129 131 132 134 141 182 188)
# NOTE was:
#   mobile  = ('10'..'19').to_a
# but this was not frozen so easily.
mobile = %w(10 11 12 13 14 15 16 17 18 19)

Phony.define do
  country '82',
    trunk('0') |
    match(/^(#{special.join("|")})$/) >> split(3,3) | # Special actually don't need to be split – but better err.
    one_of(*mobile) >> split(4,4) |
    one_of('2') >> matched_split(
      /\A\d{7}\z/ => [3,4],
      /\A\d{8}\z/ => [4,4]) | # Seoul, also includes "services".
    fixed(2) >> matched_split(
      /\A\d{7}\z/ => [3,4],
      /\A\d{8}\z/ => [4,4]) # Rest of cities
end
