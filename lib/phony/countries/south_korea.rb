# South Korean (Republic of Korea) phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_South_Korea
#

# TODO 4-digit services, like "unreasonable infringement of livelihood report" number :)
#

special = %w{ 100 101 105 106 107 108 109 111 112 113 114 115 116 117 118 119 120 121 122 123 125 127 128 129 131 132 134 141 182 188 }
# mobile  = ('10'..'19').to_a # Note: Mobile not used as it is (for now) handled by the fixed catchall.

Phony.define do
  country '82',
    trunk('0') |
    match(/^(#{special.join("|")})$/) >> split(3,3) | # Special actually don't need to be split – but better err.
    one_of('2')                       >> split(4,4) | # Seoul, also includes "services".
    fixed(2)                          >> split(4,4)   # Catchall.
    
    # See above.
    #
    # one_of(*mobile)                 >> split(4,4) |
end