# frozen_string_literal: true

# Montenegro
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=ME

Phony.define do
  country '382',
          trunk('0') |
          one_of(%w(80)) >> split(3,3) | # freephone
              one_of(%w(20 30 31 40 52)) >> matched_split(
                  /\A\d{5}\z/ => [3,2],
                  /\A\d+\z/ => [3,3]) |
              one_of(%w(32 33 50 51)) >> split(3,3) |
              one_of(%w(77)) >> split(3,3) | # national geographic
              one_of(%w(78)) >> split(3,3) | # VoIP telephony
              one_of(%w(88)) >> split(3,3) | # shared cost
              one_of(%w(94 95)) >> split(3,3) | # premium rate
              one_of(%w(63 67 69 70)) >> matched_split(
                  /\A\d{3}\z/ => [3],
                  /\A\d{6}\z/ => [3,3],
                  /\A\d+\z/ => [3,3,4]) | # mobile, voicemail (mobile
              one_of(%w(68)) >> matched_split(
                  /\A\d{2}\z/ => [2],
                  /\A\d{6}\z/ => [3,3],
                  /\A\d+\z/ => [2,4,4]) | # voicemail (mobile)
              fixed(2) >> matched_split(
                  /\A\d{5}\z/ => [3,2],
                  /\A\d+\z/ => [3,3])
end
