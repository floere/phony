# frozen_string_literal: true

# Latvia
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=LV
# https://www.numberingplans.com/?page=dialling&sub=areacodes

ndcs_with_5_subscriber_numbers = %w(
630
631
632
633
634
636
637
638
639
640
641
642
643
644
645
646
647
648
650
651
652
653
654
656
657
)

ndcs_with_6_subscriber_numbers = %w(67)

Phony.define do
  country '371', 
    trunk('8', :normalize => false) |
    one_of(ndcs_with_5_subscriber_numbers) >> split(3,2) |
    one_of(ndcs_with_6_subscriber_numbers) >> split(3,3) |
    fixed(3)                               >> split(3,2)
end