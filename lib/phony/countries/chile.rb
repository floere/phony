# Chilean phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Chile
# http://www.wtng.info/wtng-56-cl.html
#
# Note: Totally unsure about this one, as I get contradicting infos (see links above).
#      As usual, best effort.
#
service = %w{130 131 132 133 134 135 136 137 139 147 149}

Phony::Countries::Chile = one_of(*service)                   >> format(3,3) or 
                          one_of('2', '9', :max_length => 2) >> format(8) # Santiago (2) and mobile.