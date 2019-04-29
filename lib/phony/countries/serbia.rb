# frozen_string_literal: true

# Serbia
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=RS

Phony.define do
  country '381',
    trunk('0') |
    one_of(%w(800)) >> split(3,2) | # freephone
    one_of(%w(808)) >> split(3,2) | # payphone
    one_of(%w(230)) >> matched_split(
        /\A\d{4}\z/ => [4],
        /\A\d+\z/ => [3,2]) |
    one_of(%w(11 21)) >> matched_split(
        /\A\d{6}\z/ => [3,3],
        /\A\d+\z/ => [3,4]) |
    one_of(%w(26 31 35)) >> split(3,3) |
    one_of(%w(10 12 13 14 15 16 17 18 19 20 22 23 24 25 27 30 32 33 34 36 37)) >> matched_split(
        /\A\d{5}\z/ => [3,2],
        /\A\d+\z/ => [3,3]) |
    one_of(%w(72)) >> split(3,3) | # ISP
    one_of(%w(60 61 68 69)) >> matched_split(
        /\A\d{3}\z/ => [3],
        /\A\d{7}\z/ => [3,4],
        /\A\d+\z/ => [3,3,4]) | # mobile, voicemail (mobile)
    one_of(%w(66 63)) >> matched_split(
        /\A\d{3}\z/ => [3],
        /\A\d{6}\z/ => [3,3],
        /\A\d{7}\z/ => [3,4],
        /\A\d+\z/ => [3,3,4]) | # mobile, voicemail (mobile)
    one_of(%w(62 64 65)) >> matched_split(
        /\A\d{2}\z/ => [2],
        /\A\d{3}\z/ => [3],
        /\A\d{6}\z/ => [3,3],
        /\A\d{7}\z/ => [3,4],
        /\A\d+\z/ => [3,3,4]) | # mobile, voicemail (mobile)
    one_of(%w(70)) >> split(3,3) | # universal access
    one_of(%w(42 78)) >> split(3,3) | # premium rate
    one_of(%w(9)) >> split(3,4) | # premium rate
    fixed(2) >> matched_split(
        /\A\d{5}\z/ => [3,2],
        /\A\d+\z/ => [3,3])
end