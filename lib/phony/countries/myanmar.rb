# Myanmar: http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000920003PDFE.pdf
# + formatting according to Google's libphonenumber library. (r680 7/30/2014)
#
# note that ANEE SAKHAN area, Yangon ZTE GSM, MEC Tel CDMA 800 Mhz is not
# correctly handled by the google library
Phony.define do
  country '95',
          none >> matched_split(
              /\A\d\d{5}\z/ => [1,2,3],
              /\A[4-8]\d\d{5}\z/ => [2,2,3],
              /\A[4-8]\d\d{6}\z/ => [2,2,3],
              /\A[4-8]\d\d{7}\z/ => [2,3,4],
              /\A\d\d{6}\z/ => [1,3,3],
              /\A9\d{7}\z/ => [1,3,4], # mobile operators
              /\A9\d{8}\z/ => [1,4,4], # mobile operators
              /\A9\d{9}\z/ => [1,3,3,3] # mobile operators
          )
end
