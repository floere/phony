# frozen_string_literal: true

# Namibia
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=NA

Phony.define do
  country '264',
          one_of(%w(632532)) >> split(4) |
              one_of(%w(6342)) >> matched_split(
                  /\A\d{3}\z/ => [3],
                  /\A\d+\z/ => [3,3]) |
              one_of(%w(6362 6638)) >> split(4) |
              one_of(%w(6642)) >> matched_split(
                  /\A\d{4}\z/ => [4],
                  /\A\d+\z/ => [3,3]) |
              one_of(%w(6751)) >> split(3,2) |
              one_of(%w(628)) >> split(4) |
              one_of(%w(658)) >> split(5) |
              one_of(%w(668)) >> matched_split(
                  /\A\d{4}\z/ => [4],
                  /\A\d{5}\z/ => [3,2],
                  /\A\d+\z/ => [3,3]) |
              one_of(%w(61 63 64 65 67)) >> matched_split(
                  /\A\d{6}\z/ => [3,3],
                  /\A\d+\z/ => [3,3,3]) |
              one_of(%w(66)) >> matched_split(
                  /\A\d{4}\z/ => [4],
                  /\A\d+\z/ => [3,3]) |
              one_of(%w(62)) >> split(3,3) |
              one_of(%w(67)) >> matched_split(
                  /\A\d{6}\z/ => [3,3],
                  /\A\d{7}\z/ => [4,3],
                  /\A\d+\z/ => [3,3,3]) |
              one_of(%w(60 81 82 83 85)) >> split(4,3) |
              fixed(2) >> split(3,3)
end