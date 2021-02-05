# frozen_string_literal: true

# Croatia
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Croatia
# http://dialcode.org/Europe/Croatia/
# http://www.howtocallabroad.com/croatia/
# https://github.com/googlei18n/libphonenumber/
#

landline = /^(2[0-3]|3[1-5]|4[02-47-9]|5[1-3])/

Phony.define do
  country '385', trunk('0') |
                 one_of('1')         >> split(4, 3)       | # Zagreb
                 match(/^(80[01])/)  >> matched_split(
                                    /\A\d{4}\z/ => [4],
                                    /\A\d{6}\z/ => [3,3]) | # Toll free
                 match(/^(9\d)/)     >> split(3, 3..4)    | # Mobile
                 match(landline)     >> split(3, 3..4)    | # Landline
                 match(/^(6[01])/)   >> split(2,2..3)     | # Premium rate
                 match(/^([67]\d)/)  >> split(3,3..4)       # Premium, personal and UAN
end
