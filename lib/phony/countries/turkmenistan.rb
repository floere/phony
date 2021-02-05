# frozen_string_literal: true

# Turkmenistan
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=TM

ndcs_with_6_subscriber_digits = %w(12)

ndcs_with_5_subscriber_digits = %w(
131
132
133
134
135
136
137
138
222
240
241
242
243
245
246
247
248
322
340
343
344
345
346
347
348
349
360
422
431
432
438
440
441
442
443
444
445
446
447
448
449
461
465
522
557
558
559
560
561
564
565
566
568
569
)

ndcs_with_4_subscriber_digits = %w(1392)

Phony.define do
  country '993',
    trunk('8') |
    one_of(ndcs_with_4_subscriber_digits) >> split(4) |
    one_of(ndcs_with_5_subscriber_digits) >> split(3,2) |
    one_of(ndcs_with_6_subscriber_digits) >> split(3,3) |
    one_of('6')                           >> split(3,4) | # mobile
    fixed(3)                              >> split(3,2)
end