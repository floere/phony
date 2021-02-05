# frozen_string_literal: true

# Paraguay (Republic of)
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=PY

ndcs_with_6_7_subscriber_numbers = %w(
21
24
25
26
28
31
32
33
36
37
38
39
41
42
43
44
46
47
48
61
71
72
73
75
81
82
83
86
91
92
93
94
)

ndcs_with_6_subscriber_numbers = %w(
271
275
291
292
293
294
295
345
351
418
451
453
464
511
512
513
514
515
516
517
518
519
520
521
522
523
524
527
528
529
531
532
533
534
535
536
537
538
539
541
542
544
545
546
547
548
549
550
552
553
554
631
632
633
644
671
672
673
674
675
676
677
678
717
718
740
741
742
743
761
762
763
764
767
768
780
781
782
783
784
785
787
858
871
873
918
951
952
)

Phony.define do

  country '595',
          one_of(ndcs_with_6_subscriber_numbers) >> split(3,3) | # geographic
          one_of(ndcs_with_6_7_subscriber_numbers) >>
              matched_split(
                  /\A\d{6}\z/ => [3,3],
                  /\A\d+\z/ => [3,4]) | # geographic
          one_of(%w(96 97 98 99)) >> split(3,4) | # mobile
          fixed(2) >>
              matched_split(
                  /\A\d{6}\z/ => [3,3],
                  /\A\d+\z/ => [3,4])

end