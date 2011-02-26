include Phony::DSL

# South Korean (Republic of Korea) phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_South_Korea
#

# TODO 4-digit services, like "unreasonable infringement of livelihood report" number :)
#
service = %w{ 30 50 60 70 80 100 101 105 106 107 108 109 111 112 113 114 115 116 117 118 119 120 121 122 123 125 127 128 129 131 132 134 141 182 188 }
mobile  = ('10'..'19').to_a

Phony::Countries::SouthKorea = one_of(*service) >> format(3,3) or 
                              one_of(*mobile)  >> format(4,4) or 
                              one_of('2')      >> format(4,4) # Seoul