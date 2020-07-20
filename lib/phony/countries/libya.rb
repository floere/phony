# frozen_string_literal: true

# Lybia, https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=LY

ndcs_with_7_subscriber_numbers = %w(21)

ndcs_with_6_subscriber_numbers = %w(
22
23
24
25
26
31
41
47
51
54
57
61
63
67
71
73
81
82
84
87
)

ndcs_with_5_subscriber_numbers = %w(
205
206
224
252
271
272
274
275
277
279
281
282
284
322
323
325
326
421
422
423
425
427
452
453
454
481
482
484
521
522
523
524
526
529
551
553
554
555
581
582
583
584
623
624
625
626
627
628
629
652
653
654
655
657
681
682
683
684
685
721
723
724
725
726
727
729
731
732
733
734
821
851
852
854
884
)

Phony.define do
  country '218',
          one_of(ndcs_with_5_subscriber_numbers) >> split(3,2) |
          one_of(ndcs_with_6_subscriber_numbers) >> split(3,3) |
          one_of(ndcs_with_7_subscriber_numbers) >> split(4,3) |
          one_of(%w(91 92)) >> split(4,3) | # mobile
          fixed(2) >> split(3,3)
end