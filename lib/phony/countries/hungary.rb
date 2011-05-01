# Hungarian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Hungary
#

Phony.define do
  country '36', one_of('104', '105', '107', '112') >> split(3,3) | # special
                # TODO mobile
                one_of('1', :max_length => 2)      >> split(3,4)
end