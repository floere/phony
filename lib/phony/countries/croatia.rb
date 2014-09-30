# Croatia
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Croatia
# http://dialcode.org/Europe/Croatia/
# http://www.howtocallabroad.com/croatia/
#
# Landline numbers are composed by a 2 digits area code + 6 fixed digits 
# Mobile numbers are composed by a 2 digits prefix + 7 fixed digits 
#

mobile = %w(
  91
  92
  95
  97
  977
  98
  99
)

Phony.define do
  country '385', trunk('0') |
                 one_of(mobile) >> split(3, 4) |
                 one_of('1')    >> split(4, 3) | # Zagreb
                 fixed(2)       >> split(3, 3)   # 2-digit NDCs
end