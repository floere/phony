# frozen_string_literal: true

# Pakistan (Islamic Republic of)
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=PK

ndcs_mobile_plan = %w[30 31 32 33 34 35 36]

ndcs_with_8_subscriber_numbers = %w[21 42]

ndcs_with_7_subscriber_numbers = %w[
  22
  25
  40
  41
  44
  46
  47
  48
  49
  51
  52
  53
  55
  56
  57
  61
  62
  63
  64
  65
  66
  67
  68
  71
  74
  81
  86
  91
]

ndcs_with_6_subscriber_numbers = %w[
  232
  233
  235
  238
  242
  243
  244
  297
  298
  453
  454
  457
  459
  542
  543
  544
  546
  547
  604
  606
  608
  722
  723
  726
  822
  823
  824
  825
  826
  828
  829
  832
  833
  835
  837
  838
  843
  844
  847
  848
  852
  853
  855
  856
  922
  923
  924
  925
  926
  927
  928
  932
  937
  938
  939
  942
  943
  944
  945
  946
  963
  965
  966
  969
  992
  995
  996
  997
  998
  5811
  5812
  5813
  5814
  5815
  5816
  5817
  5821
  5822
  5823
  5824
  5825
  5826
  2827
  5828
]

Phony.define do
  country '92',
          one_of('111') >> split(3, 3) | # UAN without NDC |
          one_of(ndcs_with_6_subscriber_numbers) >> matched_split(
            /^(111)\d{6}$/ => [3, 3, 3], # UAN - always 6 digits
            /^\d{6}$/ => [3, 3]
          ) |
          one_of(ndcs_with_7_subscriber_numbers) >> matched_split(
            /^(111)\d{6}$/ => [3, 3, 3], # UAN - always 6 digits
            /^\d{7}$/ => [4, 3]
          ) |
          one_of(ndcs_with_8_subscriber_numbers) >> matched_split(
            /^(111)\d{6}$/ => [3, 3, 3], # UAN - always 6 digits
            /^\d{8}$/ => [4, 4]
          ) |
          one_of(ndcs_mobile_plan) >> split(4, 4) | # mobile
          fixed(2) >> split(4, 4)
end
