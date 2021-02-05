# frozen_string_literal: true

# Georgia
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=GE

ndcs_with_7_subscriber_digits = %w(32)
ndcs_with_6_subscriber_digits = %w(
341
342
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
410
411
412
413
414
415
416
417
418
419
422
423
424
425
426
427
431
432
433
434
435
436
437
439
442
443
444
445
446
447
448
472
473
474
479
491
492
493
494
495
496
497
)

Phony.define do
  country '995',
          trunk('0') |
          one_of('220') >> split(3,2) |
          one_of(%w(514 550 551 555 557 558 568 571 574 577 578 579 591 592 593 595 596 597 598 599 770 790)) >> split(3,3) | # mobile
          one_of(ndcs_with_6_subscriber_digits) >> split(3,3) |
          one_of(ndcs_with_7_subscriber_digits) >> split(3,4) |
          fixed(3) >> split(3,3)
end