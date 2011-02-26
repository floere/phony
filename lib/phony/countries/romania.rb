include Phony::DSL

# Romanian phone numbers.
#
# http://en.wikipedia.org/wiki/Romania_telephone_area_codes
#

ndcs = [
 '21', # Bucureşti
 '31', # Bucureşti
]
mobile = [
 '71',
 '72',
 '73',
 '74',
 '75',
 '76',
 '77',
 '78',
]
service = [
 '112',
 '800',
 '900',
 '903',
 '906',
]

Phony::Countries::Romania = one_of(*service)                     >> format(3,3) | 
                            match(/^7[1-8].*$/, 2)               >> format(3,4) | 
                            one_of('21', '31', :max_length => 3) >> format(3,4) # Bucureşti