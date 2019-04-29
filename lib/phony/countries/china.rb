# frozen_string_literal: true

# Chinese phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_China
#
# Note: Tibet partially uses 4-digit NDC codes. This is NOT YET reflected here.
#
ndcs = [
 '10', # Beijing, TODO Confirm – is it 10 or 1?
 '20', # Guangzhou
 '21', # Shanghai
 '22', # Tianjin
 '23', # Chongquin
 '24', # Shenyang
 '25', # Nanjing
 '26', # Taipei, Taiwan - gotta be kidding, right?!
 '27', # Wuhan
 '28', # Chengdu
 '29', # Xi'an
]
mobile = %w{ 130 131 132 133 134 135 136 137 138 139 145 150 151 152 153 155 156 157 158 159 185 186 187 188 189 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349 }
service = %w{ 110 114 119 120 122 999 } # Probably not exhaustive. TODO Look at http://www.eoc.com.cn/?action-viewnews-itemid-11493.

Phony.define do
  country '86',
    trunk('0') |
    one_of(service) >> split(8)   |
    one_of(mobile)  >> split(4,4) |
    one_of(ndcs)    >> split(4,4) |
    fixed(3)        >> split(4,4)
end
