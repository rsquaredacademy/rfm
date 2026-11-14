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
      Mean Monetary Value: 601.37 Frequency Score: 4
      Recency Score: 3
      Mean Monetary Value: 602.07 Frequency Score: 4
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
      Customers: 159 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 277 Segment: Need Attention
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
      Customers: 159 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 277 Segment: Need Attention
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
      Customers: 159 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 277 Segment: Need Attention
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
      Customers: 159 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 277 Segment: Need Attention
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
      Customers: 159 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 277 Segment: Need Attention
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
      Customers: 159 Segment: Lost
      Customers: 111 Segment: Loyal Customers
      Customers: 277 Segment: Need Attention
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
      Revenue Share: 26% Segment: Lost
      Revenue Share: 4.51% Segment: Loyal Customers
      Revenue Share: 35.81% Segment: Need Attention
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
      Customer Share: 15.98% Segment: Lost
      Customer Share: 11.16% Segment: Loyal Customers
      Customer Share: 27.84% Segment: Need Attention
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
      Revenue Share: 26% Segment: Lost
      Revenue Share: 4.51% Segment: Loyal Customers
      Revenue Share: 35.81% Segment: Need Attention
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
      Customer Share: 15.98% Segment: Lost
      Customer Share: 11.16% Segment: Loyal Customers
      Customer Share: 27.84% Segment: Need Attention
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
      Customers: 159 (15.98%) Segment:LOST
      Customers: 111 (11.16%) Segment:LOYAL CUSTOMERS
      Customers: 277 (27.84%) Segment:NEED ATTENTION
      Customers: 35 (3.52%) Segment:OTHERS
      Customers: 48 (4.82%) Segment:POTENTIAL LOYALIST
      Customers: 229 (23.02%)

# interactive segment scatter plot

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Monetary Value: 472
      Recency: 205
      Segment: Loyal Customers Monetary Value: 340
      Recency: 140
      Segment: Potential Loyalist Monetary Value: 405
      Recency: 194
      Segment: Potential Loyalist Monetary Value: 596
      Recency: 98
      Segment: Champions Monetary Value: 448
      Recency: 132
      Segment: Loyal Customers Monetary Value: 843
      Recency: 90
      Segment: Champions Monetary Value: 763
      Recency: 84
      Segment: Champions Monetary Value: 699
      Recency: 281
      Segment: Loyal Customers Monetary Value: 157
      Recency: 246
      Segment: Potential Loyalist Monetary Value: 779
      Recency: 160
      Segment: Champions Monetary Value: 363
      Recency: 349
      Segment: About To Sleep Monetary Value: 196
      Recency: 619
      Segment: Lost Monetary Value: 669
      Recency: 210
      Segment: Loyal Customers Monetary Value: 500
      Recency: 138
      Segment: Loyal Customers Monetary Value: 320
      Recency: 396
      Segment: About To Sleep Monetary Value: 393
      Recency: 102
      Segment: Potential Loyalist Monetary Value: 28
      Recency: 168
      Segment: Potential Loyalist Monetary Value: 591
      Recency: 174
      Segment: Champions Monetary Value: 245
      Recency: 157
      Segment: Potential Loyalist Monetary Value: 634
      Recency: 482
      Segment: At Risk Monetary Value: 175
      Recency: 239
      Segment: Potential Loyalist Monetary Value: 786
      Recency: 150
      Segment: Champions Monetary Value: 596
      Recency: 202
      Segment: Loyal Customers Monetary Value: 697
      Recency: 245
      Segment: Loyal Customers Monetary Value: 703
      Recency: 245
      Segment: Loyal Customers Monetary Value: 436
      Recency: 146
      Segment: Potential Loyalist Monetary Value: 862
      Recency: 123
      Segment: Champions Monetary Value: 597
      Recency: 405
      Segment: Loyal Customers Monetary Value: 367
      Recency: 214
      Segment: Others Monetary Value: 392
      Recency: 475
      Segment: Loyal Customers Monetary Value: 548
      Recency: 267
      Segment: Loyal Customers Monetary Value: 598
      Recency: 191
      Segment: Loyal Customers Monetary Value: 539
      Recency: 127
      Segment: Loyal Customers Monetary Value: 712
      Recency: 227
      Segment: Loyal Customers Monetary Value: 876
      Recency: 1
      Segment: Champions Monetary Value: 387
      Recency: 209
      Segment: Loyal Customers Monetary Value: 289
      Recency: 241
      Segment: Potential Loyalist Monetary Value: 663
      Recency: 215
      Segment: Loyal Customers Monetary Value: 191
      Recency: 576
      Segment: Lost Monetary Value: 253
      Recency: 414
      Segment: About To Sleep Monetary Value: 443
      Recency: 164
      Segment: Loyal Customers Monetary Value: 425
      Recency: 339
      Segment: Need Attention Monetary Value: 104
      Recency: 687
      Segment: Lost Monetary Value: 287
      Recency: 676
      Segment: Lost Monetary Value: 225
      Recency: 156
      Segment: Potential Loyalist Monetary Value: 202
      Recency: 12
      Segment: Potential Loyalist Monetary Value: 316
      Recency: 937
      Segment: Lost Monetary Value: 469
      Recency: 360
      Segment: Loyal Customers Monetary Value: 325
      Recency: 444
      Segment: About To Sleep Monetary Value: 589
      Recency: 458
      Segment: At Risk Monetary Value: 336
      Recency: 666
      Segment: Lost Monetary Value: 507
      Recency: 455
      Segment: Loyal Customers Monetary Value: 1069
      Recency: 126
      Segment: Champions Monetary Value: 720
      Recency: 130
      Segment: Champions Monetary Value: 434
      Recency: 327
      Segment: Loyal Customers Monetary Value: 600
      Recency: 39
      Segment: Champions Monetary Value: 492
      Recency: 482
      Segment: At Risk Monetary Value: 341
      Recency: 210
      Segment: Potential Loyalist Monetary Value: 388
      Recency: 46
      Segment: Potential Loyalist Monetary Value: 398
      Recency: 282
      Segment: Potential Loyalist Monetary Value: 567
      Recency: 129
      Segment: Champions Monetary Value: 803
      Recency: 274
      Segment: Loyal Customers Monetary Value: 527
      Recency: 286
      Segment: Others Monetary Value: 81
      Recency: 399
      Segment: About To Sleep Monetary Value: 681
      Recency: 162
      Segment: Others Monetary Value: 687
      Recency: 141
      Segment: Champions Monetary Value: 229
      Recency: 53
      Segment: Potential Loyalist Monetary Value: 856
      Recency: 116
      Segment: Champions Monetary Value: 878
      Recency: 57
      Segment: Champions Monetary Value: 777
      Recency: 122
      Segment: Champions Monetary Value: 370
      Recency: 183
      Segment: Potential Loyalist Monetary Value: 390
      Recency: 35
      Segment: Loyal Customers Monetary Value: 425
      Recency: 179
      Segment: Loyal Customers Monetary Value: 190
      Recency: 932
      Segment: Lost Monetary Value: 319
      Recency: 186
      Segment: Potential Loyalist Monetary Value: 446
      Recency: 4
      Segment: Potential Loyalist Monetary Value: 141
      Recency: 872
      Segment: Lost Monetary Value: 211
      Recency: 253
      Segment: Potential Loyalist Monetary Value: 527
      Recency: 312
      Segment: Loyal Customers Monetary Value: 198
      Recency: 488
      Segment: Lost Monetary Value: 552
      Recency: 181
      Segment: Loyal Customers Monetary Value: 94
      Recency: 632
      Segment: Lost Monetary Value: 37
      Recency: 202
      Segment: Potential Loyalist Monetary Value: 764
      Recency: 217
      Segment: Loyal Customers Monetary Value: 696
      Recency: 269
      Segment: Loyal Customers Monetary Value: 875
      Recency: 72
      Segment: Champions Monetary Value: 276
      Recency: 114
      Segment: Potential Loyalist Monetary Value: 375
      Recency: 152
      Segment: Potential Loyalist Monetary Value: 528
      Recency: 5
      Segment: Champions Monetary Value: 120
      Recency: 870
      Segment: Lost Monetary Value: 977
      Recency: 457
      Segment: Loyal Customers Monetary Value: 190
      Recency: 331
      Segment: About To Sleep Monetary Value: 241
      Recency: 588
      Segment: Lost Monetary Value: 733
      Recency: 250
      Segment: Loyal Customers Monetary Value: 845
      Recency: 181
      Segment: Loyal Customers Monetary Value: 246
      Recency: 365
      Segment: About To Sleep Monetary Value: 531
      Recency: 573
      Segment: At Risk Monetary Value: 318
      Recency: 298
      Segment: About To Sleep Monetary Value: 330
      Recency: 13
      Segment: Potential Loyalist Monetary Value: 435
      Recency: 170
      Segment: Loyal Customers Monetary Value: 470
      Recency: 479
      Segment: Loyal Customers Monetary Value: 381
      Recency: 186
      Segment: Potential Loyalist Monetary Value: 338
      Recency: 601
      Segment: At Risk Monetary Value: 188
      Recency: 176
      Segment: Potential Loyalist Monetary Value: 580
      Recency: 90
      Segment: Champions Monetary Value: 599
      Recency: 310
      Segment: Loyal Customers Monetary Value: 607
      Recency: 376
      Segment: Loyal Customers Monetary Value: 852
      Recency: 229
      Segment: Loyal Customers Monetary Value: 374
      Recency: 174
      Segment: Potential Loyalist Monetary Value: 330
      Recency: 18
      Segment: Others Monetary Value: 226
      Recency: 62
      Segment: Potential Loyalist Monetary Value: 336
      Recency: 363
      Segment: About To Sleep Monetary Value: 161
      Recency: 89
      Segment: Potential Loyalist Monetary Value: 96
      Recency: 497
      Segment: Lost Monetary Value: 580
      Recency: 175
      Segment: Champions Monetary Value: 323
      Recency: 521
      Segment: At Risk Monetary Value: 635
      Recency: 294
      Segment: Loyal Customers Monetary Value: 353
      Recency: 298
      Segment: About To Sleep Monetary Value: 492
      Recency: 101
      Segment: Potential Loyalist Monetary Value: 316
      Recency: 578
      Segment: Lost Monetary Value: 465
      Recency: 41
      Segment: Loyal Customers Monetary Value: 419
      Recency: 266
      Segment: Loyal Customers Monetary Value: 381
      Recency: 172
      Segment: Potential Loyalist Monetary Value: 393
      Recency: 259
      Segment: Potential Loyalist Monetary Value: 442
      Recency: 203
      Segment: Potential Loyalist Monetary Value: 639
      Recency: 236
      Segment: Loyal Customers Monetary Value: 689
      Recency: 122
      Segment: Champions Monetary Value: 456
      Recency: 59
      Segment: Potential Loyalist Monetary Value: 532
      Recency: 225
      Segment: Loyal Customers Monetary Value: 416
      Recency: 349
      Segment: Loyal Customers Monetary Value: 533
      Recency: 473
      Segment: Loyal Customers Monetary Value: 723
      Recency: 108
      Segment: Champions Monetary Value: 281
      Recency: 445
      Segment: Need Attention Monetary Value: 613
      Recency: 71
      Segment: Champions Monetary Value: 787
      Recency: 180
      Segment: Champions Monetary Value: 522
      Recency: 164
      Segment: Loyal Customers Monetary Value: 171
      Recency: 172
      Segment: Potential Loyalist Monetary Value: 620
      Recency: 44
      Segment: Champions Monetary Value: 143
      Recency: 182
      Segment: Potential Loyalist Monetary Value: 721
      Recency: 200
      Segment: Loyal Customers Monetary Value: 217
      Recency: 590
      Segment: Lost Monetary Value: 520
      Recency: 222
      Segment: Loyal Customers Monetary Value: 968
      Recency: 144
      Segment: Champions Monetary Value: 564
      Recency: 77
      Segment: Champions Monetary Value: 407
      Recency: 391
      Segment: Need Attention Monetary Value: 186
      Recency: 27
      Segment: Potential Loyalist Monetary Value: 559
      Recency: 499
      Segment: At Risk Monetary Value: 837
      Recency: 426
      Segment: Loyal Customers Monetary Value: 346
      Recency: 601
      Segment: Lost Monetary Value: 343
      Recency: 250
      Segment: Others Monetary Value: 314
      Recency: 144
      Segment: Potential Loyalist Monetary Value: 232
      Recency: 120
      Segment: Potential Loyalist Monetary Value: 636
      Recency: 240
      Segment: Loyal Customers Monetary Value: 716
      Recency: 133
      Segment: Champions Monetary Value: 596
      Recency: 95
      Segment: Champions Monetary Value: 281
      Recency: 46
      Segment: Potential Loyalist Monetary Value: 805
      Recency: 316
      Segment: Loyal Customers Monetary Value: 293
      Recency: 526
      Segment: Lost Monetary Value: 420
      Recency: 350
      Segment: Loyal Customers Monetary Value: 187
      Recency: 155
      Segment: Potential Loyalist Monetary Value: 360
      Recency: 135
      Segment: Potential Loyalist Monetary Value: 602
      Recency: 474
      Segment: At Risk Monetary Value: 82
      Recency: 139
      Segment: Potential Loyalist Monetary Value: 169
      Recency: 510
      Segment: Lost Monetary Value: 728
      Recency: 525
      Segment: At Risk Monetary Value: 222
      Recency: 506
      Segment: Lost Monetary Value: 277
      Recency: 84
      Segment: Others Monetary Value: 406
      Recency: 153
      Segment: Loyal Customers Monetary Value: 144
      Recency: 158
      Segment: Potential Loyalist Monetary Value: 510
      Recency: 111
      Segment: Champions Monetary Value: 311
      Recency: 537
      Segment: Lost Monetary Value: 491
      Recency: 458
      Segment: Others Monetary Value: 1007
      Recency: 116
      Segment: Champions Monetary Value: 295
      Recency: 114
      Segment: Potential Loyalist Monetary Value: 775
      Recency: 167
      Segment: Champions Monetary Value: 353
      Recency: 280
      Segment: Potential Loyalist Monetary Value: 313
      Recency: 140
      Segment: Others Monetary Value: 435
      Recency: 676
      Segment: At Risk Monetary Value: 950
      Recency: 221
      Segment: Loyal Customers Monetary Value: 331
      Recency: 537
      Segment: Lost Monetary Value: 81
      Recency: 558
      Segment: Lost Monetary Value: 790
      Recency: 88
      Segment: Champions Monetary Value: 312
      Recency: 268
      Segment: Potential Loyalist Monetary Value: 439
      Recency: 307
      Segment: Others Monetary Value: 700
      Recency: 479
      Segment: Loyal Customers Monetary Value: 342
      Recency: 261
      Segment: Potential Loyalist Monetary Value: 704
      Recency: 144
      Segment: Champions Monetary Value: 612
      Recency: 462
      Segment: Loyal Customers Monetary Value: 271
      Recency: 463
      Segment: About To Sleep Monetary Value: 1018
      Recency: 183
      Segment: Loyal Customers Monetary Value: 218
      Recency: 59
      Segment: Potential Loyalist Monetary Value: 237
      Recency: 846
      Segment: Lost Monetary Value: 484
      Recency: 592
      Segment: Others Monetary Value: 510
      Recency: 265
      Segment: Loyal Customers Monetary Value: 222
      Recency: 504
      Segment: Lost Monetary Value: 402
      Recency: 392
      Segment: Loyal Customers Monetary Value: 425
      Recency: 152
      Segment: Loyal Customers Monetary Value: 620
      Recency: 265
      Segment: Loyal Customers Monetary Value: 615
      Recency: 229
      Segment: Loyal Customers Monetary Value: 172
      Recency: 559
      Segment: Lost Monetary Value: 566
      Recency: 431
      Segment: Loyal Customers Monetary Value: 432
      Recency: 30
      Segment: Potential Loyalist Monetary Value: 371
      Recency: 82
      Segment: Potential Loyalist Monetary Value: 589
      Recency: 446
      Segment: Loyal Customers Monetary Value: 30
      Recency: 951
      Segment: Lost Monetary Value: 495
      Recency: 443
      Segment: Loyal Customers Monetary Value: 198
      Recency: 583
      Segment: Lost Monetary Value: 392
      Recency: 433
      Segment: Need Attention Monetary Value: 316
      Recency: 160
      Segment: Potential Loyalist Monetary Value: 819
      Recency: 48
      Segment: Champions Monetary Value: 766
      Recency: 176
      Segment: Champions Monetary Value: 62
      Recency: 480
      Segment: About To Sleep Monetary Value: 364
      Recency: 352
      Segment: Need Attention Monetary Value: 244
      Recency: 589
      Segment: Lost Monetary Value: 291
      Recency: 199
      Segment: Potential Loyalist Monetary Value: 385
      Recency: 143
      Segment: Potential Loyalist Monetary Value: 363
      Recency: 430
      Segment: Need Attention Monetary Value: 172
      Recency: 251
      Segment: Potential Loyalist Monetary Value: 356
      Recency: 295
      Segment: Potential Loyalist Monetary Value: 205
      Recency: 430
      Segment: About To Sleep Monetary Value: 185
      Recency: 392
      Segment: About To Sleep Monetary Value: 422
      Recency: 137
      Segment: Potential Loyalist Monetary Value: 328
      Recency: 847
      Segment: At Risk Monetary Value: 668
      Recency: 10
      Segment: Champions Monetary Value: 323
      Recency: 17
      Segment: Potential Loyalist Monetary Value: 476
      Recency: 263
      Segment: Loyal Customers Monetary Value: 270
      Recency: 80
      Segment: Potential Loyalist Monetary Value: 231
      Recency: 359
      Segment: About To Sleep Monetary Value: 460
      Recency: 39
      Segment: Loyal Customers Monetary Value: 1233
      Recency: 43
      Segment: Champions Monetary Value: 251
      Recency: 23
      Segment: Potential Loyalist Monetary Value: 387
      Recency: 149
      Segment: Potential Loyalist Monetary Value: 581
      Recency: 467
      Segment: Loyal Customers Monetary Value: 544
      Recency: 135
      Segment: Champions Monetary Value: 586
      Recency: 95
      Segment: Loyal Customers Monetary Value: 633
      Recency: 9
      Segment: Others Monetary Value: 674
      Recency: 556
      Segment: At Risk Monetary Value: 626
      Recency: 154
      Segment: Champions Monetary Value: 713
      Recency: 529
      Segment: At Risk Monetary Value: 166
      Recency: 81
      Segment: Potential Loyalist Monetary Value: 384
      Recency: 99
      Segment: Potential Loyalist Monetary Value: 579
      Recency: 545
      Segment: Others Monetary Value: 274
      Recency: 508
      Segment: At Risk Monetary Value: 211
      Recency: 557
      Segment: Lost Monetary Value: 198
      Recency: 224
      Segment: Potential Loyalist Monetary Value: 284
      Recency: 558
      Segment: At Risk Monetary Value: 532
      Recency: 511
      Segment: At Risk Monetary Value: 575
      Recency: 186
      Segment: Others Monetary Value: 1249
      Recency: 20
      Segment: Champions Monetary Value: 615
      Recency: 332
      Segment: Loyal Customers Monetary Value: 892
      Recency: 12
      Segment: Champions Monetary Value: 370
      Recency: 284
      Segment: Potential Loyalist Monetary Value: 260
      Recency: 146
      Segment: Potential Loyalist Monetary Value: 97
      Recency: 92
      Segment: Potential Loyalist Monetary Value: 792
      Recency: 515
      Segment: At Risk Monetary Value: 456
      Recency: 101
      Segment: Loyal Customers Monetary Value: 648
      Recency: 655
      Segment: At Risk Monetary Value: 958
      Recency: 55
      Segment: Champions Monetary Value: 583
      Recency: 208
      Segment: Loyal Customers Monetary Value: 549
      Recency: 629
      Segment: At Risk Monetary Value: 123
      Recency: 102
      Segment: Potential Loyalist Monetary Value: 836
      Recency: 317
      Segment: Loyal Customers Monetary Value: 230
      Recency: 432
      Segment: About To Sleep Monetary Value: 375
      Recency: 222
      Segment: Potential Loyalist Monetary Value: 203
      Recency: 490
      Segment: Lost Monetary Value: 265
      Recency: 439
      Segment: At Risk Monetary Value: 805
      Recency: 481
      Segment: Loyal Customers Monetary Value: 268
      Recency: 174
      Segment: Potential Loyalist Monetary Value: 155
      Recency: 47
      Segment: Potential Loyalist Monetary Value: 77
      Recency: 499
      Segment: Lost Monetary Value: 433
      Recency: 148
      Segment: Potential Loyalist Monetary Value: 307
      Recency: 170
      Segment: Potential Loyalist Monetary Value: 433
      Recency: 64
      Segment: Loyal Customers Monetary Value: 868
      Recency: 44
      Segment: Champions Monetary Value: 466
      Recency: 63
      Segment: Loyal Customers Monetary Value: 336
      Recency: 397
      Segment: About To Sleep Monetary Value: 301
      Recency: 480
      Segment: Need Attention Monetary Value: 546
      Recency: 652
      Segment: At Risk Monetary Value: 744
      Recency: 129
      Segment: Champions Monetary Value: 826
      Recency: 172
      Segment: Champions Monetary Value: 476
      Recency: 172
      Segment: Loyal Customers Monetary Value: 233
      Recency: 575
      Segment: Lost Monetary Value: 332
      Recency: 195
      Segment: Potential Loyalist Monetary Value: 841
      Recency: 569
      Segment: At Risk Monetary Value: 529
      Recency: 130
      Segment: Champions Monetary Value: 746
      Recency: 320
      Segment: Loyal Customers Monetary Value: 531
      Recency: 83
      Segment: Champions Monetary Value: 194
      Recency: 62
      Segment: Potential Loyalist Monetary Value: 431
      Recency: 102
      Segment: Loyal Customers Monetary Value: 183
      Recency: 187
      Segment: Potential Loyalist Monetary Value: 401
      Recency: 488
      Segment: At Risk Monetary Value: 1150
      Recency: 326
      Segment: Loyal Customers Monetary Value: 32
      Recency: 696
      Segment: Lost Monetary Value: 363
      Recency: 28
      Segment: Potential Loyalist Monetary Value: 839
      Recency: 13
      Segment: Champions Monetary Value: 268
      Recency: 457
      Segment: About To Sleep Monetary Value: 448
      Recency: 168
      Segment: Loyal Customers Monetary Value: 421
      Recency: 269
      Segment: Loyal Customers Monetary Value: 282
      Recency: 129
      Segment: Potential Loyalist Monetary Value: 792
      Recency: 7
      Segment: Champions Monetary Value: 99
      Recency: 629
      Segment: Lost Monetary Value: 43
      Recency: 493
      Segment: Lost Monetary Value: 519
      Recency: 80
      Segment: Loyal Customers Monetary Value: 829
      Recency: 340
      Segment: Loyal Customers Monetary Value: 895
      Recency: 26
      Segment: Champions Monetary Value: 270
      Recency: 77
      Segment: Potential Loyalist Monetary Value: 106
      Recency: 595
      Segment: Lost Monetary Value: 81
      Recency: 684
      Segment: Lost Monetary Value: 244
      Recency: 62
      Segment: Potential Loyalist Monetary Value: 768
      Recency: 159
      Segment: Champions Monetary Value: 283
      Recency: 33
      Segment: Potential Loyalist Monetary Value: 722
      Recency: 379
      Segment: Loyal Customers Monetary Value: 526
      Recency: 252
      Segment: Loyal Customers Monetary Value: 892
      Recency: 481
      Segment: Loyal Customers Monetary Value: 581
      Recency: 134
      Segment: Champions Monetary Value: 753
      Recency: 218
      Segment: Loyal Customers Monetary Value: 286
      Recency: 548
      Segment: Lost Monetary Value: 91
      Recency: 317
      Segment: About To Sleep Monetary Value: 579
      Recency: 632
      Segment: At Risk Monetary Value: 595
      Recency: 168
      Segment: Champions Monetary Value: 252
      Recency: 528
      Segment: Lost Monetary Value: 424
      Recency: 98
      Segment: Potential Loyalist Monetary Value: 651
      Recency: 103
      Segment: Champions Monetary Value: 251
      Recency: 227
      Segment: Potential Loyalist Monetary Value: 317
      Recency: 423
      Segment: At Risk Monetary Value: 648
      Recency: 181
      Segment: Loyal Customers Monetary Value: 298
      Recency: 183
      Segment: Potential Loyalist Monetary Value: 411
      Recency: 94
      Segment: Potential Loyalist Monetary Value: 263
      Recency: 572
      Segment: At Risk Monetary Value: 365
      Recency: 182
      Segment: Others Monetary Value: 172
      Recency: 686
      Segment: Lost Monetary Value: 165
      Recency: 600
      Segment: Lost Monetary Value: 277
      Recency: 327
      Segment: Need Attention Monetary Value: 416
      Recency: 379
      Segment: Need Attention Monetary Value: 269
      Recency: 509
      Segment: At Risk Monetary Value: 484
      Recency: 272
      Segment: Loyal Customers Monetary Value: 311
      Recency: 538
      Segment: Lost Monetary Value: 455
      Recency: 613
      Segment: Others Monetary Value: 937
      Recency: 146
      Segment: Champions Monetary Value: 540
      Recency: 8
      Segment: Champions Monetary Value: 133
      Recency: 620
      Segment: Lost Monetary Value: 72
      Recency: 734
      Segment: Lost Monetary Value: 1065
      Recency: 260
      Segment: Loyal Customers Monetary Value: 430
      Recency: 527
      Segment: At Risk Monetary Value: 169
      Recency: 427
      Segment: About To Sleep Monetary Value: 228
      Recency: 439
      Segment: About To Sleep Monetary Value: 471
      Recency: 199
      Segment: Loyal Customers Monetary Value: 571
      Recency: 456
      Segment: Loyal Customers Monetary Value: 363
      Recency: 531
      Segment: Lost Monetary Value: 573
      Recency: 51
      Segment: Champions Monetary Value: 420
      Recency: 416
      Segment: Others Monetary Value: 644
      Recency: 433
      Segment: Loyal Customers Monetary Value: 294
      Recency: 28
      Segment: Potential Loyalist Monetary Value: 460
      Recency: 20
      Segment: Loyal Customers Monetary Value: 489
      Recency: 652
      Segment: At Risk Monetary Value: 165
      Recency: 176
      Segment: Potential Loyalist Monetary Value: 301
      Recency: 548
      Segment: Lost Monetary Value: 464
      Recency: 122
      Segment: Loyal Customers Monetary Value: 393
      Recency: 80
      Segment: Loyal Customers Monetary Value: 282
      Recency: 173
      Segment: Potential Loyalist Monetary Value: 86
      Recency: 599
      Segment: Lost Monetary Value: 400
      Recency: 444
      Segment: Need Attention Monetary Value: 149
      Recency: 126
      Segment: Potential Loyalist Monetary Value: 346
      Recency: 102
      Segment: Others Monetary Value: 759
      Recency: 30
      Segment: Champions Monetary Value: 677
      Recency: 582
      Segment: At Risk Monetary Value: 353
      Recency: 125
      Segment: Potential Loyalist Monetary Value: 248
      Recency: 34
      Segment: Potential Loyalist Monetary Value: 340
      Recency: 633
      Segment: At Risk Monetary Value: 143
      Recency: 165
      Segment: Potential Loyalist Monetary Value: 162
      Recency: 577
      Segment: Lost Monetary Value: 188
      Recency: 101
      Segment: Potential Loyalist Monetary Value: 631
      Recency: 498
      Segment: At Risk Monetary Value: 450
      Recency: 100
      Segment: Loyal Customers Monetary Value: 548
      Recency: 112
      Segment: Champions Monetary Value: 662
      Recency: 225
      Segment: Loyal Customers Monetary Value: 556
      Recency: 504
      Segment: At Risk Monetary Value: 542
      Recency: 408
      Segment: Loyal Customers Monetary Value: 357
      Recency: 164
      Segment: Others Monetary Value: 317
      Recency: 225
      Segment: Potential Loyalist Monetary Value: 260
      Recency: 150
      Segment: Potential Loyalist Monetary Value: 234
      Recency: 96
      Segment: Potential Loyalist Monetary Value: 885
      Recency: 172
      Segment: Champions Monetary Value: 471
      Recency: 132
      Segment: Loyal Customers Monetary Value: 236
      Recency: 171
      Segment: Potential Loyalist Monetary Value: 332
      Recency: 264
      Segment: Potential Loyalist Monetary Value: 95
      Recency: 516
      Segment: Lost Monetary Value: 900
      Recency: 198
      Segment: Loyal Customers Monetary Value: 665
      Recency: 132
      Segment: Champions Monetary Value: 266
      Recency: 399
      Segment: About To Sleep Monetary Value: 619
      Recency: 127
      Segment: Champions Monetary Value: 758
      Recency: 116
      Segment: Champions Monetary Value: 416
      Recency: 134
      Segment: Loyal Customers Monetary Value: 333
      Recency: 393
      Segment: Need Attention Monetary Value: 1004
      Recency: 186
      Segment: Loyal Customers Monetary Value: 236
      Recency: 136
      Segment: Potential Loyalist Monetary Value: 603
      Recency: 449
      Segment: Loyal Customers Monetary Value: 363
      Recency: 636
      Segment: At Risk Monetary Value: 734
      Recency: 21
      Segment: Loyal Customers Monetary Value: 119
      Recency: 187
      Segment: Potential Loyalist Monetary Value: 436
      Recency: 122
      Segment: Loyal Customers Monetary Value: 489
      Recency: 289
      Segment: Potential Loyalist Monetary Value: 264
      Recency: 331
      Segment: About To Sleep Monetary Value: 384
      Recency: 277
      Segment: Loyal Customers Monetary Value: 578
      Recency: 371
      Segment: Loyal Customers Monetary Value: 518
      Recency: 379
      Segment: Loyal Customers Monetary Value: 819
      Recency: 179
      Segment: Champions Monetary Value: 368
      Recency: 414
      Segment: At Risk Monetary Value: 672
      Recency: 213
      Segment: Loyal Customers Monetary Value: 386
      Recency: 431
      Segment: Others Monetary Value: 513
      Recency: 65
      Segment: Champions Monetary Value: 434
      Recency: 239
      Segment: Loyal Customers Monetary Value: 114
      Recency: 119
      Segment: Potential Loyalist Monetary Value: 102
      Recency: 516
      Segment: Lost Monetary Value: 708
      Recency: 133
      Segment: Loyal Customers Monetary Value: 499
      Recency: 486
      Segment: At Risk Monetary Value: 400
      Recency: 493
      Segment: At Risk Monetary Value: 840
      Recency: 410
      Segment: Loyal Customers Monetary Value: 496
      Recency: 421
      Segment: Loyal Customers Monetary Value: 300
      Recency: 545
      Segment: At Risk Monetary Value: 113
      Recency: 569
      Segment: Lost Monetary Value: 235
      Recency: 245
      Segment: Potential Loyalist Monetary Value: 1036
      Recency: 73
      Segment: Champions Monetary Value: 138
      Recency: 164
      Segment: Potential Loyalist Monetary Value: 267
      Recency: 613
      Segment: Lost Monetary Value: 175
      Recency: 444
      Segment: About To Sleep Monetary Value: 687
      Recency: 442
      Segment: Loyal Customers Monetary Value: 455
      Recency: 203
      Segment: Loyal Customers Monetary Value: 466
      Recency: 131
      Segment: Loyal Customers Monetary Value: 396
      Recency: 392
      Segment: Loyal Customers Monetary Value: 486
      Recency: 251
      Segment: Loyal Customers Monetary Value: 613
      Recency: 194
      Segment: Loyal Customers Monetary Value: 546
      Recency: 443
      Segment: Loyal Customers Monetary Value: 474
      Recency: 455
      Segment: Loyal Customers Monetary Value: 922
      Recency: 463
      Segment: Loyal Customers Monetary Value: 694
      Recency: 159
      Segment: Champions Monetary Value: 228
      Recency: 228
      Segment: Potential Loyalist Monetary Value: 1104
      Recency: 97
      Segment: Champions Monetary Value: 410
      Recency: 189
      Segment: Potential Loyalist Monetary Value: 521
      Recency: 491
      Segment: At Risk Monetary Value: 584
      Recency: 106
      Segment: Champions Monetary Value: 149
      Recency: 161
      Segment: Potential Loyalist Monetary Value: 880
      Recency: 160
      Segment: Champions Monetary Value: 719
      Recency: 356
      Segment: Loyal Customers Monetary Value: 473
      Recency: 182
      Segment: Potential Loyalist Monetary Value: 523
      Recency: 106
      Segment: Champions Monetary Value: 1060
      Recency: 160
      Segment: Champions Monetary Value: 415
      Recency: 105
      Segment: Loyal Customers Monetary Value: 434
      Recency: 280
      Segment: Loyal Customers Monetary Value: 87
      Recency: 375
      Segment: About To Sleep Monetary Value: 714
      Recency: 343
      Segment: Loyal Customers Monetary Value: 641
      Recency: 153
      Segment: Champions Monetary Value: 276
      Recency: 191
      Segment: Potential Loyalist Monetary Value: 249
      Recency: 241
      Segment: Potential Loyalist Monetary Value: 374
      Recency: 276
      Segment: Potential Loyalist Monetary Value: 374
      Recency: 66
      Segment: Potential Loyalist Monetary Value: 253
      Recency: 285
      Segment: Potential Loyalist Monetary Value: 203
      Recency: 488
      Segment: Lost Monetary Value: 75
      Recency: 360
      Segment: About To Sleep Monetary Value: 332
      Recency: 147
      Segment: Potential Loyalist Monetary Value: 421
      Recency: 102
      Segment: Potential Loyalist Monetary Value: 291
      Recency: 372
      Segment: Need Attention Monetary Value: 435
      Recency: 478
      Segment: Loyal Customers Monetary Value: 23
      Recency: 760
      Segment: Lost Monetary Value: 1090
      Recency: 53
      Segment: Champions Monetary Value: 403
      Recency: 512
      Segment: At Risk Monetary Value: 874
      Recency: 34
      Segment: Loyal Customers Monetary Value: 1062
      Recency: 41
      Segment: Champions Monetary Value: 570
      Recency: 539
      Segment: At Risk Monetary Value: 416
      Recency: 511
      Segment: At Risk Monetary Value: 771
      Recency: 81
      Segment: Champions Monetary Value: 326
      Recency: 235
      Segment: Potential Loyalist Monetary Value: 665
      Recency: 294
      Segment: Loyal Customers Monetary Value: 556
      Recency: 236
      Segment: Loyal Customers Monetary Value: 275
      Recency: 173
      Segment: Potential Loyalist Monetary Value: 286
      Recency: 179
      Segment: Potential Loyalist Monetary Value: 359
      Recency: 146
      Segment: Potential Loyalist Monetary Value: 547
      Recency: 6
      Segment: Champions Monetary Value: 488
      Recency: 50
      Segment: Loyal Customers Monetary Value: 888
      Recency: 116
      Segment: Champions Monetary Value: 392
      Recency: 422
      Segment: Loyal Customers Monetary Value: 506
      Recency: 135
      Segment: Champions Monetary Value: 764
      Recency: 113
      Segment: Champions Monetary Value: 714
      Recency: 29
      Segment: Champions Monetary Value: 438
      Recency: 352
      Segment: Loyal Customers Monetary Value: 450
      Recency: 88
      Segment: Loyal Customers Monetary Value: 653
      Recency: 281
      Segment: Loyal Customers Monetary Value: 366
      Recency: 589
      Segment: Lost Monetary Value: 268
      Recency: 391
      Segment: About To Sleep Monetary Value: 401
      Recency: 265
      Segment: Loyal Customers Monetary Value: 382
      Recency: 512
      Segment: At Risk Monetary Value: 552
      Recency: 67
      Segment: Others Monetary Value: 806
      Recency: 153
      Segment: Champions Monetary Value: 223
      Recency: 604
      Segment: Lost Monetary Value: 317
      Recency: 390
      Segment: About To Sleep Monetary Value: 479
      Recency: 101
      Segment: Loyal Customers Monetary Value: 436
      Recency: 455
      Segment: Need Attention Monetary Value: 101
      Recency: 272
      Segment: Potential Loyalist Monetary Value: 770
      Recency: 148
      Segment: Champions Monetary Value: 391
      Recency: 48
      Segment: Loyal Customers Monetary Value: 520
      Recency: 374
      Segment: At Risk Monetary Value: 663
      Recency: 449
      Segment: Loyal Customers Monetary Value: 243
      Recency: 200
      Segment: Potential Loyalist Monetary Value: 416
      Recency: 505
      Segment: At Risk Monetary Value: 552
      Recency: 662
      Segment: At Risk Monetary Value: 77
      Recency: 673
      Segment: Lost Monetary Value: 935
      Recency: 453
      Segment: Loyal Customers Monetary Value: 236
      Recency: 171
      Segment: Potential Loyalist Monetary Value: 314
      Recency: 190
      Segment: Potential Loyalist Monetary Value: 218
      Recency: 410
      Segment: About To Sleep Monetary Value: 987
      Recency: 127
      Segment: Champions Monetary Value: 529
      Recency: 429
      Segment: Others Monetary Value: 1027
      Recency: 169
      Segment: Champions Monetary Value: 613
      Recency: 144
      Segment: Champions Monetary Value: 751
      Recency: 129
      Segment: Champions Monetary Value: 274
      Recency: 336
      Segment: About To Sleep Monetary Value: 829
      Recency: 403
      Segment: Loyal Customers Monetary Value: 276
      Recency: 67
      Segment: Potential Loyalist Monetary Value: 229
      Recency: 249
      Segment: Potential Loyalist Monetary Value: 57
      Recency: 700
      Segment: Lost Monetary Value: 318
      Recency: 61
      Segment: Potential Loyalist Monetary Value: 554
      Recency: 398
      Segment: Loyal Customers Monetary Value: 353
      Recency: 449
      Segment: About To Sleep Monetary Value: 549
      Recency: 381
      Segment: Loyal Customers Monetary Value: 382
      Recency: 99
      Segment: Loyal Customers Monetary Value: 357
      Recency: 288
      Segment: Potential Loyalist Monetary Value: 566
      Recency: 407
      Segment: Loyal Customers Monetary Value: 698
      Recency: 297
      Segment: Loyal Customers Monetary Value: 774
      Recency: 136
      Segment: Champions Monetary Value: 653
      Recency: 246
      Segment: Loyal Customers Monetary Value: 532
      Recency: 57
      Segment: Champions Monetary Value: 536
      Recency: 142
      Segment: Champions Monetary Value: 646
      Recency: 481
      Segment: Loyal Customers Monetary Value: 537
      Recency: 86
      Segment: Loyal Customers Monetary Value: 473
      Recency: 48
      Segment: Potential Loyalist Monetary Value: 275
      Recency: 287
      Segment: Potential Loyalist Monetary Value: 712
      Recency: 137
      Segment: Champions Monetary Value: 347
      Recency: 8
      Segment: Potential Loyalist Monetary Value: 359
      Recency: 177
      Segment: Potential Loyalist Monetary Value: 630
      Recency: 182
      Segment: Loyal Customers Monetary Value: 872
      Recency: 575
      Segment: At Risk Monetary Value: 528
      Recency: 206
      Segment: Loyal Customers Monetary Value: 741
      Recency: 180
      Segment: Champions Monetary Value: 447
      Recency: 79
      Segment: Loyal Customers Monetary Value: 350
      Recency: 210
      Segment: Potential Loyalist Monetary Value: 347
      Recency: 190
      Segment: Potential Loyalist Monetary Value: 292
      Recency: 533
      Segment: Lost Monetary Value: 441
      Recency: 233
      Segment: Potential Loyalist Monetary Value: 1488
      Recency: 168
      Segment: Champions Monetary Value: 289
      Recency: 113
      Segment: Potential Loyalist Monetary Value: 332
      Recency: 92
      Segment: Potential Loyalist Monetary Value: 668
      Recency: 495
      Segment: At Risk Monetary Value: 260
      Recency: 478
      Segment: About To Sleep Monetary Value: 82
      Recency: 479
      Segment: About To Sleep Monetary Value: 781
      Recency: 171
      Segment: Champions Monetary Value: 155
      Recency: 695
      Segment: Lost Monetary Value: 479
      Recency: 681
      Segment: Others Monetary Value: 242
      Recency: 350
      Segment: About To Sleep Monetary Value: 251
      Recency: 90
      Segment: Potential Loyalist Monetary Value: 889
      Recency: 183
      Segment: Loyal Customers Monetary Value: 209
      Recency: 117
      Segment: Potential Loyalist Monetary Value: 259
      Recency: 334
      Segment: Need Attention Monetary Value: 520
      Recency: 502
      Segment: At Risk Monetary Value: 652
      Recency: 284
      Segment: Loyal Customers Monetary Value: 113
      Recency: 466
      Segment: About To Sleep Monetary Value: 196
      Recency: 352
      Segment: About To Sleep Monetary Value: 516
      Recency: 72
      Segment: Others Monetary Value: 1003
      Recency: 27
      Segment: Champions Monetary Value: 309
      Recency: 549
      Segment: At Risk Monetary Value: 585
      Recency: 372
      Segment: Loyal Customers Monetary Value: 356
      Recency: 112
      Segment: Others Monetary Value: 1074
      Recency: 124
      Segment: Champions Monetary Value: 437
      Recency: 469
      Segment: Loyal Customers Monetary Value: 775
      Recency: 63
      Segment: Champions Monetary Value: 724
      Recency: 195
      Segment: Loyal Customers Monetary Value: 601
      Recency: 146
      Segment: Others Monetary Value: 854
      Recency: 197
      Segment: Loyal Customers Monetary Value: 814
      Recency: 21
      Segment: Champions Monetary Value: 574
      Recency: 181
      Segment: Others Monetary Value: 230
      Recency: 172
      Segment: Potential Loyalist Monetary Value: 1008
      Recency: 311
      Segment: Loyal Customers Monetary Value: 632
      Recency: 426
      Segment: At Risk Monetary Value: 512
      Recency: 193
      Segment: Loyal Customers Monetary Value: 458
      Recency: 647
      Segment: At Risk Monetary Value: 621
      Recency: 431
      Segment: Loyal Customers Monetary Value: 375
      Recency: 359
      Segment: Need Attention Monetary Value: 515
      Recency: 307
      Segment: Loyal Customers Monetary Value: 157
      Recency: 77
      Segment: Potential Loyalist Monetary Value: 773
      Recency: 427
      Segment: Loyal Customers Monetary Value: 152
      Recency: 239
      Segment: Potential Loyalist Monetary Value: 536
      Recency: 175
      Segment: Champions Monetary Value: 688
      Recency: 161
      Segment: Champions Monetary Value: 655
      Recency: 399
      Segment: At Risk Monetary Value: 485
      Recency: 118
      Segment: Loyal Customers Monetary Value: 285
      Recency: 94
      Segment: Potential Loyalist Monetary Value: 358
      Recency: 202
      Segment: Others Monetary Value: 589
      Recency: 473
      Segment: Loyal Customers Monetary Value: 96
      Recency: 588
      Segment: Lost Monetary Value: 1011
      Recency: 148
      Segment: Champions Monetary Value: 424
      Recency: 106
      Segment: Loyal Customers Monetary Value: 306
      Recency: 446
      Segment: Need Attention Monetary Value: 648
      Recency: 494
      Segment: At Risk Monetary Value: 61
      Recency: 955
      Segment: Lost Monetary Value: 111
      Recency: 200
      Segment: Potential Loyalist Monetary Value: 133
      Recency: 976
      Segment: Lost Monetary Value: 730
      Recency: 312
      Segment: Loyal Customers Monetary Value: 479
      Recency: 97
      Segment: Loyal Customers Monetary Value: 340
      Recency: 105
      Segment: Potential Loyalist Monetary Value: 492
      Recency: 417
      Segment: Loyal Customers Monetary Value: 139
      Recency: 436
      Segment: About To Sleep Monetary Value: 284
      Recency: 509
      Segment: Lost Monetary Value: 166
      Recency: 632
      Segment: Lost Monetary Value: 94
      Recency: 578
      Segment: Lost Monetary Value: 28
      Recency: 568
      Segment: Lost Monetary Value: 413
      Recency: 295
      Segment: Potential Loyalist Monetary Value: 782
      Recency: 45
      Segment: Champions Monetary Value: 708
      Recency: 82
      Segment: Champions Monetary Value: 788
      Recency: 186
      Segment: Loyal Customers Monetary Value: 79
      Recency: 651
      Segment: Lost Monetary Value: 237
      Recency: 84
      Segment: Potential Loyalist Monetary Value: 437
      Recency: 472
      Segment: Loyal Customers Monetary Value: 711
      Recency: 48
      Segment: Champions Monetary Value: 420
      Recency: 151
      Segment: Loyal Customers Monetary Value: 348
      Recency: 103
      Segment: Potential Loyalist Monetary Value: 311
      Recency: 471
      Segment: About To Sleep Monetary Value: 560
      Recency: 151
      Segment: Champions Monetary Value: 128
      Recency: 229
      Segment: Potential Loyalist Monetary Value: 289
      Recency: 309
      Segment: Need Attention Monetary Value: 587
      Recency: 101
      Segment: Champions Monetary Value: 265
      Recency: 116
      Segment: Potential Loyalist Monetary Value: 371
      Recency: 304
      Segment: Need Attention Monetary Value: 482
      Recency: 412
      Segment: Need Attention Monetary Value: 716
      Recency: 299
      Segment: Loyal Customers Monetary Value: 505
      Recency: 333
      Segment: Need Attention Monetary Value: 582
      Recency: 279
      Segment: Loyal Customers Monetary Value: 713
      Recency: 116
      Segment: Champions Monetary Value: 639
      Recency: 68
      Segment: Loyal Customers Monetary Value: 575
      Recency: 270
      Segment: Loyal Customers Monetary Value: 1050
      Recency: 384
      Segment: Loyal Customers Monetary Value: 114
      Recency: 476
      Segment: About To Sleep Monetary Value: 583
      Recency: 164
      Segment: Champions Monetary Value: 438
      Recency: 43
      Segment: Potential Loyalist Monetary Value: 446
      Recency: 122
      Segment: Potential Loyalist Monetary Value: 388
      Recency: 231
      Segment: Potential Loyalist Monetary Value: 475
      Recency: 583
      Segment: At Risk Monetary Value: 965
      Recency: 85
      Segment: Champions Monetary Value: 249
      Recency: 168
      Segment: Potential Loyalist Monetary Value: 673
      Recency: 443
      Segment: Loyal Customers Monetary Value: 258
      Recency: 107
      Segment: Potential Loyalist Monetary Value: 184
      Recency: 533
      Segment: Lost Monetary Value: 166
      Recency: 507
      Segment: Lost Monetary Value: 386
      Recency: 410
      Segment: Need Attention Monetary Value: 252
      Recency: 497
      Segment: Lost Monetary Value: 209
      Recency: 93
      Segment: Potential Loyalist Monetary Value: 546
      Recency: 86
      Segment: Champions Monetary Value: 565
      Recency: 140
      Segment: Loyal Customers Monetary Value: 431
      Recency: 9
      Segment: Potential Loyalist Monetary Value: 350
      Recency: 275
      Segment: Potential Loyalist Monetary Value: 33
      Recency: 399
      Segment: About To Sleep Monetary Value: 513
      Recency: 372
      Segment: Others Monetary Value: 640
      Recency: 465
      Segment: Loyal Customers Monetary Value: 927
      Recency: 126
      Segment: Champions Monetary Value: 401
      Recency: 162
      Segment: Potential Loyalist Monetary Value: 464
      Recency: 4
      Segment: Loyal Customers Monetary Value: 52
      Recency: 446
      Segment: About To Sleep Monetary Value: 494
      Recency: 48
      Segment: Loyal Customers Monetary Value: 363
      Recency: 98
      Segment: Potential Loyalist Monetary Value: 345
      Recency: 220
      Segment: Potential Loyalist Monetary Value: 649
      Recency: 127
      Segment: Others Monetary Value: 265
      Recency: 114
      Segment: Potential Loyalist Monetary Value: 540
      Recency: 400
      Segment: Loyal Customers Monetary Value: 693
      Recency: 120
      Segment: Champions Monetary Value: 637
      Recency: 93
      Segment: Champions Monetary Value: 554
      Recency: 230
      Segment: Loyal Customers Monetary Value: 180
      Recency: 90
      Segment: Potential Loyalist Monetary Value: 799
      Recency: 569
      Segment: At Risk Monetary Value: 490
      Recency: 149
      Segment: Loyal Customers Monetary Value: 409
      Recency: 377
      Segment: Loyal Customers Monetary Value: 347
      Recency: 354
      Segment: Need Attention Monetary Value: 356
      Recency: 553
      Segment: Lost Monetary Value: 239
      Recency: 6
      Segment: Potential Loyalist Monetary Value: 270
      Recency: 469
      Segment: About To Sleep Monetary Value: 736
      Recency: 242
      Segment: Loyal Customers Monetary Value: 311
      Recency: 93
      Segment: Potential Loyalist Monetary Value: 422
      Recency: 110
      Segment: Potential Loyalist Monetary Value: 277
      Recency: 720
      Segment: Lost Monetary Value: 434
      Recency: 266
      Segment: Loyal Customers Monetary Value: 371
      Recency: 509
      Segment: At Risk Monetary Value: 181
      Recency: 113
      Segment: Potential Loyalist Monetary Value: 283
      Recency: 99
      Segment: Potential Loyalist Monetary Value: 350
      Recency: 416
      Segment: Need Attention Monetary Value: 12
      Recency: 681
      Segment: Lost Monetary Value: 260
      Recency: 173
      Segment: Potential Loyalist Monetary Value: 673
      Recency: 73
      Segment: Champions Monetary Value: 523
      Recency: 142
      Segment: Others Monetary Value: 185
      Recency: 699
      Segment: Lost Monetary Value: 463
      Recency: 222
      Segment: Loyal Customers Monetary Value: 294
      Recency: 723
      Segment: Lost Monetary Value: 464
      Recency: 179
      Segment: Potential Loyalist Monetary Value: 834
      Recency: 32
      Segment: Champions Monetary Value: 390
      Recency: 463
      Segment: Loyal Customers Monetary Value: 548
      Recency: 136
      Segment: Loyal Customers Monetary Value: 740
      Recency: 430
      Segment: Loyal Customers Monetary Value: 654
      Recency: 279
      Segment: Loyal Customers Monetary Value: 316
      Recency: 16
      Segment: Potential Loyalist Monetary Value: 23
      Recency: 186
      Segment: Potential Loyalist Monetary Value: 323
      Recency: 526
      Segment: At Risk Monetary Value: 620
      Recency: 486
      Segment: At Risk Monetary Value: 643
      Recency: 75
      Segment: Others Monetary Value: 404
      Recency: 468
      Segment: Need Attention Monetary Value: 303
      Recency: 103
      Segment: Others Monetary Value: 292
      Recency: 119
      Segment: Potential Loyalist Monetary Value: 188
      Recency: 375
      Segment: About To Sleep Monetary Value: 176
      Recency: 522
      Segment: Lost Monetary Value: 600
      Recency: 201
      Segment: Loyal Customers Monetary Value: 360
      Recency: 532
      Segment: At Risk Monetary Value: 261
      Recency: 125
      Segment: Potential Loyalist Monetary Value: 258
      Recency: 409
      Segment: About To Sleep Monetary Value: 417
      Recency: 37
      Segment: Loyal Customers Monetary Value: 233
      Recency: 178
      Segment: Potential Loyalist Monetary Value: 936
      Recency: 135
      Segment: Champions Monetary Value: 646
      Recency: 145
      Segment: Loyal Customers Monetary Value: 826
      Recency: 491
      Segment: At Risk Monetary Value: 453
      Recency: 276
      Segment: Loyal Customers Monetary Value: 187
      Recency: 485
      Segment: Lost Monetary Value: 937
      Recency: 335
      Segment: Loyal Customers Monetary Value: 423
      Recency: 132
      Segment: Potential Loyalist Monetary Value: 576
      Recency: 114
      Segment: Champions Monetary Value: 613
      Recency: 150
      Segment: Loyal Customers Monetary Value: 79
      Recency: 143
      Segment: Potential Loyalist Monetary Value: 681
      Recency: 525
      Segment: At Risk Monetary Value: 343
      Recency: 636
      Segment: Lost Monetary Value: 248
      Recency: 441
      Segment: About To Sleep Monetary Value: 457
      Recency: 208
      Segment: Loyal Customers Monetary Value: 111
      Recency: 534
      Segment: Lost Monetary Value: 219
      Recency: 607
      Segment: Lost Monetary Value: 425
      Recency: 574
      Segment: At Risk Monetary Value: 694
      Recency: 86
      Segment: Champions Monetary Value: 569
      Recency: 616
      Segment: At Risk Monetary Value: 579
      Recency: 63
      Segment: Loyal Customers Monetary Value: 462
      Recency: 140
      Segment: Potential Loyalist Monetary Value: 212
      Recency: 192
      Segment: Potential Loyalist Monetary Value: 268
      Recency: 264
      Segment: Potential Loyalist Monetary Value: 644
      Recency: 380
      Segment: Loyal Customers Monetary Value: 353
      Recency: 597
      Segment: At Risk Monetary Value: 597
      Recency: 475
      Segment: At Risk Monetary Value: 815
      Recency: 298
      Segment: Loyal Customers Monetary Value: 211
      Recency: 550
      Segment: Lost Monetary Value: 585
      Recency: 488
      Segment: At Risk Monetary Value: 641
      Recency: 586
      Segment: At Risk Monetary Value: 353
      Recency: 484
      Segment: Lost Monetary Value: 132
      Recency: 442
      Segment: About To Sleep Monetary Value: 512
      Recency: 150
      Segment: Loyal Customers Monetary Value: 143
      Recency: 191
      Segment: Potential Loyalist Monetary Value: 39
      Recency: 520
      Segment: Lost Monetary Value: 163
      Recency: 214
      Segment: Potential Loyalist Monetary Value: 632
      Recency: 402
      Segment: Loyal Customers Monetary Value: 453
      Recency: 88
      Segment: Loyal Customers Monetary Value: 220
      Recency: 519
      Segment: Lost Monetary Value: 777
      Recency: 258
      Segment: Loyal Customers Monetary Value: 622
      Recency: 281
      Segment: Loyal Customers Monetary Value: 480
      Recency: 182
      Segment: Loyal Customers Monetary Value: 955
      Recency: 153
      Segment: Champions Monetary Value: 147
      Recency: 215
      Segment: Potential Loyalist Monetary Value: 600
      Recency: 44
      Segment: Champions Monetary Value: 242
      Recency: 244
      Segment: Potential Loyalist Monetary Value: 172
      Recency: 123
      Segment: Potential Loyalist Monetary Value: 394
      Recency: 88
      Segment: Loyal Customers Monetary Value: 476
      Recency: 852
      Segment: At Risk Monetary Value: 306
      Recency: 162
      Segment: Potential Loyalist Monetary Value: 644
      Recency: 249
      Segment: Loyal Customers Monetary Value: 625
      Recency: 462
      Segment: Loyal Customers Monetary Value: 308
      Recency: 487
      Segment: Lost Monetary Value: 219
      Recency: 892
      Segment: Lost Monetary Value: 466
      Recency: 296
      Segment: Potential Loyalist Monetary Value: 536
      Recency: 446
      Segment: Loyal Customers Monetary Value: 620
      Recency: 98
      Segment: Champions Monetary Value: 406
      Recency: 427
      Segment: Loyal Customers Monetary Value: 108
      Recency: 296
      Segment: Potential Loyalist Monetary Value: 241
      Recency: 490
      Segment: Lost Monetary Value: 89
      Recency: 604
      Segment: Lost Monetary Value: 664
      Recency: 433
      Segment: Loyal Customers Monetary Value: 335
      Recency: 174
      Segment: Potential Loyalist Monetary Value: 185
      Recency: 210
      Segment: Potential Loyalist Monetary Value: 82
      Recency: 618
      Segment: Lost Monetary Value: 225
      Recency: 449
      Segment: About To Sleep Monetary Value: 265
      Recency: 601
      Segment: Lost Monetary Value: 1089
      Recency: 319
      Segment: Loyal Customers Monetary Value: 515
      Recency: 496
      Segment: At Risk Monetary Value: 762
      Recency: 49
      Segment: Champions Monetary Value: 1060
      Recency: 183
      Segment: Loyal Customers Monetary Value: 300
      Recency: 182
      Segment: Potential Loyalist Monetary Value: 137
      Recency: 411
      Segment: About To Sleep Monetary Value: 55
      Recency: 597
      Segment: Lost Monetary Value: 580
      Recency: 88
      Segment: Champions Monetary Value: 960
      Recency: 64
      Segment: Champions Monetary Value: 421
      Recency: 550
      Segment: Others Monetary Value: 182
      Recency: 124
      Segment: Potential Loyalist Monetary Value: 809
      Recency: 454
      Segment: Loyal Customers Monetary Value: 672
      Recency: 78
      Segment: Loyal Customers Monetary Value: 816
      Recency: 144
      Segment: Champions Monetary Value: 489
      Recency: 561
      Segment: At Risk Monetary Value: 587
      Recency: 538
      Segment: At Risk Monetary Value: 960
      Recency: 35
      Segment: Champions Monetary Value: 956
      Recency: 129
      Segment: Champions Monetary Value: 413
      Recency: 455
      Segment: Loyal Customers Monetary Value: 360
      Recency: 234
      Segment: Potential Loyalist Monetary Value: 355
      Recency: 515
      Segment: Lost Monetary Value: 570
      Recency: 196
      Segment: Loyal Customers Monetary Value: 358
      Recency: 681
      Segment: Lost Monetary Value: 210
      Recency: 535
      Segment: Lost Monetary Value: 319
      Recency: 71
      Segment: Others Monetary Value: 581
      Recency: 43
      Segment: Champions Monetary Value: 446
      Recency: 171
      Segment: Potential Loyalist Monetary Value: 34
      Recency: 624
      Segment: Lost Monetary Value: 381
      Recency: 366
      Segment: Need Attention Monetary Value: 317
      Recency: 135
      Segment: Potential Loyalist Monetary Value: 254
      Recency: 243
      Segment: Potential Loyalist Monetary Value: 652
      Recency: 204
      Segment: Loyal Customers Monetary Value: 468
      Recency: 663
      Segment: At Risk Monetary Value: 820
      Recency: 502
      Segment: At Risk Monetary Value: 409
      Recency: 564
      Segment: At Risk Monetary Value: 467
      Recency: 600
      Segment: Others Monetary Value: 197
      Recency: 229
      Segment: Potential Loyalist Monetary Value: 420
      Recency: 490
      Segment: At Risk Monetary Value: 405
      Recency: 232
      Segment: Loyal Customers Monetary Value: 312
      Recency: 276
      Segment: Potential Loyalist Monetary Value: 622
      Recency: 145
      Segment: Champions Monetary Value: 496
      Recency: 289
      Segment: Potential Loyalist Monetary Value: 365
      Recency: 128
      Segment: Potential Loyalist Monetary Value: 434
      Recency: 146
      Segment: Potential Loyalist Monetary Value: 597
      Recency: 67
      Segment: Champions Monetary Value: 512
      Recency: 417
      Segment: Loyal Customers Monetary Value: 400
      Recency: 69
      Segment: Potential Loyalist Monetary Value: 447
      Recency: 139
      Segment: Loyal Customers Monetary Value: 652
      Recency: 339
      Segment: Loyal Customers Monetary Value: 436
      Recency: 176
      Segment: Loyal Customers Monetary Value: 265
      Recency: 614
      Segment: Lost Monetary Value: 805
      Recency: 373
      Segment: Loyal Customers Monetary Value: 665
      Recency: 436
      Segment: Loyal Customers Monetary Value: 541
      Recency: 151
      Segment: Others Monetary Value: 558
      Recency: 190
      Segment: Loyal Customers Monetary Value: 826
      Recency: 430
      Segment: Loyal Customers Monetary Value: 732
      Recency: 152
      Segment: Champions Monetary Value: 390
      Recency: 131
      Segment: Potential Loyalist Monetary Value: 462
      Recency: 305
      Segment: Need Attention Monetary Value: 534
      Recency: 263
      Segment: Loyal Customers Monetary Value: 1118
      Recency: 84
      Segment: Champions Monetary Value: 658
      Recency: 160
      Segment: Champions Monetary Value: 538
      Recency: 275
      Segment: Others Monetary Value: 459
      Recency: 178
      Segment: Potential Loyalist Monetary Value: 806
      Recency: 31
      Segment: Champions Monetary Value: 438
      Recency: 75
      Segment: Loyal Customers Monetary Value: 424
      Recency: 157
      Segment: Loyal Customers Monetary Value: 997
      Recency: 188
      Segment: Loyal Customers Monetary Value: 308
      Recency: 148
      Segment: Potential Loyalist Monetary Value: 388
      Recency: 724
      Segment: At Risk Monetary Value: 665
      Recency: 426
      Segment: Loyal Customers Monetary Value: 292
      Recency: 155
      Segment: Others Monetary Value: 427
      Recency: 180
      Segment: Potential Loyalist Monetary Value: 420
      Recency: 166
      Segment: Loyal Customers Monetary Value: 588
      Recency: 176
      Segment: Champions Monetary Value: 760
      Recency: 201
      Segment: Loyal Customers Monetary Value: 384
      Recency: 591
      Segment: Others Monetary Value: 867
      Recency: 153
      Segment: Champions Monetary Value: 654
      Recency: 172
      Segment: Champions Monetary Value: 726
      Recency: 19
      Segment: Champions Monetary Value: 326
      Recency: 201
      Segment: Potential Loyalist Monetary Value: 377
      Recency: 90
      Segment: Potential Loyalist Monetary Value: 450
      Recency: 276
      Segment: Loyal Customers Monetary Value: 363
      Recency: 630
      Segment: At Risk Monetary Value: 688
      Recency: 210
      Segment: Loyal Customers Monetary Value: 329
      Recency: 140
      Segment: Potential Loyalist Monetary Value: 255
      Recency: 282
      Segment: Potential Loyalist Monetary Value: 472
      Recency: 102
      Segment: Loyal Customers Monetary Value: 88
      Recency: 508
      Segment: Lost Monetary Value: 1018
      Recency: 190
      Segment: Loyal Customers Monetary Value: 362
      Recency: 250
      Segment: Others Monetary Value: 1061
      Recency: 103
      Segment: Champions Monetary Value: 295
      Recency: 506
      Segment: Lost Monetary Value: 590
      Recency: 128
      Segment: Champions Monetary Value: 228
      Recency: 171
      Segment: Potential Loyalist Monetary Value: 520
      Recency: 186
      Segment: Loyal Customers Monetary Value: 609
      Recency: 105
      Segment: Others Monetary Value: 237
      Recency: 500
      Segment: Lost Monetary Value: 754
      Recency: 33
      Segment: Champions Monetary Value: 353
      Recency: 288
      Segment: Others Monetary Value: 427
      Recency: 291
      Segment: Loyal Customers Monetary Value: 395
      Recency: 335
      Segment: Need Attention Monetary Value: 642
      Recency: 191
      Segment: Loyal Customers Monetary Value: 778
      Recency: 178
      Segment: Champions Monetary Value: 449
      Recency: 207
      Segment: Potential Loyalist Monetary Value: 471
      Recency: 40
      Segment: Loyal Customers Monetary Value: 1184
      Recency: 206
      Segment: Loyal Customers Monetary Value: 293
      Recency: 227
      Segment: Potential Loyalist Monetary Value: 694
      Recency: 443
      Segment: Loyal Customers Monetary Value: 103
      Recency: 576
      Segment: Lost Monetary Value: 839
      Recency: 138
      Segment: Champions Monetary Value: 627
      Recency: 11
      Segment: Champions Monetary Value: 510
      Recency: 585
      Segment: At Risk Monetary Value: 394
      Recency: 516
      Segment: Others Monetary Value: 393
      Recency: 103
      Segment: Potential Loyalist Monetary Value: 643
      Recency: 261
      Segment: Loyal Customers Monetary Value: 378
      Recency: 295
      Segment: Potential Loyalist Monetary Value: 199
      Recency: 177
      Segment: Potential Loyalist Monetary Value: 324
      Recency: 546
      Segment: Lost Monetary Value: 702
      Recency: 484
      Segment: At Risk Monetary Value: 480
      Recency: 282
      Segment: Loyal Customers Monetary Value: 446
      Recency: 15
      Segment: Loyal Customers Monetary Value: 274
      Recency: 38
      Segment: Potential Loyalist Monetary Value: 522
      Recency: 149
      Segment: Champions Monetary Value: 952
      Recency: 128
      Segment: Champions Monetary Value: 96
      Recency: 545
      Segment: Lost Monetary Value: 709
      Recency: 164
      Segment: Champions Monetary Value: 159
      Recency: 229
      Segment: Potential Loyalist Monetary Value: 870
      Recency: 344
      Segment: Loyal Customers Monetary Value: 433
      Recency: 209
      Segment: Loyal Customers Monetary Value: 542
      Recency: 249
      Segment: Loyal Customers Monetary Value: 558
      Recency: 212
      Segment: Loyal Customers Monetary Value: 121
      Recency: 129
      Segment: Potential Loyalist Monetary Value: 377
      Recency: 54
      Segment: Potential Loyalist Monetary Value: 195
      Recency: 107
      Segment: Potential Loyalist Monetary Value: 650
      Recency: 135
      Segment: Champions Monetary Value: 253
      Recency: 530
      Segment: Lost Monetary Value: 713
      Recency: 45
      Segment: Champions Monetary Value: 504
      Recency: 404
      Segment: Need Attention Monetary Value: 264
      Recency: 198
      Segment: Potential Loyalist Monetary Value: 446
      Recency: 291
      Segment: Loyal Customers Monetary Value: 366
      Recency: 332
      Segment: Need Attention Monetary Value: 474
      Recency: 89
      Segment: Loyal Customers Monetary Value: 547
      Recency: 387
      Segment: Loyal Customers Monetary Value: 855
      Recency: 472
      Segment: Loyal Customers Monetary Value: 690
      Recency: 210
      Segment: Loyal Customers Monetary Value: 208
      Recency: 573
      Segment: Lost Monetary Value: 195
      Recency: 653
      Segment: Lost Monetary Value: 567
      Recency: 542
      Segment: At Risk Monetary Value: 380
      Recency: 122
      Segment: Potential Loyalist Monetary Value: 369
      Recency: 328
      Segment: Need Attention Monetary Value: 1068
      Recency: 81
      Segment: Champions Monetary Value: 421
      Recency: 155
      Segment: Loyal Customers Monetary Value: 823
      Recency: 397
      Segment: Loyal Customers Monetary Value: 473
      Recency: 151
      Segment: Loyal Customers Monetary Value: 224
      Recency: 464
      Segment: About To Sleep Monetary Value: 219
      Recency: 484
      Segment: Lost Monetary Value: 359
      Recency: 240
      Segment: Potential Loyalist Monetary Value: 491
      Recency: 389
      Segment: Need Attention Monetary Value: 789
      Recency: 106
      Segment: Loyal Customers Monetary Value: 153
      Recency: 236
      Segment: Potential Loyalist Monetary Value: 422
      Recency: 159
      Segment: Loyal Customers Monetary Value: 492
      Recency: 539
      Segment: At Risk Monetary Value: 850
      Recency: 64
      Segment: Champions Monetary Value: 492
      Recency: 102
      Segment: Loyal Customers Monetary Value: 569
      Recency: 52
      Segment: Others Monetary Value: 454
      Recency: 490
      Segment: At Risk Monetary Value: 565
      Recency: 246
      Segment: Others Monetary Value: 675
      Recency: 173
      Segment: Loyal Customers Monetary Value: 461
      Recency: 13
      Segment: Loyal Customers Monetary Value: 574
      Recency: 416
      Segment: Loyal Customers Monetary Value: 676
      Recency: 109
      Segment: Champions Monetary Value: 390
      Recency: 517
      Segment: Others Monetary Value: 350
      Recency: 402
      Segment: Need Attention Monetary Value: 297
      Recency: 515
      Segment: Lost Monetary Value: 859
      Recency: 267
      Segment: Loyal Customers Monetary Value: 419
      Recency: 181
      Segment: Loyal Customers Monetary Value: 310
      Recency: 290
      Segment: Potential Loyalist Monetary Value: 1038
      Recency: 129
      Segment: Champions Monetary Value: 52
      Recency: 127
      Segment: Potential Loyalist Monetary Value: 39
      Recency: 265
      Segment: Potential Loyalist Monetary Value: 798
      Recency: 87
      Segment: Champions Monetary Value: 560
      Recency: 490
      Segment: At Risk Monetary Value: 594
      Recency: 169
      Segment: Champions Monetary Value: 332
      Recency: 477
      Segment: About To Sleep Monetary Value: 244
      Recency: 836
      Segment: Lost Monetary Value: 570
      Recency: 321
      Segment: Loyal Customers Monetary Value: 754
      Recency: 157
      Segment: Champions Monetary Value: 665
      Recency: 42
      Segment: Champions Monetary Value: 618
      Recency: 180
      Segment: Loyal Customers Monetary Value: 459
      Recency: 452
      Segment: Loyal Customers Monetary Value: 280
      Recency: 287
      Segment: Potential Loyalist Monetary Value: 277
      Recency: 395
      Segment: Need Attention Monetary Value: 515
      Recency: 152
      Segment: Others Monetary Value: 91
      Recency: 582
      Segment: Lost Monetary Value: 716
      Recency: 549
      Segment: At Risk Monetary Value: 236
      Recency: 163
      Segment: Potential Loyalist Monetary Value: 378
      Recency: 120
      Segment: Others Monetary Value: 760
      Recency: 346
      Segment: Loyal Customers Monetary Value: 490
      Recency: 341
      Segment: Need Attention Monetary Value: 406
      Recency: 387
      Segment: Loyal Customers Monetary Value: 615
      Recency: 43
      Segment: Champions Monetary Value: 574
      Recency: 204
      Segment: Loyal Customers Monetary Value: 1196
      Recency: 207
      Segment: Loyal Customers Monetary Value: 442
      Recency: 405
      Segment: Need Attention Monetary Value: 38
      Recency: 524
      Segment: Lost Monetary Value: 516
      Recency: 548
      Segment: At Risk Monetary Value: 375
      Recency: 224
      Segment: Potential Loyalist

# interactive median plot

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 116 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 246 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot sorted

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 116 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 246 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot sorted ascending

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 116 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 246 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot flipped

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 116 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 246 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot flipped sorted

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 116 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 246 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

# interactive median plot flipped sorted ascending

    Code
      cat(p$x$attrs[[1]]$hovertext)
    Output
      Segment: Champions 
      Median Recency: 116 Segment: Potential Loyalist 
      Median Recency: 162 Segment: Others 
      Median Recency: 184 Segment: Loyal Customers 
      Median Recency: 246 Segment: Need Attention 
      Median Recency: 389 Segment: About To Sleep 
      Median Recency: 410.5 Segment: At Risk 
      Median Recency: 526.5 Segment: Lost 
      Median Recency: 578

