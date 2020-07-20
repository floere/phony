# frozen_string_literal: true

# Bangladesh (People's Republic of)
# https://www.numberingplans.com

ndcs_with_3_subscriber_numbers = %w(
3035 3036 3224 3424 3427 3529 3823 4027 4222 4225 4425 4525 4623 4653 4658
5222 5323 5327 5526 6257 7022 7622 8023 8032 8332 8424 8528 8626 9423 9424
)

ndcs_with_4_subscriber_numbers = %w(
3020 3022 3023 3024 3025 3026 3027 3028 3029 3032 3033 3034 3035 3036 3221 3222 3223 3225
3322 3323 3324 3325 3326 3422 3824 4020 4029 4222 4223 4224 4225 4226 4227 4228
4320 4322 4323 4324 4325 4326 4327 4328 4329 4523 4653 4654 4655 4657 4624 4626 4627
4953 6024 6622 6655 7323 7324 7325 7327 7328 7522 7523 7524 7525 7526 7527 7528 7529
8020 8022 8023 8024 8025 8026 8027 8028 8029 8032 8033 8424 8425 8426 8427 8522 8523 8524 8525 8526 8527
)

ndcs_with_5_subscriber_numbers = {
    2 => %w(51 71 81 91),
    3 => %w(321 331 341 351 361 371 381 441 448 421 451 461 471 481 491 468
488 498 521 531 541 551 561 571 581 591 628 601 631 641 651 661 668
691 731 741 751 761 771 781 791 831 841 851 861 871 921 931 941 951 981),
    4 => %w(3023 3024 3028 3223 3225 3324 3422 3425 3822
4033 4226 4227 4322 4323 4326 4327 4328 4422 4423 4424 4426 4455 4624 4625 4626 4655 4656 4657 4823 4854 4922 4924 4925 4953
5020 5023 5024 5028 5029 5224 5225 5227 5323 5325 5326 5329 5424 5426 5526 5653 5724 5826
6023 6024 6222 6224 6225 6253 6254 6255 6323 6324 6327 6328 6423 6424 6524 6527 6623 6624 6652 6653 6654 6655
6722 6723 6724 6725 6822 6823 6824 6825 6922 6923 6924 6925 6926
7225 7227 7228 7229 7324 7326 7327 7329 7425 7426 7522 7525 7526 7528 7529 7724 7823 7825 7923
8020 8022 8026 8029 8220 8222 8223 8224 8225 8226 8227 8229 8232 8325 8327 8328 8425 8426 8427 8522 8523 8524
8622 8623 8624 8625 8626 8723 8725 8727
9020 9022 9024 9025 9027 9028 9032 9033 9222 9223 9225 9226 9227 9228 9229 9232 9233 9424 9426 9428 9524 9525 9528 9529 9824 9827)
}

ndcs_with_6_subscriber_numbers = {2 => %w(31 41), 3 => %w(721 821)}

ndcs_with_7_subscriber_numbers = {1 => %w(2), 3 => %w(431)}

Phony.define do
  country '880',
          # some ndc have several subscriber number length.
          match(/\A(#{ndcs_with_3_subscriber_numbers.join('|')})\d{3}\z/) >> split(3) |
          match(/\A(#{ndcs_with_4_subscriber_numbers.join('|')})\d{4}\z/) >> split(4) |
          match(/\A(#{ndcs_with_5_subscriber_numbers[4].join('|')})\d{5}\z/) >> split(5) |
          #
          one_of(ndcs_with_3_subscriber_numbers) >> split(3) |
          one_of(ndcs_with_4_subscriber_numbers) >> split(4) |
          one_of(ndcs_with_5_subscriber_numbers[2]) >> split(5) |
          one_of(ndcs_with_5_subscriber_numbers[3]) >> split(5) |
          one_of(ndcs_with_5_subscriber_numbers[4]) >> split(5) |
          one_of(ndcs_with_6_subscriber_numbers[2]) >> split(6) |
          one_of(ndcs_with_6_subscriber_numbers[3]) >> split(6) |
          one_of(ndcs_with_7_subscriber_numbers[1]) >> split(7) |
          one_of(ndcs_with_7_subscriber_numbers[3]) >> split(7) |
          # match(/\A(1[15-9])\d{8}\z/) >> split(8) # mobile
          fixed(2) >> split(8) # mobile
end