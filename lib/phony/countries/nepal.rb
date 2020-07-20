# frozen_string_literal: true

# Nepal
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=NP

ndcs_with_7_subscriber_digits = %w(1)

ndcs_with_6_subscriber_digits = %w(
10
11
21
23
24
25
26
27
29
31
33
35
36
37
38
41
44
46
47
49
51
53
55
56
57
61
63
64
66
67
68
69
71
75
76
77
78
79
81
82
83
84
86
87
89
91
92
93
94
95
96
97
99
)

Phony.define do
  country '977',
          one_of(ndcs_with_6_subscriber_digits) >> split(3,3) |
          one_of(%w(98)) >> split(4,4) | # mobile
          one_of(ndcs_with_7_subscriber_digits) >> split(3,4) |
          fixed(2) >> split(3,3)
end


