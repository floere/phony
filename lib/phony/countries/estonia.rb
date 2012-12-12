# Estonia uses a variable-length number portability database when handle calls.
#
#
# Taken from: https://www.riigiteataja.ee/
#

fixed = [
 '1',
 '2',
 '3',
 '4',
 '6',
 '7'
]
mobile = [
 '5',  # Mobile
 '81', # Telematics
 '82'  # Mobile
]
service = [
   '900', # Premium Rate
   '112', # Emergency Service
   '110', # Police
]

Phony.define do
  country '372', one_of(service) >> split(3,3) |
                one_of(mobile) >> split(8) |
                one_of(fixed) >> split(8) # catchall
end
