# frozen_string_literal: true

# Tajikistan (Republic of)

ndcs_with_6_subscriber_digits = %w(372)

ndcs_with_5_subscriber_digits = %w(
3130
3131
3132
3133
3134
3135
3136
3137
3138
3139
3141
3153
3154
3155
3156
3222
3240
3242
3243
3245
3246
3247
3248
3249
3250
3251
3252
3311
3312
3314
3315
3316
3318
3322
3422
3441
3442
3443
3445
3451
3452
3453
3454
3455
3456
3462
3464
3465
3467
3475
3479
3522
3551
3552
3553
3554
3555
3556
)

ndcs_with_3_subscriber_digits = %w(331700)

Phony.define do
  country '992',
    trunk('8') |
    one_of(ndcs_with_3_subscriber_digits) >> split(3)   |
    one_of(ndcs_with_5_subscriber_digits) >> split(3,2) |
    one_of(ndcs_with_6_subscriber_digits) >> split(3,3) |
    match(/\A(505|9\d\d)\d+\z/)           >> split(3,3) | # mobile
    one_of(%w(446 474 487))               >> split(3,3) | # wireless geographic
    fixed(3)                              >> split(3,3)
end