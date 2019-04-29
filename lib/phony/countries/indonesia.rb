# frozen_string_literal: true

# Indonesia (Republic of)
# http://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=ID

Phony.define do
  country '62',
    trunk('0') |
    one_of('21') >> matched_split(
        /\A\d{5}\z/ => [3,2],
        /\A\d{7}\z/ => [3,4],
        /\A\d+\z/ => [4,4]) |
    one_of(%w(22 23 24 25 26 27 28 29 31 32 33 34 35 36 37 38 39 72)) >> matched_split(
        /\A\d{5}\z/ => [3,2],
        /\A\d{7}\z/ => [3,4],
        /\A\d{8}\z/ => [4,4],
        /\A\d{9}\z/ => [3,3,3]) |
    one_of('70') >> split(3,3) |
    one_of(%w(71 73 74 75 76 77)) >> matched_split(
        /\A\d{6}\z/ => [3,3],
        /\A\d+\z/ => [3,4]) |
    one_of('13') >> matched_split(  # pager
        /\A\d{3}\z/ => [3],
        /\A\d+\z/ => [3,3]) |
    one_of(%w(174 175)) >> matched_split(  # satellite
        /\A\d{2}\z/ => [2],
        /\A\d+\z/ => [2,3]) |
    one_of('177') >> matched_split(  # satellite
        /\A\d{2}\z/ => [2],
        /\A\d+\z/ => [4,4]) |
    one_of('178') >> matched_split(  # satellite
        /\A\d{3}\z/ => [3],
        /\A\d+\z/ => [3,2]) |
    one_of(%w(870)) >> split(3,2) | # satellite
    match(/\A(81\d|82\d|83\d|84\d|85\d|86\d|87\d|88\d|89\d)\d+\z/) >> matched_split(  # mobile
        /\A\d{6}\z/ => [3,3],
        /\A\d{7}\z/ => [3,4],
        /\A\d{8}\z/ => [4,4],
        /\A\d+\z/ => [4,5]) |
    one_of(%w(9)) >> matched_split( # geographic
        /\A\d{7}\z/ => [4,3],
        /\A\d+\z/ => [3,3,3]) |
    one_of(%w(4 5)) >> matched_split(
        /\A\d{6}\z/ => [3,3],
        /\A\d+\z/ => [4,4]) |
    one_of('6') >> matched_split(
        /\A\d{7}\z/ => [3,4],
        /\A\d+\z/ => [4,4]) |
    one_of('9') >> matched_split(
        /\A\d{7}\z/ => [3,4],
        /\A\d+\z/ => [4,5]) |
    fixed(2) >> split(4,4)
end

