# interactive order distribution plot is as expected

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Orders: 1 
      Customers: 42 Orders: 2 
      Customers: 83 Orders: 3 
      Customers: 143 Orders: 4 
      Customers: 187 Orders: 5 
      Customers: 176 Orders: 6 
      Customers: 150 Orders: 7 
      Customers: 94 Orders: 8 
      Customers: 51 Orders: 9 
      Customers: 38 Orders: 10 
      Customers: 20 Orders: 11 
      Customers: 3 Orders: 12 
      Customers: 5 Orders: 13 
      Customers: 2 Orders: 14 
      Customers: 1

# interactive heatmap is as expected

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Frequency Score: 1
      Recency Score: 1
      Mean Monetary Value: 208.4 Frequency Score: 1
      Recency Score: 2
      Mean Monetary Value: 246.98 Frequency Score: 1
      Recency Score: 3
      Mean Monetary Value: 246.3 Frequency Score: 1
      Recency Score: 4
      Mean Monetary Value: 213.42 Frequency Score: 1
      Recency Score: 5
      Mean Monetary Value: 262.17 Frequency Score: 2
      Recency Score: 1
      Mean Monetary Value: 380.5 Frequency Score: 2
      Recency Score: 2
      Mean Monetary Value: 407.54 Frequency Score: 2
      Recency Score: 3
      Mean Monetary Value: 355.08 Frequency Score: 2
      Recency Score: 4
      Mean Monetary Value: 375.17 Frequency Score: 2
      Recency Score: 5
      Mean Monetary Value: 370.03 Frequency Score: 3
      Recency Score: 1
      Mean Monetary Value: 530.24 Frequency Score: 3
      Recency Score: 2
      Mean Monetary Value: 516.65 Frequency Score: 3
      Recency Score: 3
      Mean Monetary Value: 446.61 Frequency Score: 3
      Recency Score: 4
      Mean Monetary Value: 451.88 Frequency Score: 3
      Recency Score: 5
      Mean Monetary Value: 467 Frequency Score: 4
      Recency Score: 1
      Mean Monetary Value: 575.41 Frequency Score: 4
      Recency Score: 2
      Mean Monetary Value: 599.47 Frequency Score: 4
      Recency Score: 3
      Mean Monetary Value: 603.79 Frequency Score: 4
      Recency Score: 4
      Mean Monetary Value: 617.07 Frequency Score: 4
      Recency Score: 5
      Mean Monetary Value: 564.51 Frequency Score: 5
      Recency Score: 1
      Mean Monetary Value: 746.67 Frequency Score: 5
      Recency Score: 2
      Mean Monetary Value: 873.11 Frequency Score: 5
      Recency Score: 3
      Mean Monetary Value: 846.9 Frequency Score: 5
      Recency Score: 4
      Mean Monetary Value: 866.43 Frequency Score: 5
      Recency Score: 5
      Mean Monetary Value: 862.4

# interactive histogram is as expected

    Code
      cat(p$x$attrs[[1]]$hovertext)

# interactive segment summary plot is as expected

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Customers: 50 Segment: At Risk
      Customers: 86 Segment: Champions
      Customers: 158 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 278 Segment: Need Attention
      Customers: 35 Segment: Others
      Customers: 48 Segment: Potential Loyalist
      Customers: 229

# interactive segment summary plot is as expected when sorted

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Customers: 50 Segment: At Risk
      Customers: 86 Segment: Champions
      Customers: 158 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 278 Segment: Need Attention
      Customers: 35 Segment: Others
      Customers: 48 Segment: Potential Loyalist
      Customers: 229

# interactive segment summary plot sorted in descending order

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Customers: 50 Segment: At Risk
      Customers: 86 Segment: Champions
      Customers: 158 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 278 Segment: Need Attention
      Customers: 35 Segment: Others
      Customers: 48 Segment: Potential Loyalist
      Customers: 229

# interactive segment summary plot flipped

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Customers: 50 Segment: At Risk
      Customers: 86 Segment: Champions
      Customers: 158 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 278 Segment: Need Attention
      Customers: 35 Segment: Others
      Customers: 48 Segment: Potential Loyalist
      Customers: 229

# interactive segment summary plot flipped sorted

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Customers: 50 Segment: At Risk
      Customers: 86 Segment: Champions
      Customers: 158 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 278 Segment: Need Attention
      Customers: 35 Segment: Others
      Customers: 48 Segment: Potential Loyalist
      Customers: 229

# interactive segment summary plot flipped sorted ascending

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Customers: 50 Segment: At Risk
      Customers: 86 Segment: Champions
      Customers: 158 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 278 Segment: Need Attention
      Customers: 35 Segment: Others
      Customers: 48 Segment: Potential Loyalist
      Customers: 229

# interactive revenue distribution plot

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Revenue Share: 2.35% Segment: At Risk
      Revenue Share: 9.52% Segment: Champions
      Revenue Share: 25.89% Segment: Lost
      Revenue Share: 4.51% Segment: Loyal Customers
      Revenue Share: 35.92% Segment: Need Attention
      Revenue Share: 2.86% Segment: Others
      Revenue Share: 4.75% Segment: Potential Loyalist
      Revenue Share: 14.19%

---

    Code
      cat(p$x$attrs[[2]]$hovertext)
    Output
      Segment: About To Sleep
      Customer Share: 5.03% Segment: At Risk
      Customer Share: 8.64% Segment: Champions
      Customer Share: 15.88% Segment: Lost
      Customer Share: 11.16% Segment: Loyal Customers
      Customer Share: 27.94% Segment: Need Attention
      Customer Share: 3.52% Segment: Others
      Customer Share: 4.82% Segment: Potential Loyalist
      Customer Share: 23.02%

# interactive revenue distribution plot flipped

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: About To Sleep
      Revenue Share: 2.35% Segment: At Risk
      Revenue Share: 9.52% Segment: Champions
      Revenue Share: 25.89% Segment: Lost
      Revenue Share: 4.51% Segment: Loyal Customers
      Revenue Share: 35.92% Segment: Need Attention
      Revenue Share: 2.86% Segment: Others
      Revenue Share: 4.75% Segment: Potential Loyalist
      Revenue Share: 14.19%

---

    Code
      cat(p$x$attrs[[2]]$hovertext)
    Output
      Segment: About To Sleep
      Customer Share: 5.03% Segment: At Risk
      Customer Share: 8.64% Segment: Champions
      Customer Share: 15.88% Segment: Lost
      Customer Share: 11.16% Segment: Loyal Customers
      Customer Share: 27.94% Segment: Need Attention
      Customer Share: 3.52% Segment: Others
      Customer Share: 4.82% Segment: Potential Loyalist
      Customer Share: 23.02%

# interactive segment plot

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment:ABOUT TO SLEEP
      Customers: 50 (5.03%) Segment:AT RISK
      Customers: 86 (8.64%) Segment:CHAMPIONS
      Customers: 158 (15.88%) Segment:LOST
      Customers: 111 (11.16%) Segment:LOYAL CUSTOMERS
      Customers: 278 (27.94%) Segment:NEED ATTENTION
      Customers: 35 (3.52%) Segment:OTHERS
      Customers: 48 (4.82%) Segment:POTENTIAL LOYALIST
      Customers: 229 (23.02%)

# interactive segment scatter plot

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Amount: 472
      Recency: 205
      Segment: Loyal Customers Amount: 340
      Recency: 140
      Segment: Potential Loyalist Amount: 405
      Recency: 194
      Segment: Potential Loyalist Amount: 596
      Recency: 98
      Segment: Champions Amount: 448
      Recency: 132
      Segment: Loyal Customers Amount: 843
      Recency: 90
      Segment: Champions Amount: 763
      Recency: 84
      Segment: Champions Amount: 699
      Recency: 281
      Segment: Loyal Customers Amount: 157
      Recency: 246
      Segment: Potential Loyalist Amount: 779
      Recency: 160
      Segment: Champions Amount: 363
      Recency: 349
      Segment: About To Sleep Amount: 196
      Recency: 619
      Segment: Lost Amount: 669
      Recency: 210
      Segment: Loyal Customers Amount: 500
      Recency: 138
      Segment: Loyal Customers Amount: 320
      Recency: 396
      Segment: About To Sleep Amount: 393
      Recency: 102
      Segment: Potential Loyalist Amount: 28
      Recency: 168
      Segment: Potential Loyalist Amount: 591
      Recency: 174
      Segment: Champions Amount: 245
      Recency: 157
      Segment: Potential Loyalist Amount: 634
      Recency: 482
      Segment: At Risk Amount: 175
      Recency: 239
      Segment: Potential Loyalist Amount: 786
      Recency: 150
      Segment: Champions Amount: 596
      Recency: 202
      Segment: Loyal Customers Amount: 697
      Recency: 245
      Segment: Loyal Customers Amount: 703
      Recency: 245
      Segment: Loyal Customers Amount: 436
      Recency: 146
      Segment: Potential Loyalist Amount: 862
      Recency: 123
      Segment: Champions Amount: 597
      Recency: 405
      Segment: Loyal Customers Amount: 367
      Recency: 214
      Segment: Others Amount: 392
      Recency: 475
      Segment: Loyal Customers Amount: 548
      Recency: 267
      Segment: Loyal Customers Amount: 598
      Recency: 191
      Segment: Loyal Customers Amount: 539
      Recency: 127
      Segment: Loyal Customers Amount: 712
      Recency: 227
      Segment: Loyal Customers Amount: 876
      Recency: 1
      Segment: Champions Amount: 387
      Recency: 209
      Segment: Loyal Customers Amount: 289
      Recency: 241
      Segment: Potential Loyalist Amount: 663
      Recency: 215
      Segment: Loyal Customers Amount: 191
      Recency: 576
      Segment: Lost Amount: 253
      Recency: 414
      Segment: About To Sleep Amount: 443
      Recency: 164
      Segment: Loyal Customers Amount: 425
      Recency: 339
      Segment: Need Attention Amount: 104
      Recency: 687
      Segment: Lost Amount: 287
      Recency: 676
      Segment: Lost Amount: 225
      Recency: 156
      Segment: Potential Loyalist Amount: 202
      Recency: 12
      Segment: Potential Loyalist Amount: 316
      Recency: 937
      Segment: Lost Amount: 469
      Recency: 360
      Segment: Loyal Customers Amount: 325
      Recency: 444
      Segment: About To Sleep Amount: 589
      Recency: 458
      Segment: At Risk Amount: 336
      Recency: 666
      Segment: Lost Amount: 507
      Recency: 455
      Segment: Loyal Customers Amount: 1069
      Recency: 126
      Segment: Champions Amount: 720
      Recency: 130
      Segment: Champions Amount: 434
      Recency: 327
      Segment: Loyal Customers Amount: 600
      Recency: 39
      Segment: Champions Amount: 492
      Recency: 482
      Segment: At Risk Amount: 341
      Recency: 210
      Segment: Potential Loyalist Amount: 388
      Recency: 46
      Segment: Potential Loyalist Amount: 398
      Recency: 282
      Segment: Potential Loyalist Amount: 567
      Recency: 129
      Segment: Champions Amount: 803
      Recency: 274
      Segment: Loyal Customers Amount: 527
      Recency: 286
      Segment: Others Amount: 81
      Recency: 399
      Segment: About To Sleep Amount: 681
      Recency: 162
      Segment: Others Amount: 687
      Recency: 141
      Segment: Champions Amount: 229
      Recency: 53
      Segment: Potential Loyalist Amount: 856
      Recency: 116
      Segment: Champions Amount: 878
      Recency: 57
      Segment: Champions Amount: 777
      Recency: 122
      Segment: Champions Amount: 370
      Recency: 183
      Segment: Potential Loyalist Amount: 390
      Recency: 35
      Segment: Loyal Customers Amount: 425
      Recency: 179
      Segment: Loyal Customers Amount: 190
      Recency: 932
      Segment: Lost Amount: 319
      Recency: 186
      Segment: Potential Loyalist Amount: 446
      Recency: 4
      Segment: Potential Loyalist Amount: 141
      Recency: 872
      Segment: Lost Amount: 211
      Recency: 253
      Segment: Potential Loyalist Amount: 527
      Recency: 312
      Segment: Loyal Customers Amount: 198
      Recency: 488
      Segment: Lost Amount: 552
      Recency: 181
      Segment: Loyal Customers Amount: 94
      Recency: 632
      Segment: Lost Amount: 37
      Recency: 202
      Segment: Potential Loyalist Amount: 764
      Recency: 217
      Segment: Loyal Customers Amount: 696
      Recency: 269
      Segment: Loyal Customers Amount: 875
      Recency: 72
      Segment: Champions Amount: 276
      Recency: 114
      Segment: Potential Loyalist Amount: 375
      Recency: 152
      Segment: Potential Loyalist Amount: 528
      Recency: 5
      Segment: Champions Amount: 120
      Recency: 870
      Segment: Lost Amount: 977
      Recency: 457
      Segment: Loyal Customers Amount: 190
      Recency: 331
      Segment: About To Sleep Amount: 241
      Recency: 588
      Segment: Lost Amount: 733
      Recency: 250
      Segment: Loyal Customers Amount: 845
      Recency: 181
      Segment: Loyal Customers Amount: 246
      Recency: 365
      Segment: About To Sleep Amount: 531
      Recency: 573
      Segment: At Risk Amount: 318
      Recency: 298
      Segment: About To Sleep Amount: 330
      Recency: 13
      Segment: Potential Loyalist Amount: 435
      Recency: 170
      Segment: Loyal Customers Amount: 470
      Recency: 479
      Segment: Loyal Customers Amount: 381
      Recency: 186
      Segment: Potential Loyalist Amount: 338
      Recency: 601
      Segment: At Risk Amount: 188
      Recency: 176
      Segment: Potential Loyalist Amount: 580
      Recency: 90
      Segment: Champions Amount: 599
      Recency: 310
      Segment: Loyal Customers Amount: 607
      Recency: 376
      Segment: Loyal Customers Amount: 852
      Recency: 229
      Segment: Loyal Customers Amount: 374
      Recency: 174
      Segment: Potential Loyalist Amount: 330
      Recency: 18
      Segment: Others Amount: 226
      Recency: 62
      Segment: Potential Loyalist Amount: 336
      Recency: 363
      Segment: About To Sleep Amount: 161
      Recency: 89
      Segment: Potential Loyalist Amount: 96
      Recency: 497
      Segment: Lost Amount: 580
      Recency: 175
      Segment: Champions Amount: 323
      Recency: 521
      Segment: At Risk Amount: 635
      Recency: 294
      Segment: Loyal Customers Amount: 353
      Recency: 298
      Segment: About To Sleep Amount: 492
      Recency: 101
      Segment: Potential Loyalist Amount: 316
      Recency: 578
      Segment: Lost Amount: 465
      Recency: 41
      Segment: Loyal Customers Amount: 419
      Recency: 266
      Segment: Loyal Customers Amount: 381
      Recency: 172
      Segment: Potential Loyalist Amount: 393
      Recency: 259
      Segment: Potential Loyalist Amount: 442
      Recency: 203
      Segment: Potential Loyalist Amount: 639
      Recency: 236
      Segment: Loyal Customers Amount: 689
      Recency: 122
      Segment: Champions Amount: 456
      Recency: 59
      Segment: Potential Loyalist Amount: 532
      Recency: 225
      Segment: Loyal Customers Amount: 416
      Recency: 349
      Segment: Loyal Customers Amount: 533
      Recency: 473
      Segment: Loyal Customers Amount: 723
      Recency: 108
      Segment: Champions Amount: 281
      Recency: 445
      Segment: Need Attention Amount: 613
      Recency: 71
      Segment: Champions Amount: 787
      Recency: 180
      Segment: Champions Amount: 522
      Recency: 164
      Segment: Loyal Customers Amount: 171
      Recency: 172
      Segment: Potential Loyalist Amount: 620
      Recency: 44
      Segment: Champions Amount: 143
      Recency: 182
      Segment: Potential Loyalist Amount: 721
      Recency: 200
      Segment: Loyal Customers Amount: 217
      Recency: 590
      Segment: Lost Amount: 520
      Recency: 222
      Segment: Loyal Customers Amount: 968
      Recency: 144
      Segment: Champions Amount: 564
      Recency: 77
      Segment: Champions Amount: 407
      Recency: 391
      Segment: Need Attention Amount: 186
      Recency: 27
      Segment: Potential Loyalist Amount: 559
      Recency: 499
      Segment: At Risk Amount: 837
      Recency: 426
      Segment: Loyal Customers Amount: 346
      Recency: 601
      Segment: Lost Amount: 343
      Recency: 250
      Segment: Others Amount: 314
      Recency: 144
      Segment: Potential Loyalist Amount: 232
      Recency: 120
      Segment: Potential Loyalist Amount: 636
      Recency: 240
      Segment: Loyal Customers Amount: 716
      Recency: 133
      Segment: Champions Amount: 596
      Recency: 95
      Segment: Champions Amount: 281
      Recency: 46
      Segment: Potential Loyalist Amount: 805
      Recency: 316
      Segment: Loyal Customers Amount: 293
      Recency: 526
      Segment: Lost Amount: 420
      Recency: 350
      Segment: Loyal Customers Amount: 187
      Recency: 155
      Segment: Potential Loyalist Amount: 360
      Recency: 135
      Segment: Potential Loyalist Amount: 602
      Recency: 474
      Segment: At Risk Amount: 82
      Recency: 139
      Segment: Potential Loyalist Amount: 169
      Recency: 510
      Segment: Lost Amount: 728
      Recency: 525
      Segment: At Risk Amount: 222
      Recency: 506
      Segment: Lost Amount: 277
      Recency: 84
      Segment: Others Amount: 406
      Recency: 153
      Segment: Loyal Customers Amount: 144
      Recency: 158
      Segment: Potential Loyalist Amount: 510
      Recency: 111
      Segment: Champions Amount: 311
      Recency: 537
      Segment: Lost Amount: 491
      Recency: 458
      Segment: Others Amount: 1007
      Recency: 116
      Segment: Champions Amount: 295
      Recency: 114
      Segment: Potential Loyalist Amount: 775
      Recency: 167
      Segment: Champions Amount: 353
      Recency: 280
      Segment: Potential Loyalist Amount: 313
      Recency: 140
      Segment: Others Amount: 435
      Recency: 676
      Segment: At Risk Amount: 950
      Recency: 221
      Segment: Loyal Customers Amount: 331
      Recency: 537
      Segment: Lost Amount: 81
      Recency: 558
      Segment: Lost Amount: 790
      Recency: 88
      Segment: Champions Amount: 312
      Recency: 268
      Segment: Potential Loyalist Amount: 439
      Recency: 307
      Segment: Others Amount: 700
      Recency: 479
      Segment: Loyal Customers Amount: 342
      Recency: 261
      Segment: Potential Loyalist Amount: 704
      Recency: 144
      Segment: Champions Amount: 612
      Recency: 462
      Segment: Loyal Customers Amount: 271
      Recency: 463
      Segment: About To Sleep Amount: 1018
      Recency: 183
      Segment: Loyal Customers Amount: 218
      Recency: 59
      Segment: Potential Loyalist Amount: 237
      Recency: 846
      Segment: Lost Amount: 484
      Recency: 592
      Segment: Others Amount: 510
      Recency: 265
      Segment: Loyal Customers Amount: 222
      Recency: 504
      Segment: Lost Amount: 402
      Recency: 392
      Segment: Loyal Customers Amount: 425
      Recency: 152
      Segment: Loyal Customers Amount: 620
      Recency: 265
      Segment: Loyal Customers Amount: 615
      Recency: 229
      Segment: Loyal Customers Amount: 172
      Recency: 559
      Segment: Lost Amount: 566
      Recency: 431
      Segment: Loyal Customers Amount: 432
      Recency: 30
      Segment: Potential Loyalist Amount: 371
      Recency: 82
      Segment: Potential Loyalist Amount: 589
      Recency: 446
      Segment: Loyal Customers Amount: 30
      Recency: 951
      Segment: Lost Amount: 495
      Recency: 443
      Segment: Loyal Customers Amount: 198
      Recency: 583
      Segment: Lost Amount: 392
      Recency: 433
      Segment: Need Attention Amount: 316
      Recency: 160
      Segment: Potential Loyalist Amount: 819
      Recency: 48
      Segment: Champions Amount: 766
      Recency: 176
      Segment: Champions Amount: 62
      Recency: 480
      Segment: About To Sleep Amount: 364
      Recency: 352
      Segment: Need Attention Amount: 244
      Recency: 589
      Segment: Lost Amount: 291
      Recency: 199
      Segment: Potential Loyalist Amount: 385
      Recency: 143
      Segment: Potential Loyalist Amount: 363
      Recency: 430
      Segment: Need Attention Amount: 172
      Recency: 251
      Segment: Potential Loyalist Amount: 356
      Recency: 295
      Segment: Potential Loyalist Amount: 205
      Recency: 430
      Segment: About To Sleep Amount: 185
      Recency: 392
      Segment: About To Sleep Amount: 422
      Recency: 137
      Segment: Potential Loyalist Amount: 328
      Recency: 847
      Segment: At Risk Amount: 668
      Recency: 10
      Segment: Champions Amount: 323
      Recency: 17
      Segment: Potential Loyalist Amount: 476
      Recency: 263
      Segment: Loyal Customers Amount: 270
      Recency: 80
      Segment: Potential Loyalist Amount: 231
      Recency: 359
      Segment: About To Sleep Amount: 460
      Recency: 39
      Segment: Loyal Customers Amount: 1233
      Recency: 43
      Segment: Champions Amount: 251
      Recency: 23
      Segment: Potential Loyalist Amount: 387
      Recency: 149
      Segment: Potential Loyalist Amount: 581
      Recency: 467
      Segment: Loyal Customers Amount: 544
      Recency: 135
      Segment: Champions Amount: 586
      Recency: 95
      Segment: Loyal Customers Amount: 633
      Recency: 9
      Segment: Others Amount: 674
      Recency: 556
      Segment: At Risk Amount: 626
      Recency: 154
      Segment: Champions Amount: 713
      Recency: 529
      Segment: At Risk Amount: 166
      Recency: 81
      Segment: Potential Loyalist Amount: 384
      Recency: 99
      Segment: Potential Loyalist Amount: 579
      Recency: 545
      Segment: Others Amount: 274
      Recency: 508
      Segment: At Risk Amount: 211
      Recency: 557
      Segment: Lost Amount: 198
      Recency: 224
      Segment: Potential Loyalist Amount: 284
      Recency: 558
      Segment: At Risk Amount: 532
      Recency: 511
      Segment: At Risk Amount: 575
      Recency: 186
      Segment: Others Amount: 1249
      Recency: 20
      Segment: Champions Amount: 615
      Recency: 332
      Segment: Loyal Customers Amount: 892
      Recency: 12
      Segment: Champions Amount: 370
      Recency: 284
      Segment: Potential Loyalist Amount: 260
      Recency: 146
      Segment: Potential Loyalist Amount: 97
      Recency: 92
      Segment: Potential Loyalist Amount: 792
      Recency: 515
      Segment: At Risk Amount: 456
      Recency: 101
      Segment: Loyal Customers Amount: 648
      Recency: 655
      Segment: At Risk Amount: 958
      Recency: 55
      Segment: Champions Amount: 583
      Recency: 208
      Segment: Loyal Customers Amount: 549
      Recency: 629
      Segment: At Risk Amount: 123
      Recency: 102
      Segment: Potential Loyalist Amount: 836
      Recency: 317
      Segment: Loyal Customers Amount: 230
      Recency: 432
      Segment: About To Sleep Amount: 375
      Recency: 222
      Segment: Potential Loyalist Amount: 203
      Recency: 490
      Segment: Lost Amount: 265
      Recency: 439
      Segment: At Risk Amount: 805
      Recency: 481
      Segment: Loyal Customers Amount: 268
      Recency: 174
      Segment: Potential Loyalist Amount: 155
      Recency: 47
      Segment: Potential Loyalist Amount: 77
      Recency: 499
      Segment: Lost Amount: 433
      Recency: 148
      Segment: Potential Loyalist Amount: 307
      Recency: 170
      Segment: Potential Loyalist Amount: 433
      Recency: 64
      Segment: Loyal Customers Amount: 868
      Recency: 44
      Segment: Champions Amount: 466
      Recency: 63
      Segment: Loyal Customers Amount: 336
      Recency: 397
      Segment: About To Sleep Amount: 301
      Recency: 480
      Segment: Need Attention Amount: 546
      Recency: 652
      Segment: At Risk Amount: 744
      Recency: 129
      Segment: Champions Amount: 826
      Recency: 172
      Segment: Champions Amount: 476
      Recency: 172
      Segment: Loyal Customers Amount: 233
      Recency: 575
      Segment: Lost Amount: 332
      Recency: 195
      Segment: Potential Loyalist Amount: 841
      Recency: 569
      Segment: At Risk Amount: 529
      Recency: 130
      Segment: Champions Amount: 746
      Recency: 320
      Segment: Loyal Customers Amount: 531
      Recency: 83
      Segment: Champions Amount: 194
      Recency: 62
      Segment: Potential Loyalist Amount: 431
      Recency: 102
      Segment: Loyal Customers Amount: 183
      Recency: 187
      Segment: Potential Loyalist Amount: 401
      Recency: 488
      Segment: At Risk Amount: 1150
      Recency: 326
      Segment: Loyal Customers Amount: 32
      Recency: 696
      Segment: Lost Amount: 363
      Recency: 28
      Segment: Potential Loyalist Amount: 839
      Recency: 13
      Segment: Champions Amount: 268
      Recency: 457
      Segment: About To Sleep Amount: 448
      Recency: 168
      Segment: Loyal Customers Amount: 421
      Recency: 269
      Segment: Loyal Customers Amount: 282
      Recency: 129
      Segment: Potential Loyalist Amount: 792
      Recency: 7
      Segment: Champions Amount: 99
      Recency: 629
      Segment: Lost Amount: 43
      Recency: 493
      Segment: Lost Amount: 519
      Recency: 80
      Segment: Loyal Customers Amount: 829
      Recency: 340
      Segment: Loyal Customers Amount: 895
      Recency: 26
      Segment: Champions Amount: 270
      Recency: 77
      Segment: Potential Loyalist Amount: 106
      Recency: 595
      Segment: Lost Amount: 81
      Recency: 684
      Segment: Lost Amount: 244
      Recency: 62
      Segment: Potential Loyalist Amount: 768
      Recency: 159
      Segment: Champions Amount: 283
      Recency: 33
      Segment: Potential Loyalist Amount: 722
      Recency: 379
      Segment: Loyal Customers Amount: 526
      Recency: 252
      Segment: Loyal Customers Amount: 892
      Recency: 481
      Segment: Loyal Customers Amount: 581
      Recency: 134
      Segment: Champions Amount: 753
      Recency: 218
      Segment: Loyal Customers Amount: 286
      Recency: 548
      Segment: Lost Amount: 91
      Recency: 317
      Segment: About To Sleep Amount: 579
      Recency: 632
      Segment: At Risk Amount: 595
      Recency: 168
      Segment: Champions Amount: 252
      Recency: 528
      Segment: Lost Amount: 424
      Recency: 98
      Segment: Potential Loyalist Amount: 651
      Recency: 103
      Segment: Champions Amount: 251
      Recency: 227
      Segment: Potential Loyalist Amount: 317
      Recency: 423
      Segment: At Risk Amount: 648
      Recency: 181
      Segment: Loyal Customers Amount: 298
      Recency: 183
      Segment: Potential Loyalist Amount: 411
      Recency: 94
      Segment: Potential Loyalist Amount: 263
      Recency: 572
      Segment: At Risk Amount: 365
      Recency: 182
      Segment: Others Amount: 172
      Recency: 686
      Segment: Lost Amount: 165
      Recency: 600
      Segment: Lost Amount: 277
      Recency: 327
      Segment: Need Attention Amount: 416
      Recency: 379
      Segment: Need Attention Amount: 269
      Recency: 509
      Segment: At Risk Amount: 484
      Recency: 272
      Segment: Loyal Customers Amount: 311
      Recency: 538
      Segment: Lost Amount: 455
      Recency: 613
      Segment: Others Amount: 937
      Recency: 146
      Segment: Champions Amount: 540
      Recency: 8
      Segment: Champions Amount: 133
      Recency: 620
      Segment: Lost Amount: 72
      Recency: 734
      Segment: Lost Amount: 1065
      Recency: 260
      Segment: Loyal Customers Amount: 430
      Recency: 527
      Segment: At Risk Amount: 169
      Recency: 427
      Segment: About To Sleep Amount: 228
      Recency: 439
      Segment: About To Sleep Amount: 471
      Recency: 199
      Segment: Loyal Customers Amount: 571
      Recency: 456
      Segment: Loyal Customers Amount: 363
      Recency: 531
      Segment: Lost Amount: 573
      Recency: 51
      Segment: Champions Amount: 420
      Recency: 416
      Segment: Others Amount: 644
      Recency: 433
      Segment: Loyal Customers Amount: 294
      Recency: 28
      Segment: Potential Loyalist Amount: 460
      Recency: 20
      Segment: Loyal Customers Amount: 489
      Recency: 652
      Segment: At Risk Amount: 165
      Recency: 176
      Segment: Potential Loyalist Amount: 301
      Recency: 548
      Segment: Lost Amount: 464
      Recency: 122
      Segment: Loyal Customers Amount: 393
      Recency: 80
      Segment: Loyal Customers Amount: 282
      Recency: 173
      Segment: Potential Loyalist Amount: 86
      Recency: 599
      Segment: Lost Amount: 400
      Recency: 444
      Segment: Need Attention Amount: 149
      Recency: 126
      Segment: Potential Loyalist Amount: 346
      Recency: 102
      Segment: Others Amount: 759
      Recency: 30
      Segment: Champions Amount: 677
      Recency: 582
      Segment: At Risk Amount: 353
      Recency: 125
      Segment: Potential Loyalist Amount: 248
      Recency: 34
      Segment: Potential Loyalist Amount: 340
      Recency: 633
      Segment: At Risk Amount: 143
      Recency: 165
      Segment: Potential Loyalist Amount: 162
      Recency: 577
      Segment: Lost Amount: 188
      Recency: 101
      Segment: Potential Loyalist Amount: 631
      Recency: 498
      Segment: At Risk Amount: 450
      Recency: 100
      Segment: Loyal Customers Amount: 548
      Recency: 112
      Segment: Champions Amount: 662
      Recency: 225
      Segment: Loyal Customers Amount: 556
      Recency: 504
      Segment: At Risk Amount: 542
      Recency: 408
      Segment: Loyal Customers Amount: 357
      Recency: 164
      Segment: Others Amount: 317
      Recency: 225
      Segment: Potential Loyalist Amount: 260
      Recency: 150
      Segment: Potential Loyalist Amount: 234
      Recency: 96
      Segment: Potential Loyalist Amount: 885
      Recency: 172
      Segment: Champions Amount: 471
      Recency: 132
      Segment: Loyal Customers Amount: 236
      Recency: 171
      Segment: Potential Loyalist Amount: 332
      Recency: 264
      Segment: Potential Loyalist Amount: 95
      Recency: 516
      Segment: Lost Amount: 900
      Recency: 198
      Segment: Loyal Customers Amount: 665
      Recency: 132
      Segment: Champions Amount: 266
      Recency: 399
      Segment: About To Sleep Amount: 619
      Recency: 127
      Segment: Champions Amount: 758
      Recency: 116
      Segment: Champions Amount: 416
      Recency: 134
      Segment: Loyal Customers Amount: 333
      Recency: 393
      Segment: Need Attention Amount: 1004
      Recency: 186
      Segment: Loyal Customers Amount: 236
      Recency: 136
      Segment: Potential Loyalist Amount: 603
      Recency: 449
      Segment: Loyal Customers Amount: 363
      Recency: 636
      Segment: At Risk Amount: 734
      Recency: 21
      Segment: Loyal Customers Amount: 119
      Recency: 187
      Segment: Potential Loyalist Amount: 436
      Recency: 122
      Segment: Loyal Customers Amount: 489
      Recency: 289
      Segment: Potential Loyalist Amount: 264
      Recency: 331
      Segment: About To Sleep Amount: 384
      Recency: 277
      Segment: Loyal Customers Amount: 578
      Recency: 371
      Segment: Loyal Customers Amount: 518
      Recency: 379
      Segment: Loyal Customers Amount: 819
      Recency: 179
      Segment: Champions Amount: 368
      Recency: 414
      Segment: At Risk Amount: 672
      Recency: 213
      Segment: Loyal Customers Amount: 386
      Recency: 431
      Segment: Others Amount: 513
      Recency: 65
      Segment: Champions Amount: 434
      Recency: 239
      Segment: Loyal Customers Amount: 114
      Recency: 119
      Segment: Potential Loyalist Amount: 102
      Recency: 516
      Segment: Lost Amount: 708
      Recency: 133
      Segment: Loyal Customers Amount: 499
      Recency: 486
      Segment: At Risk Amount: 400
      Recency: 493
      Segment: At Risk Amount: 840
      Recency: 410
      Segment: Loyal Customers Amount: 496
      Recency: 421
      Segment: Loyal Customers Amount: 300
      Recency: 545
      Segment: At Risk Amount: 113
      Recency: 569
      Segment: Lost Amount: 235
      Recency: 245
      Segment: Potential Loyalist Amount: 1036
      Recency: 73
      Segment: Champions Amount: 138
      Recency: 164
      Segment: Potential Loyalist Amount: 267
      Recency: 613
      Segment: Lost Amount: 175
      Recency: 444
      Segment: About To Sleep Amount: 687
      Recency: 442
      Segment: Loyal Customers Amount: 455
      Recency: 203
      Segment: Loyal Customers Amount: 466
      Recency: 131
      Segment: Loyal Customers Amount: 396
      Recency: 392
      Segment: Loyal Customers Amount: 486
      Recency: 251
      Segment: Loyal Customers Amount: 613
      Recency: 194
      Segment: Loyal Customers Amount: 546
      Recency: 443
      Segment: Loyal Customers Amount: 474
      Recency: 455
      Segment: Loyal Customers Amount: 922
      Recency: 463
      Segment: Loyal Customers Amount: 694
      Recency: 159
      Segment: Champions Amount: 228
      Recency: 228
      Segment: Potential Loyalist Amount: 1104
      Recency: 97
      Segment: Champions Amount: 410
      Recency: 189
      Segment: Potential Loyalist Amount: 521
      Recency: 491
      Segment: At Risk Amount: 584
      Recency: 106
      Segment: Champions Amount: 149
      Recency: 161
      Segment: Potential Loyalist Amount: 880
      Recency: 160
      Segment: Champions Amount: 719
      Recency: 356
      Segment: Loyal Customers Amount: 473
      Recency: 182
      Segment: Potential Loyalist Amount: 523
      Recency: 106
      Segment: Champions Amount: 1060
      Recency: 160
      Segment: Champions Amount: 415
      Recency: 105
      Segment: Loyal Customers Amount: 434
      Recency: 280
      Segment: Loyal Customers Amount: 87
      Recency: 375
      Segment: About To Sleep Amount: 714
      Recency: 343
      Segment: Loyal Customers Amount: 641
      Recency: 153
      Segment: Champions Amount: 276
      Recency: 191
      Segment: Potential Loyalist Amount: 249
      Recency: 241
      Segment: Potential Loyalist Amount: 374
      Recency: 276
      Segment: Potential Loyalist Amount: 374
      Recency: 66
      Segment: Potential Loyalist Amount: 253
      Recency: 285
      Segment: Potential Loyalist Amount: 203
      Recency: 488
      Segment: Lost Amount: 75
      Recency: 360
      Segment: About To Sleep Amount: 332
      Recency: 147
      Segment: Potential Loyalist Amount: 421
      Recency: 102
      Segment: Potential Loyalist Amount: 291
      Recency: 372
      Segment: Need Attention Amount: 435
      Recency: 478
      Segment: Loyal Customers Amount: 23
      Recency: 760
      Segment: Lost Amount: 1090
      Recency: 53
      Segment: Champions Amount: 403
      Recency: 512
      Segment: At Risk Amount: 874
      Recency: 34
      Segment: Loyal Customers Amount: 1062
      Recency: 41
      Segment: Champions Amount: 570
      Recency: 539
      Segment: At Risk Amount: 416
      Recency: 511
      Segment: At Risk Amount: 771
      Recency: 81
      Segment: Champions Amount: 326
      Recency: 235
      Segment: Potential Loyalist Amount: 665
      Recency: 294
      Segment: Loyal Customers Amount: 556
      Recency: 236
      Segment: Loyal Customers Amount: 275
      Recency: 173
      Segment: Potential Loyalist Amount: 286
      Recency: 179
      Segment: Potential Loyalist Amount: 359
      Recency: 146
      Segment: Potential Loyalist Amount: 547
      Recency: 6
      Segment: Champions Amount: 488
      Recency: 50
      Segment: Loyal Customers Amount: 888
      Recency: 116
      Segment: Champions Amount: 392
      Recency: 422
      Segment: Loyal Customers Amount: 506
      Recency: 135
      Segment: Loyal Customers Amount: 764
      Recency: 113
      Segment: Champions Amount: 714
      Recency: 29
      Segment: Champions Amount: 438
      Recency: 352
      Segment: Loyal Customers Amount: 450
      Recency: 88
      Segment: Loyal Customers Amount: 653
      Recency: 281
      Segment: Loyal Customers Amount: 366
      Recency: 589
      Segment: Lost Amount: 268
      Recency: 391
      Segment: About To Sleep Amount: 401
      Recency: 265
      Segment: Loyal Customers Amount: 382
      Recency: 512
      Segment: At Risk Amount: 552
      Recency: 67
      Segment: Others Amount: 806
      Recency: 153
      Segment: Champions Amount: 223
      Recency: 604
      Segment: Lost Amount: 317
      Recency: 390
      Segment: About To Sleep Amount: 479
      Recency: 101
      Segment: Loyal Customers Amount: 436
      Recency: 455
      Segment: Need Attention Amount: 101
      Recency: 272
      Segment: Potential Loyalist Amount: 770
      Recency: 148
      Segment: Champions Amount: 391
      Recency: 48
      Segment: Loyal Customers Amount: 520
      Recency: 374
      Segment: At Risk Amount: 663
      Recency: 449
      Segment: Loyal Customers Amount: 243
      Recency: 200
      Segment: Potential Loyalist Amount: 416
      Recency: 505
      Segment: At Risk Amount: 552
      Recency: 662
      Segment: At Risk Amount: 77
      Recency: 673
      Segment: Lost Amount: 935
      Recency: 453
      Segment: Loyal Customers Amount: 236
      Recency: 171
      Segment: Potential Loyalist Amount: 314
      Recency: 190
      Segment: Potential Loyalist Amount: 218
      Recency: 410
      Segment: About To Sleep Amount: 987
      Recency: 127
      Segment: Champions Amount: 529
      Recency: 429
      Segment: Others Amount: 1027
      Recency: 169
      Segment: Champions Amount: 613
      Recency: 144
      Segment: Champions Amount: 751
      Recency: 129
      Segment: Champions Amount: 274
      Recency: 336
      Segment: About To Sleep Amount: 829
      Recency: 403
      Segment: Loyal Customers Amount: 276
      Recency: 67
      Segment: Potential Loyalist Amount: 229
      Recency: 249
      Segment: Potential Loyalist Amount: 57
      Recency: 700
      Segment: Lost Amount: 318
      Recency: 61
      Segment: Potential Loyalist Amount: 554
      Recency: 398
      Segment: Loyal Customers Amount: 353
      Recency: 449
      Segment: About To Sleep Amount: 549
      Recency: 381
      Segment: Loyal Customers Amount: 382
      Recency: 99
      Segment: Loyal Customers Amount: 357
      Recency: 288
      Segment: Potential Loyalist Amount: 566
      Recency: 407
      Segment: Loyal Customers Amount: 698
      Recency: 297
      Segment: Loyal Customers Amount: 774
      Recency: 136
      Segment: Champions Amount: 653
      Recency: 246
      Segment: Loyal Customers Amount: 532
      Recency: 57
      Segment: Champions Amount: 536
      Recency: 142
      Segment: Champions Amount: 646
      Recency: 481
      Segment: Loyal Customers Amount: 537
      Recency: 86
      Segment: Loyal Customers Amount: 473
      Recency: 48
      Segment: Potential Loyalist Amount: 275
      Recency: 287
      Segment: Potential Loyalist Amount: 712
      Recency: 137
      Segment: Champions Amount: 347
      Recency: 8
      Segment: Potential Loyalist Amount: 359
      Recency: 177
      Segment: Potential Loyalist Amount: 630
      Recency: 182
      Segment: Loyal Customers Amount: 872
      Recency: 575
      Segment: At Risk Amount: 528
      Recency: 206
      Segment: Loyal Customers Amount: 741
      Recency: 180
      Segment: Champions Amount: 447
      Recency: 79
      Segment: Loyal Customers Amount: 350
      Recency: 210
      Segment: Potential Loyalist Amount: 347
      Recency: 190
      Segment: Potential Loyalist Amount: 292
      Recency: 533
      Segment: Lost Amount: 441
      Recency: 233
      Segment: Potential Loyalist Amount: 1488
      Recency: 168
      Segment: Champions Amount: 289
      Recency: 113
      Segment: Potential Loyalist Amount: 332
      Recency: 92
      Segment: Potential Loyalist Amount: 668
      Recency: 495
      Segment: At Risk Amount: 260
      Recency: 478
      Segment: About To Sleep Amount: 82
      Recency: 479
      Segment: About To Sleep Amount: 781
      Recency: 171
      Segment: Champions Amount: 155
      Recency: 695
      Segment: Lost Amount: 479
      Recency: 681
      Segment: Others Amount: 242
      Recency: 350
      Segment: About To Sleep Amount: 251
      Recency: 90
      Segment: Potential Loyalist Amount: 889
      Recency: 183
      Segment: Loyal Customers Amount: 209
      Recency: 117
      Segment: Potential Loyalist Amount: 259
      Recency: 334
      Segment: Need Attention Amount: 520
      Recency: 502
      Segment: At Risk Amount: 652
      Recency: 284
      Segment: Loyal Customers Amount: 113
      Recency: 466
      Segment: About To Sleep Amount: 196
      Recency: 352
      Segment: About To Sleep Amount: 516
      Recency: 72
      Segment: Others Amount: 1003
      Recency: 27
      Segment: Champions Amount: 309
      Recency: 549
      Segment: At Risk Amount: 585
      Recency: 372
      Segment: Loyal Customers Amount: 356
      Recency: 112
      Segment: Others Amount: 1074
      Recency: 124
      Segment: Champions Amount: 437
      Recency: 469
      Segment: Loyal Customers Amount: 775
      Recency: 63
      Segment: Champions Amount: 724
      Recency: 195
      Segment: Loyal Customers Amount: 601
      Recency: 146
      Segment: Others Amount: 854
      Recency: 197
      Segment: Loyal Customers Amount: 814
      Recency: 21
      Segment: Champions Amount: 574
      Recency: 181
      Segment: Others Amount: 230
      Recency: 172
      Segment: Potential Loyalist Amount: 1008
      Recency: 311
      Segment: Loyal Customers Amount: 632
      Recency: 426
      Segment: At Risk Amount: 512
      Recency: 193
      Segment: Loyal Customers Amount: 458
      Recency: 647
      Segment: At Risk Amount: 621
      Recency: 431
      Segment: Loyal Customers Amount: 375
      Recency: 359
      Segment: Need Attention Amount: 515
      Recency: 307
      Segment: Loyal Customers Amount: 157
      Recency: 77
      Segment: Potential Loyalist Amount: 773
      Recency: 427
      Segment: Loyal Customers Amount: 152
      Recency: 239
      Segment: Potential Loyalist Amount: 536
      Recency: 175
      Segment: Champions Amount: 688
      Recency: 161
      Segment: Champions Amount: 655
      Recency: 399
      Segment: At Risk Amount: 485
      Recency: 118
      Segment: Loyal Customers Amount: 285
      Recency: 94
      Segment: Potential Loyalist Amount: 358
      Recency: 202
      Segment: Others Amount: 589
      Recency: 473
      Segment: Loyal Customers Amount: 96
      Recency: 588
      Segment: Lost Amount: 1011
      Recency: 148
      Segment: Champions Amount: 424
      Recency: 106
      Segment: Loyal Customers Amount: 306
      Recency: 446
      Segment: Need Attention Amount: 648
      Recency: 494
      Segment: At Risk Amount: 61
      Recency: 955
      Segment: Lost Amount: 111
      Recency: 200
      Segment: Potential Loyalist Amount: 133
      Recency: 976
      Segment: Lost Amount: 730
      Recency: 312
      Segment: Loyal Customers Amount: 479
      Recency: 97
      Segment: Loyal Customers Amount: 340
      Recency: 105
      Segment: Potential Loyalist Amount: 492
      Recency: 417
      Segment: Loyal Customers Amount: 139
      Recency: 436
      Segment: About To Sleep Amount: 284
      Recency: 509
      Segment: Lost Amount: 166
      Recency: 632
      Segment: Lost Amount: 94
      Recency: 578
      Segment: Lost Amount: 28
      Recency: 568
      Segment: Lost Amount: 413
      Recency: 295
      Segment: Potential Loyalist Amount: 782
      Recency: 45
      Segment: Champions Amount: 708
      Recency: 82
      Segment: Champions Amount: 788
      Recency: 186
      Segment: Loyal Customers Amount: 79
      Recency: 651
      Segment: Lost Amount: 237
      Recency: 84
      Segment: Potential Loyalist Amount: 437
      Recency: 472
      Segment: Loyal Customers Amount: 711
      Recency: 48
      Segment: Champions Amount: 420
      Recency: 151
      Segment: Loyal Customers Amount: 348
      Recency: 103
      Segment: Potential Loyalist Amount: 311
      Recency: 471
      Segment: About To Sleep Amount: 560
      Recency: 151
      Segment: Champions Amount: 128
      Recency: 229
      Segment: Potential Loyalist Amount: 289
      Recency: 309
      Segment: Need Attention Amount: 587
      Recency: 101
      Segment: Champions Amount: 265
      Recency: 116
      Segment: Potential Loyalist Amount: 371
      Recency: 304
      Segment: Need Attention Amount: 482
      Recency: 412
      Segment: Need Attention Amount: 716
      Recency: 299
      Segment: Loyal Customers Amount: 505
      Recency: 333
      Segment: Need Attention Amount: 582
      Recency: 279
      Segment: Loyal Customers Amount: 713
      Recency: 116
      Segment: Champions Amount: 639
      Recency: 68
      Segment: Loyal Customers Amount: 575
      Recency: 270
      Segment: Loyal Customers Amount: 1050
      Recency: 384
      Segment: Loyal Customers Amount: 114
      Recency: 476
      Segment: About To Sleep Amount: 583
      Recency: 164
      Segment: Champions Amount: 438
      Recency: 43
      Segment: Potential Loyalist Amount: 446
      Recency: 122
      Segment: Potential Loyalist Amount: 388
      Recency: 231
      Segment: Potential Loyalist Amount: 475
      Recency: 583
      Segment: At Risk Amount: 965
      Recency: 85
      Segment: Champions Amount: 249
      Recency: 168
      Segment: Potential Loyalist Amount: 673
      Recency: 443
      Segment: Loyal Customers Amount: 258
      Recency: 107
      Segment: Potential Loyalist Amount: 184
      Recency: 533
      Segment: Lost Amount: 166
      Recency: 507
      Segment: Lost Amount: 386
      Recency: 410
      Segment: Need Attention Amount: 252
      Recency: 497
      Segment: Lost Amount: 209
      Recency: 93
      Segment: Potential Loyalist Amount: 546
      Recency: 86
      Segment: Champions Amount: 565
      Recency: 140
      Segment: Loyal Customers Amount: 431
      Recency: 9
      Segment: Potential Loyalist Amount: 350
      Recency: 275
      Segment: Potential Loyalist Amount: 33
      Recency: 399
      Segment: About To Sleep Amount: 513
      Recency: 372
      Segment: Others Amount: 640
      Recency: 465
      Segment: Loyal Customers Amount: 927
      Recency: 126
      Segment: Champions Amount: 401
      Recency: 162
      Segment: Potential Loyalist Amount: 464
      Recency: 4
      Segment: Loyal Customers Amount: 52
      Recency: 446
      Segment: About To Sleep Amount: 494
      Recency: 48
      Segment: Loyal Customers Amount: 363
      Recency: 98
      Segment: Potential Loyalist Amount: 345
      Recency: 220
      Segment: Potential Loyalist Amount: 649
      Recency: 127
      Segment: Others Amount: 265
      Recency: 114
      Segment: Potential Loyalist Amount: 540
      Recency: 400
      Segment: Loyal Customers Amount: 693
      Recency: 120
      Segment: Champions Amount: 637
      Recency: 93
      Segment: Champions Amount: 554
      Recency: 230
      Segment: Loyal Customers Amount: 180
      Recency: 90
      Segment: Potential Loyalist Amount: 799
      Recency: 569
      Segment: At Risk Amount: 490
      Recency: 149
      Segment: Loyal Customers Amount: 409
      Recency: 377
      Segment: Loyal Customers Amount: 347
      Recency: 354
      Segment: Need Attention Amount: 356
      Recency: 553
      Segment: Lost Amount: 239
      Recency: 6
      Segment: Potential Loyalist Amount: 270
      Recency: 469
      Segment: About To Sleep Amount: 736
      Recency: 242
      Segment: Loyal Customers Amount: 311
      Recency: 93
      Segment: Potential Loyalist Amount: 422
      Recency: 110
      Segment: Potential Loyalist Amount: 277
      Recency: 720
      Segment: Lost Amount: 434
      Recency: 266
      Segment: Loyal Customers Amount: 371
      Recency: 509
      Segment: At Risk Amount: 181
      Recency: 113
      Segment: Potential Loyalist Amount: 283
      Recency: 99
      Segment: Potential Loyalist Amount: 350
      Recency: 416
      Segment: Need Attention Amount: 12
      Recency: 681
      Segment: Lost Amount: 260
      Recency: 173
      Segment: Potential Loyalist Amount: 673
      Recency: 73
      Segment: Champions Amount: 523
      Recency: 142
      Segment: Others Amount: 185
      Recency: 699
      Segment: Lost Amount: 463
      Recency: 222
      Segment: Loyal Customers Amount: 294
      Recency: 723
      Segment: Lost Amount: 464
      Recency: 179
      Segment: Potential Loyalist Amount: 834
      Recency: 32
      Segment: Champions Amount: 390
      Recency: 463
      Segment: Loyal Customers Amount: 548
      Recency: 136
      Segment: Loyal Customers Amount: 740
      Recency: 430
      Segment: Loyal Customers Amount: 654
      Recency: 279
      Segment: Loyal Customers Amount: 316
      Recency: 16
      Segment: Potential Loyalist Amount: 23
      Recency: 186
      Segment: Potential Loyalist Amount: 323
      Recency: 526
      Segment: At Risk Amount: 620
      Recency: 486
      Segment: At Risk Amount: 643
      Recency: 75
      Segment: Others Amount: 404
      Recency: 468
      Segment: Need Attention Amount: 303
      Recency: 103
      Segment: Others Amount: 292
      Recency: 119
      Segment: Potential Loyalist Amount: 188
      Recency: 375
      Segment: About To Sleep Amount: 176
      Recency: 522
      Segment: Lost Amount: 600
      Recency: 201
      Segment: Loyal Customers Amount: 360
      Recency: 532
      Segment: At Risk Amount: 261
      Recency: 125
      Segment: Potential Loyalist Amount: 258
      Recency: 409
      Segment: About To Sleep Amount: 417
      Recency: 37
      Segment: Loyal Customers Amount: 233
      Recency: 178
      Segment: Potential Loyalist Amount: 936
      Recency: 135
      Segment: Champions Amount: 646
      Recency: 145
      Segment: Loyal Customers Amount: 826
      Recency: 491
      Segment: At Risk Amount: 453
      Recency: 276
      Segment: Loyal Customers Amount: 187
      Recency: 485
      Segment: Lost Amount: 937
      Recency: 335
      Segment: Loyal Customers Amount: 423
      Recency: 132
      Segment: Potential Loyalist Amount: 576
      Recency: 114
      Segment: Champions Amount: 613
      Recency: 150
      Segment: Loyal Customers Amount: 79
      Recency: 143
      Segment: Potential Loyalist Amount: 681
      Recency: 525
      Segment: At Risk Amount: 343
      Recency: 636
      Segment: Lost Amount: 248
      Recency: 441
      Segment: About To Sleep Amount: 457
      Recency: 208
      Segment: Loyal Customers Amount: 111
      Recency: 534
      Segment: Lost Amount: 219
      Recency: 607
      Segment: Lost Amount: 425
      Recency: 574
      Segment: At Risk Amount: 694
      Recency: 86
      Segment: Champions Amount: 569
      Recency: 616
      Segment: At Risk Amount: 579
      Recency: 63
      Segment: Loyal Customers Amount: 462
      Recency: 140
      Segment: Potential Loyalist Amount: 212
      Recency: 192
      Segment: Potential Loyalist Amount: 268
      Recency: 264
      Segment: Potential Loyalist Amount: 644
      Recency: 380
      Segment: Loyal Customers Amount: 353
      Recency: 597
      Segment: At Risk Amount: 597
      Recency: 475
      Segment: At Risk Amount: 815
      Recency: 298
      Segment: Loyal Customers Amount: 211
      Recency: 550
      Segment: Lost Amount: 585
      Recency: 488
      Segment: At Risk Amount: 641
      Recency: 586
      Segment: At Risk Amount: 353
      Recency: 484
      Segment: Lost Amount: 132
      Recency: 442
      Segment: About To Sleep Amount: 512
      Recency: 150
      Segment: Loyal Customers Amount: 143
      Recency: 191
      Segment: Potential Loyalist Amount: 39
      Recency: 520
      Segment: Lost Amount: 163
      Recency: 214
      Segment: Potential Loyalist Amount: 632
      Recency: 402
      Segment: Loyal Customers Amount: 453
      Recency: 88
      Segment: Loyal Customers Amount: 220
      Recency: 519
      Segment: Lost Amount: 777
      Recency: 258
      Segment: Loyal Customers Amount: 622
      Recency: 281
      Segment: Loyal Customers Amount: 480
      Recency: 182
      Segment: Loyal Customers Amount: 955
      Recency: 153
      Segment: Champions Amount: 147
      Recency: 215
      Segment: Potential Loyalist Amount: 600
      Recency: 44
      Segment: Champions Amount: 242
      Recency: 244
      Segment: Potential Loyalist Amount: 172
      Recency: 123
      Segment: Potential Loyalist Amount: 394
      Recency: 88
      Segment: Loyal Customers Amount: 476
      Recency: 852
      Segment: At Risk Amount: 306
      Recency: 162
      Segment: Potential Loyalist Amount: 644
      Recency: 249
      Segment: Loyal Customers Amount: 625
      Recency: 462
      Segment: Loyal Customers Amount: 308
      Recency: 487
      Segment: Lost Amount: 219
      Recency: 892
      Segment: Lost Amount: 466
      Recency: 296
      Segment: Potential Loyalist Amount: 536
      Recency: 446
      Segment: Loyal Customers Amount: 620
      Recency: 98
      Segment: Champions Amount: 406
      Recency: 427
      Segment: Loyal Customers Amount: 108
      Recency: 296
      Segment: Potential Loyalist Amount: 241
      Recency: 490
      Segment: Lost Amount: 89
      Recency: 604
      Segment: Lost Amount: 664
      Recency: 433
      Segment: Loyal Customers Amount: 335
      Recency: 174
      Segment: Potential Loyalist Amount: 185
      Recency: 210
      Segment: Potential Loyalist Amount: 82
      Recency: 618
      Segment: Lost Amount: 225
      Recency: 449
      Segment: About To Sleep Amount: 265
      Recency: 601
      Segment: Lost Amount: 1089
      Recency: 319
      Segment: Loyal Customers Amount: 515
      Recency: 496
      Segment: At Risk Amount: 762
      Recency: 49
      Segment: Champions Amount: 1060
      Recency: 183
      Segment: Loyal Customers Amount: 300
      Recency: 182
      Segment: Potential Loyalist Amount: 137
      Recency: 411
      Segment: About To Sleep Amount: 55
      Recency: 597
      Segment: Lost Amount: 580
      Recency: 88
      Segment: Champions Amount: 960
      Recency: 64
      Segment: Champions Amount: 421
      Recency: 550
      Segment: Others Amount: 182
      Recency: 124
      Segment: Potential Loyalist Amount: 809
      Recency: 454
      Segment: Loyal Customers Amount: 672
      Recency: 78
      Segment: Loyal Customers Amount: 816
      Recency: 144
      Segment: Champions Amount: 489
      Recency: 561
      Segment: At Risk Amount: 587
      Recency: 538
      Segment: At Risk Amount: 960
      Recency: 35
      Segment: Champions Amount: 956
      Recency: 129
      Segment: Champions Amount: 413
      Recency: 455
      Segment: Loyal Customers Amount: 360
      Recency: 234
      Segment: Potential Loyalist Amount: 355
      Recency: 515
      Segment: Lost Amount: 570
      Recency: 196
      Segment: Loyal Customers Amount: 358
      Recency: 681
      Segment: Lost Amount: 210
      Recency: 535
      Segment: Lost Amount: 319
      Recency: 71
      Segment: Others Amount: 581
      Recency: 43
      Segment: Champions Amount: 446
      Recency: 171
      Segment: Potential Loyalist Amount: 34
      Recency: 624
      Segment: Lost Amount: 381
      Recency: 366
      Segment: Need Attention Amount: 317
      Recency: 135
      Segment: Potential Loyalist Amount: 254
      Recency: 243
      Segment: Potential Loyalist Amount: 652
      Recency: 204
      Segment: Loyal Customers Amount: 468
      Recency: 663
      Segment: At Risk Amount: 820
      Recency: 502
      Segment: At Risk Amount: 409
      Recency: 564
      Segment: At Risk Amount: 467
      Recency: 600
      Segment: Others Amount: 197
      Recency: 229
      Segment: Potential Loyalist Amount: 420
      Recency: 490
      Segment: At Risk Amount: 405
      Recency: 232
      Segment: Loyal Customers Amount: 312
      Recency: 276
      Segment: Potential Loyalist Amount: 622
      Recency: 145
      Segment: Champions Amount: 496
      Recency: 289
      Segment: Potential Loyalist Amount: 365
      Recency: 128
      Segment: Potential Loyalist Amount: 434
      Recency: 146
      Segment: Potential Loyalist Amount: 597
      Recency: 67
      Segment: Champions Amount: 512
      Recency: 417
      Segment: Loyal Customers Amount: 400
      Recency: 69
      Segment: Potential Loyalist Amount: 447
      Recency: 139
      Segment: Loyal Customers Amount: 652
      Recency: 339
      Segment: Loyal Customers Amount: 436
      Recency: 176
      Segment: Loyal Customers Amount: 265
      Recency: 614
      Segment: Lost Amount: 805
      Recency: 373
      Segment: Loyal Customers Amount: 665
      Recency: 436
      Segment: Loyal Customers Amount: 541
      Recency: 151
      Segment: Others Amount: 558
      Recency: 190
      Segment: Loyal Customers Amount: 826
      Recency: 430
      Segment: Loyal Customers Amount: 732
      Recency: 152
      Segment: Champions Amount: 390
      Recency: 131
      Segment: Potential Loyalist Amount: 462
      Recency: 305
      Segment: Need Attention Amount: 534
      Recency: 263
      Segment: Loyal Customers Amount: 1118
      Recency: 84
      Segment: Champions Amount: 658
      Recency: 160
      Segment: Champions Amount: 538
      Recency: 275
      Segment: Others Amount: 459
      Recency: 178
      Segment: Potential Loyalist Amount: 806
      Recency: 31
      Segment: Champions Amount: 438
      Recency: 75
      Segment: Loyal Customers Amount: 424
      Recency: 157
      Segment: Loyal Customers Amount: 997
      Recency: 188
      Segment: Loyal Customers Amount: 308
      Recency: 148
      Segment: Potential Loyalist Amount: 388
      Recency: 724
      Segment: At Risk Amount: 665
      Recency: 426
      Segment: Loyal Customers Amount: 292
      Recency: 155
      Segment: Others Amount: 427
      Recency: 180
      Segment: Potential Loyalist Amount: 420
      Recency: 166
      Segment: Loyal Customers Amount: 588
      Recency: 176
      Segment: Champions Amount: 760
      Recency: 201
      Segment: Loyal Customers Amount: 384
      Recency: 591
      Segment: Others Amount: 867
      Recency: 153
      Segment: Champions Amount: 654
      Recency: 172
      Segment: Champions Amount: 726
      Recency: 19
      Segment: Champions Amount: 326
      Recency: 201
      Segment: Potential Loyalist Amount: 377
      Recency: 90
      Segment: Potential Loyalist Amount: 450
      Recency: 276
      Segment: Loyal Customers Amount: 363
      Recency: 630
      Segment: At Risk Amount: 688
      Recency: 210
      Segment: Loyal Customers Amount: 329
      Recency: 140
      Segment: Potential Loyalist Amount: 255
      Recency: 282
      Segment: Potential Loyalist Amount: 472
      Recency: 102
      Segment: Loyal Customers Amount: 88
      Recency: 508
      Segment: Lost Amount: 1018
      Recency: 190
      Segment: Loyal Customers Amount: 362
      Recency: 250
      Segment: Others Amount: 1061
      Recency: 103
      Segment: Champions Amount: 295
      Recency: 506
      Segment: Lost Amount: 590
      Recency: 128
      Segment: Champions Amount: 228
      Recency: 171
      Segment: Potential Loyalist Amount: 520
      Recency: 186
      Segment: Loyal Customers Amount: 609
      Recency: 105
      Segment: Others Amount: 237
      Recency: 500
      Segment: Lost Amount: 754
      Recency: 33
      Segment: Champions Amount: 353
      Recency: 288
      Segment: Others Amount: 427
      Recency: 291
      Segment: Loyal Customers Amount: 395
      Recency: 335
      Segment: Need Attention Amount: 642
      Recency: 191
      Segment: Loyal Customers Amount: 778
      Recency: 178
      Segment: Champions Amount: 449
      Recency: 207
      Segment: Potential Loyalist Amount: 471
      Recency: 40
      Segment: Loyal Customers Amount: 1184
      Recency: 206
      Segment: Loyal Customers Amount: 293
      Recency: 227
      Segment: Potential Loyalist Amount: 694
      Recency: 443
      Segment: Loyal Customers Amount: 103
      Recency: 576
      Segment: Lost Amount: 839
      Recency: 138
      Segment: Champions Amount: 627
      Recency: 11
      Segment: Champions Amount: 510
      Recency: 585
      Segment: At Risk Amount: 394
      Recency: 516
      Segment: Others Amount: 393
      Recency: 103
      Segment: Potential Loyalist Amount: 643
      Recency: 261
      Segment: Loyal Customers Amount: 378
      Recency: 295
      Segment: Potential Loyalist Amount: 199
      Recency: 177
      Segment: Potential Loyalist Amount: 324
      Recency: 546
      Segment: Lost Amount: 702
      Recency: 484
      Segment: At Risk Amount: 480
      Recency: 282
      Segment: Loyal Customers Amount: 446
      Recency: 15
      Segment: Loyal Customers Amount: 274
      Recency: 38
      Segment: Potential Loyalist Amount: 522
      Recency: 149
      Segment: Champions Amount: 952
      Recency: 128
      Segment: Champions Amount: 96
      Recency: 545
      Segment: Lost Amount: 709
      Recency: 164
      Segment: Champions Amount: 159
      Recency: 229
      Segment: Potential Loyalist Amount: 870
      Recency: 344
      Segment: Loyal Customers Amount: 433
      Recency: 209
      Segment: Loyal Customers Amount: 542
      Recency: 249
      Segment: Loyal Customers Amount: 558
      Recency: 212
      Segment: Loyal Customers Amount: 121
      Recency: 129
      Segment: Potential Loyalist Amount: 377
      Recency: 54
      Segment: Potential Loyalist Amount: 195
      Recency: 107
      Segment: Potential Loyalist Amount: 650
      Recency: 135
      Segment: Champions Amount: 253
      Recency: 530
      Segment: Lost Amount: 713
      Recency: 45
      Segment: Champions Amount: 504
      Recency: 404
      Segment: Need Attention Amount: 264
      Recency: 198
      Segment: Potential Loyalist Amount: 446
      Recency: 291
      Segment: Loyal Customers Amount: 366
      Recency: 332
      Segment: Need Attention Amount: 474
      Recency: 89
      Segment: Loyal Customers Amount: 547
      Recency: 387
      Segment: Loyal Customers Amount: 855
      Recency: 472
      Segment: Loyal Customers Amount: 690
      Recency: 210
      Segment: Loyal Customers Amount: 208
      Recency: 573
      Segment: Lost Amount: 195
      Recency: 653
      Segment: Lost Amount: 567
      Recency: 542
      Segment: At Risk Amount: 380
      Recency: 122
      Segment: Potential Loyalist Amount: 369
      Recency: 328
      Segment: Need Attention Amount: 1068
      Recency: 81
      Segment: Champions Amount: 421
      Recency: 155
      Segment: Loyal Customers Amount: 823
      Recency: 397
      Segment: Loyal Customers Amount: 473
      Recency: 151
      Segment: Loyal Customers Amount: 224
      Recency: 464
      Segment: About To Sleep Amount: 219
      Recency: 484
      Segment: Lost Amount: 359
      Recency: 240
      Segment: Potential Loyalist Amount: 491
      Recency: 389
      Segment: Need Attention Amount: 789
      Recency: 106
      Segment: Loyal Customers Amount: 153
      Recency: 236
      Segment: Potential Loyalist Amount: 422
      Recency: 159
      Segment: Loyal Customers Amount: 492
      Recency: 539
      Segment: At Risk Amount: 850
      Recency: 64
      Segment: Champions Amount: 492
      Recency: 102
      Segment: Loyal Customers Amount: 569
      Recency: 52
      Segment: Others Amount: 454
      Recency: 490
      Segment: At Risk Amount: 565
      Recency: 246
      Segment: Others Amount: 675
      Recency: 173
      Segment: Loyal Customers Amount: 461
      Recency: 13
      Segment: Loyal Customers Amount: 574
      Recency: 416
      Segment: Loyal Customers Amount: 676
      Recency: 109
      Segment: Champions Amount: 390
      Recency: 517
      Segment: Others Amount: 350
      Recency: 402
      Segment: Need Attention Amount: 297
      Recency: 515
      Segment: Lost Amount: 859
      Recency: 267
      Segment: Loyal Customers Amount: 419
      Recency: 181
      Segment: Loyal Customers Amount: 310
      Recency: 290
      Segment: Potential Loyalist Amount: 1038
      Recency: 129
      Segment: Champions Amount: 52
      Recency: 127
      Segment: Potential Loyalist Amount: 39
      Recency: 265
      Segment: Potential Loyalist Amount: 798
      Recency: 87
      Segment: Champions Amount: 560
      Recency: 490
      Segment: At Risk Amount: 594
      Recency: 169
      Segment: Champions Amount: 332
      Recency: 477
      Segment: About To Sleep Amount: 244
      Recency: 836
      Segment: Lost Amount: 570
      Recency: 321
      Segment: Loyal Customers Amount: 754
      Recency: 157
      Segment: Champions Amount: 665
      Recency: 42
      Segment: Champions Amount: 618
      Recency: 180
      Segment: Loyal Customers Amount: 459
      Recency: 452
      Segment: Loyal Customers Amount: 280
      Recency: 287
      Segment: Potential Loyalist Amount: 277
      Recency: 395
      Segment: Need Attention Amount: 515
      Recency: 152
      Segment: Others Amount: 91
      Recency: 582
      Segment: Lost Amount: 716
      Recency: 549
      Segment: At Risk Amount: 236
      Recency: 163
      Segment: Potential Loyalist Amount: 378
      Recency: 120
      Segment: Others Amount: 760
      Recency: 346
      Segment: Loyal Customers Amount: 490
      Recency: 341
      Segment: Need Attention Amount: 406
      Recency: 387
      Segment: Loyal Customers Amount: 615
      Recency: 43
      Segment: Champions Amount: 574
      Recency: 204
      Segment: Loyal Customers Amount: 1196
      Recency: 207
      Segment: Loyal Customers Amount: 442
      Recency: 405
      Segment: Need Attention Amount: 38
      Recency: 524
      Segment: Lost Amount: 516
      Recency: 548
      Segment: At Risk Amount: 375
      Recency: 224
      Segment: Potential Loyalist

# interactive median plot

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 115 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 245.5 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot sorted

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 115 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 245.5 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot sorted ascending

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 115 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 245.5 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot flipped

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 115 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 245.5 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot flipped sorted

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 115 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 245.5 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot flipped sorted ascending

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 115 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 245.5 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

