include Phony::DSL

# Hungarian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Hungary
#
Phony::Countries::Hungary = one_of('104', '105', '107', '112') >> format(3,3) | 
# special
                            # TODO mobile
                            one_of('1', :max_length => 2)      >> format(3,4)