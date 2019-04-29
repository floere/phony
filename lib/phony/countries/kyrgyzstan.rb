# frozen_string_literal: true

# Kyrgyz Republic
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=KG

ndcs_with_6_subscriber_digits = %w(312 315)

ndcs_with_5_subscriber_digits = %w(
3131
3132
3133
3134
3135
3137
3138
3147
3161
3162
3163
3164
3165
3166
3167
3168
3222
3230
3231
3232
3233
3234
3237
3239
3261
3262
3263
3264
3265
3266
3267
3422
3456
3457
3458
3459
3461
3462
3463
3464
3522
3534
3535
3536
3537
3559
3561
3562
3563
3564
3565
3622
3653
3655
3656
3657
3661
3662
3663
3722
3734
3736
3738
3741
3742
3743
3744
3745
3746
3747
3748
3759
3761
3762
3763
3764
3765
3766
3767
3768
3769
3775
3776
3777
3922
3941
3942
3943
3944
3945
3946
3947
3961
3962
3963
3964
3965
3966
3967
3968
)

Phony.define do
  country '996',
          one_of(ndcs_with_5_subscriber_digits) >> split(3,2) |
          one_of(ndcs_with_6_subscriber_digits) >> split(3,3) |
          one_of(%w(800)) >> split(3,3) | # freephone
          one_of(%w(50 51 54 55 56 57 58 60 61 62 70 77)) >> split(3,4) | # mobile
          one_of(%w(52)) >> split(3,4) | # satellite
          fixed(3) >> split(3,3)
end
