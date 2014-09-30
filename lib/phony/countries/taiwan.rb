# Taiwan
# https://www.numberingplans.com/?page=dialling&sub=areacodes
#

ndcs_with_8_subscriber_numbers = %w(1 2)

ndcs_with_7_subscriber_numbers = %w(3 4 5 6 7 8)

ndcs_with_6_subscriber_numbers = %w(
33
34
35
36
37
38
39
42
43
44
45
46
47
48
49
55
56
62
66
67
69
88
89
)

ndcs_with_5_subscriber_numbers = %w(823 826 827)

Phony.define do
  country '886',
    trunk('0') |
    one_of(ndcs_with_5_subscriber_numbers) >> split(3,2) |
    match(/\A(6\d\d)\d{7}\z/) >> split(3,4) | # geographic ; Taipei
    one_of(%w(412)) >> split(4) | # VoIP telephony ; Taichung
    one_of(ndcs_with_6_subscriber_numbers) >> split(3,3) |
    one_of(%w(18)) >> split(3,3) | # freephone
    one_of(%w(90 91 92 93 95 96 97 98)) >> matched_split(
       /\A\d{6}\z/ => [3,3],
       /\A\d+\z/ => [3,4]) | # mobile
    one_of(%w(60 70 94 95 99)) >> split(3,3) | # pager
    one_of(ndcs_with_7_subscriber_numbers) >> split(3,4) |
    one_of(ndcs_with_8_subscriber_numbers) >> split(4,4) |
    fixed(2) >> split(3,3)
end
