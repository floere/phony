# frozen_string_literal: true

# Uruguay (Eastern Republic of)
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=UY

ndcs_with_7_subscriber_numbers = %w(2 4)

ndcs_with_6_subscriber_numbers = %w(
21
22
23
24
25
26
27
29
42
)

ndcs_with_5_subscriber_numbers = %w(
433
434
436
437
438
443
444
445
447
452
453
455
462
463
464
472
473
)


Phony.define do
  country '598',
          one_of('800') >> split(3,2) | # freephone
          one_of('805') >> split(3,2) | # shared cost
          one_of(%w(900 901 902 903 904 905 906 907 908)) >> split(3,2) | # premium rate
          one_of('909') >> split(3,2) | # ISP
          one_of(ndcs_with_5_subscriber_numbers) >> split(3,2) |
          one_of(ndcs_with_6_subscriber_numbers) >> split(3,3) |
          one_of(%w(93 94 95 96 97 98 99)) >> split(3,3) | # mobile
          one_of(ndcs_with_7_subscriber_numbers) >> split(3,4) |
          fixed(2) >> split(3,3)
end
