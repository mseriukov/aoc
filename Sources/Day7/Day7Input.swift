extension Day7 {
    public var firstHalf: TestData? {
        .init(
            input: """
            32T3K 765
            T55J5 684
            KK677 28
            KTJJT 220
            QQQJA 483
            """,
            output: "6440"
        )
    }

    public var secondHalf: TestData? {
        .init(
            input: """
            32T3K 765
            T55J5 684
            KK677 28
            KTJJT 220
            QQQJA 483
            """,
            output: "5905"
        )
    }

    public var realInput: String { """
    88788 501
    99929 849
    J8787 166
    878T7 667
    2J957 35
    AQAA2 997
    T6QQ5 151
    84TJ9 142
    AT938 566
    A4AK7 297
    3J383 85
    T66TT 408
    49J94 377
    4AA4A 50
    AA2K6 678
    77758 586
    A6J27 681
    88TTT 554
    JKQ26 346
    8793J 304
    8A53A 691
    J6792 412
    47QT6 21
    65JQ5 633
    Q2K5T 623
    53353 985
    AA792 205
    52552 311
    K6KKK 545
    Q74Q4 756
    KKK65 632
    K6TTT 159
    QTTQT 570
    T6974 416
    KA396 772
    22A22 833
    73629 293
    3K33J 884
    767Q6 334
    A88J8 613
    28789 560
    6JT83 247
    72629 659
    A7J2K 456
    K4879 197
    QK76J 720
    TJ923 747
    J6664 706
    4QTQQ 649
    9K476 815
    J7A77 505
    8KK87 893
    Q6576 718
    6T6T2 529
    Q39A9 426
    J55A2 208
    75444 96
    8J6KJ 787
    J244K 775
    467J5 646
    6KJ37 53
    Q27T3 515
    3QAJK 936
    AA99A 195
    45664 328
    68456 376
    56J34 557
    9T22Q 628
    679KK 844
    78Q2J 824
    3Q449 877
    8TT82 565
    4J596 255
    AQ853 981
    445KK 79
    3KT85 589
    6Q2A7 993
    AJA44 179
    TJ925 17
    626JT 309
    89273 471
    J99A3 495
    7Q945 805
    T5JK4 193
    TJ4J6 752
    T63JQ 898
    827KA 414
    T686K 427
    55QT3 891
    K48AA 630
    2T777 146
    TKTTK 133
    T68T8 229
    55255 955
    3642A 669
    AJJQT 921
    98AA9 647
    Q32Q2 1000
    44T4T 851
    8J448 145
    3333Q 935
    25225 338
    K484K 33
    Q88T2 530
    8QA9Q 281
    22864 384
    4Q5QT 757
    7T3QT 863
    3TA87 769
    88686 612
    TK2KK 880
    TTT82 415
    77Q77 232
    JQ3T5 653
    858Q4 749
    J9K54 896
    7JAT4 928
    22452 176
    3J725 522
    694K6 721
    8Q88Q 521
    TATAA 181
    6J8TQ 693
    J54A8 122
    73J85 13
    9984T 90
    444J4 173
    99T97 907
    35333 134
    2A3Q5 852
    KK77K 806
    JJ895 937
    37839 161
    596TK 797
    77T77 244
    44774 452
    7K557 28
    33JTT 171
    45JT2 878
    9AKK2 268
    9675K 483
    77TJ7 274
    55Q55 964
    Q6666 390
    9AT7T 931
    KT829 716
    AJ477 624
    3JQ33 661
    667Q6 464
    47J44 6
    J4A95 486
    T9QK3 525
    7A76A 767
    749Q9 109
    77QJA 742
    K534A 779
    Q88T8 451
    T3A9K 808
    A7AA6 513
    6JAT7 150
    6K88Q 314
    444JT 829
    5QJJ5 618
    6TT66 534
    6656A 57
    65646 446
    Q666Q 40
    KQ2A2 140
    A777A 675
    TT777 830
    T2T5T 831
    9A799 116
    AJJKA 130
    53626 201
    J44J4 126
    J58QT 778
    2K22K 580
    K5KKJ 803
    K6384 717
    484Q7 604
    Q9QTQ 186
    8KJ69 916
    323A4 726
    77K7K 248
    Q4987 335
    4J87T 302
    J7557 599
    KKK4J 294
    A59KJ 729
    JQQ65 228
    TT5QT 113
    J799Q 49
    28833 454
    45J4A 502
    3TTT3 924
    75557 700
    6565A 398
    2J442 307
    2J2J2 654
    3AQAA 282
    5Q282 178
    822J2 811
    4T9T9 453
    377Q7 357
    5TJ4Q 719
    7K4KA 894
    6T5TT 922
    7QJ6Q 114
    TQ38K 885
    83A33 322
    Q7J72 999
    8A8AA 503
    328KJ 342
    9K3A4 587
    834A8 249
    QQK5Q 231
    29929 391
    8QJAQ 860
    92QK6 705
    Q88Q9 367
    22422 284
    KK96K 762
    T47QQ 643
    9K622 217
    4KJ6Q 976
    49494 547
    T333T 405
    57675 528
    9A88T 845
    A4T85 303
    66677 239
    763Q7 639
    KKKJ7 601
    5K5KK 206
    66222 257
    TAKTK 504
    36636 24
    89998 655
    KJKJ5 713
    QT2QQ 804
    T6666 419
    Q3KJT 564
    K3K38 542
    2K2A2 288
    4A584 437
    JJ4J7 932
    7395J 792
    J89T5 343
    K89K6 711
    96696 685
    T9455 362
    25257 238
    6Q9J6 992
    QA239 765
    63736 477
    83467 933
    562A8 994
    42284 187
    J9333 491
    K442K 3
    KJ6Q5 78
    Q277K 220
    55528 20
    8J888 318
    4Q34Q 807
    58J3J 18
    686A6 332
    5JJ25 365
    47QA4 251
    64J4K 433
    KA5QK 900
    9QQT9 36
    77577 861
    KJ6A2 301
    J5AA5 286
    K9T6Q 172
    33737 540
    95955 732
    22233 665
    2Q435 500
    7A757 354
    QJ375 743
    64TKK 345
    7J486 295
    5Q5QQ 682
    K5655 163
    J56J5 112
    229J7 709
    69436 22
    38839 460
    T66J6 194
    Q2999 211
    6J474 15
    33444 511
    35A54 189
    72TT6 773
    7A7JK 984
    2635T 230
    TQ855 129
    6K633 489
    7K458 862
    299J2 783
    22322 316
    996T2 326
    5TK7J 188
    KTTTT 11
    488J8 174
    68475 904
    9KK99 399
    4447T 431
    T9AAA 541
    4A977 131
    59359 66
    59QQ9 463
    5T293 493
    32323 736
    J553Q 440
    A2555 266
    4AAAA 68
    A3AKA 780
    3444T 37
    TQ77T 744
    6J655 687
    99AQ2 551
    TKATA 679
    8K4J6 879
    3K8KJ 333
    3Q3AJ 226
    T67KQ 535
    K236J 866
    63336 934
    648A5 484
    4TT4T 911
    98K56 117
    349QT 696
    985T4 867
    9T339 402
    88A8A 938
    3J3J3 38
    26752 177
    JA668 29
    KKAA7 263
    AJAJ3 674
    7A87T 141
    K3J3A 558
    3888J 199
    6242K 989
    3JAQQ 946
    AA7KJ 43
    JT623 550
    QJQ4Q 372
    99JJJ 386
    83383 712
    5K7J6 942
    6Q639 168
    JJ8JJ 961
    5294A 776
    66766 638
    3T9JT 104
    A7T8J 213
    Q74J7 175
    5296K 250
    25888 204
    A5AJQ 598
    TJKK6 396
    TTJTA 753
    74QK4 766
    8QTAJ 16
    A2632 225
    22825 823
    J5286 606
    999T9 533
    22252 572
    2Q222 98
    55J55 684
    K38K2 959
    JAA4Q 908
    49J54 55
    7K37Q 315
    39354 421
    8Q76Q 730
    666JQ 864
    77TTK 583
    Q9T87 846
    44494 92
    JJK24 909
    AAAAK 422
    25Q7Q 947
    Q4658 82
    K2Q8T 886
    7T979 47
    K365Q 657
    4T822 945
    57KK5 650
    69555 441
    J8J8T 960
    KAKKK 103
    9T5JA 479
    88KK6 361
    47569 209
    39Q58 69
    33399 271
    9A6TK 673
    28AAA 45
    64449 967
    T4J6Q 492
    6222A 727
    TAA72 265
    KK667 457
    9Q9Q6 432
    K6K3K 300
    5QTQQ 404
    TJ44J 781
    8595A 234
    K2539 498
    KK77J 207
    A42Q9 602
    23333 543
    9J299 758
    29222 821
    KKTAJ 136
    59555 856
    5Q98Q 523
    65558 872
    464K6 798
    7773K 519
    AJAJA 380
    77977 591
    57443 125
    AAJAA 450
    5AA6A 881
    69679 458
    6JQ3K 139
    Q3J3Q 636
    AQ556 221
    A6J3K 741
    TT7T6 56
    3QQQA 972
    27399 754
    54Q5Q 592
    Q2975 920
    93898 770
    86828 27
    TTT9T 809
    6QA73 344
    A8J74 546
    J8J88 374
    24T42 183
    387Q6 14
    98A99 418
    AA3AA 245
    44KKK 240
    8658K 317
    28228 555
    2AAAA 381
    8A2T3 331
    75Q82 899
    387KK 737
    K444K 839
    K9999 424
    KK9AK 948
    QQAQA 512
    475KK 820
    72277 430
    JT7T3 466
    Q555Q 853
    5555K 562
    QQ58J 537
    J3762 536
    85283 196
    9T44T 651
    6KTAJ 785
    24J29 666
    36653 962
    KQAKA 596
    KTK5A 597
    Q999T 842
    82828 629
    AT7AT 848
    73TT8 215
    A4Q4Q 791
    T8326 8
    5QQQ7 977
    TKKKT 680
    A92A9 277
    6689J 539
    2J222 963
    566Q8 802
    Q9QQQ 387
    2322A 403
    66366 147
    JJJJJ 951
    278T9 496
    6949T 465
    3K5K8 692
    TK3K2 608
    AA9AA 918
    653JK 703
    4K5JA 475
    63863 72
    5593J 388
    55474 476
    99T9T 923
    5A95J 825
    T5K28 723
    KKJJK 869
    57865 160
    JKKTT 272
    AAAAT 631
    TTJ4J 905
    93369 214
    8J777 944
    96267 236
    56Q9T 164
    7QQ42 819
    67K4T 434
    AAA8A 93
    JAJKQ 310
    97J77 859
    K7K9J 462
    88JJA 283
    74A44 25
    KKAJK 548
    3TT5Q 593
    27762 914
    TT3TT 369
    6388Q 656
    3T48T 156
    AJQJ5 507
    65K2Q 855
    A4652 663
    65A72 957
    J66J6 998
    44434 100
    99777 449
    3J2Q2 567
    66QQ8 889
    A999J 363
    AAJJ2 364
    7789A 350
    73737 980
    QQQT8 411
    T224K 227
    K3289 155
    AJA77 971
    88548 305
    55554 76
    38386 97
    999A9 200
    KJK55 7
    J77J7 237
    777JK 259
    577T2 777
    99969 407
    9898J 761
    225K9 722
    9TT39 995
    7TJ5A 745
    45477 865
    TTAJ4 838
    TT22J 149
    4J222 939
    A8A98 84
    8Q333 327
    A3Q3A 897
    29K68 575
    5K558 621
    58778 152
    2923Q 107
    4K6KJ 735
    T9J99 115
    33T3Q 524
    8KKKT 91
    33T35 397
    QQKQT 298
    48J36 795
    7J777 51
    J585A 264
    45545 81
    T88JT 634
    43364 584
    77A77 616
    AJ4Q8 54
    3A362 389
    73732 755
    68666 447
    2Q6Q6 568
    34K33 409
    T5K34 60
    TJ9T6 635
    4QQ44 913
    K3JK3 253
    66A2A 686
    KTK33 423
    6AAAA 950
    7554J 470
    4444T 763
    22772 702
    24229 121
    8J86K 683
    KK7A5 474
    6T632 987
    2J2K2 368
    AAJ54 611
    QAT87 697
    J9QQ8 740
    92QQ2 688
    6TKA8 184
    QQQQA 202
    A5JJ3 890
    3T445 590
    93995 348
    6QQJ3 873
    T4TJ4 841
    2T2TT 269
    K8J7T 223
    89999 958
    Q77J6 379
    TT2TT 2
    6JQ29 280
    8TQT8 615
    6TTTT 978
    T6A66 517
    77884 439
    33633 494
    T99T5 153
    7T54J 953
    33739 65
    4K544 556
    9Q9J9 751
    8QQ79 637
    2QQ69 786
    TKJ2K 930
    56545 41
    5A8A4 676
    66566 868
    69996 915
    JJQQQ 9
    J27KJ 499
    22424 26
    64QQ4 323
    988A8 123
    7K447 410
    T8K8T 620
    7KAJK 573
    88855 531
    75743 943
    KT7KK 578
    J3A56 708
    3224A 158
    J73J2 290
    79955 858
    58JK5 640
    A4AJJ 340
    33J44 648
    95785 527
    3K548 965
    K47J4 552
    9QQJQ 275
    J85Q7 75
    64466 461
    478KQ 132
    88989 828
    T2T22 710
    38A22 442
    8QJJ8 704
    K4KKK 325
    29942 875
    3AK56 210
    388K6 31
    82233 182
    A9ATT 968
    AJK46 906
    699T9 218
    33338 353
    55J33 664
    8J868 901
    44249 927
    KTT7J 800
    8TA2Q 137
    88928 313
    AA5A9 472
    5AAAA 406
    23JJQ 627
    79JA2 585
    Q6J99 919
    3J444 952
    3KKKK 19
    7QQTK 812
    8QJ83 48
    2252Q 892
    65556 480
    3336A 731
    976JK 672
    QAAAQ 561
    J69J9 510
    K7777 355
    Q8888 58
    Q8QJ8 887
    88848 843
    KKJ35 903
    92988 986
    33344 62
    55JK3 241
    K37Q5 847
    TAA7K 428
    A33AA 349
    2K222 222
    9AK56 563
    QT382 644
    KK2T2 488
    AA552 715
    96A37 262
    3J376 949
    JTJJT 594
    KKQJK 448
    999JJ 71
    8556A 74
    Q4JJQ 292
    55JK6 366
    444Q4 724
    7QK58 940
    K2J8T 559
    9T96T 312
    Q679A 73
    33A37 870
    93TJA 734
    44489 191
    9TA9A 478
    66K5K 836
    A8J8A 119
    322K2 59
    777TA 111
    A7778 609
    AJK96 83
    TTJ5T 827
    3QQQ3 514
    32242 595
    T5JT5 652
    544J5 996
    884QK 467
    7737J 12
    Q5TA9 538
    8J5J8 401
    68KQ9 569
    9QKJK 1
    AAAJ8 801
    3333J 888
    7Q979 373
    77277 252
    AKKQQ 394
    QTJ47 695
    JJJT7 793
    A27A5 358
    99939 148
    8T7J8 738
    Q9924 438
    73763 607
    KJT44 127
    8T288 975
    64K4K 279
    6A6JA 925
    56555 110
    77427 671
    9956J 941
    7757J 359
    J3337 80
    44256 642
    JJ555 871
    55859 784
    896TK 324
    66K66 336
    2Q2QQ 750
    93833 87
    5JA3K 689
    TQKQ3 395
    K8334 308
    22A42 983
    533JA 974
    9J7T7 455
    8888T 840
    TAT95 370
    22T22 509
    TKQJ7 581
    48448 641
    J3993 102
    TQ8A5 270
    2KT39 291
    TQTTT 445
    J2A5T 89
    2KQ98 170
    A5AA5 520
    QJT8T 571
    J7AAA 733
    227A2 61
    T555T 973
    TT63A 436
    48JA6 420
    788K9 690
    2A2K4 260
    3TJTT 759
    74K87 506
    45Q22 400
    228J8 771
    AJJ2T 52
    9274T 610
    T4TQT 956
    JTT66 790
    4344K 508
    8878A 243
    55666 788
    5A2Q5 768
    77T78 296
    KJK59 360
    TTTJT 954
    952J9 603
    J6666 487
    JTJ29 32
    9A278 516
    933AA 874
    57357 835
    334AJ 287
    J4KK4 276
    J2226 698
    49999 382
    Q6QQ2 549
    6A4J3 670
    8QJA2 826
    999K7 138
    K7Q87 242
    22226 413
    7K9K8 285
    A85AA 299
    2JJK2 385
    Q3TTQ 5
    377QT 902
    82223 63
    QQ7Q6 64
    9J7JQ 469
    7A7TT 970
    45JJ2 162
    82J4T 383
    9AA99 748
    53K53 794
    K2KKK 982
    646J3 330
    26J27 216
    87A26 605
    343J5 966
    QQ4QQ 622
    9JTQ9 912
    A3A38 337
    T2538 34
    52553 224
    66622 444
    5T5TT 701
    8JJKJ 895
    A333A 101
    KK5QQ 694
    J9999 979
    KTKT7 668
    QQ622 725
    55Q7K 77
    79TK8 392
    JJ98A 352
    2A332 883
    33T39 834
    94J73 212
    Q22QJ 267
    53A9A 67
    69666 169
    KAJAT 95
    QQ84Q 728
    63723 774
    Q3A8K 375
    3J36Q 625
    85J88 714
    5T9J3 124
    2KK2K 614
    Q5JKJ 988
    68926 203
    TQ799 822
    46TT4 44
    97997 482
    2A282 106
    6TQ88 459
    33999 707
    7Q264 574
    AAAA7 739
    86888 154
    A752J 10
    2T727 760
    5T54T 662
    2QQQQ 626
    6797J 143
    6K56T 105
    679Q8 88
    8AK25 579
    K6AJK 645
    8J83J 746
    A7AA2 854
    9J2TQ 319
    A8J84 577
    87787 799
    867AJ 837
    QQJQQ 796
    QQTQQ 576
    225T5 588
    5QQ77 677
    K7KKK 969
    T7TTT 832
    A4AA6 192
    KQ987 190
    ATTAT 425
    6J9A4 378
    99Q2J 128
    95549 917
    KKQKK 180
    6A5Q7 254
    8378J 991
    64444 553
    JTTJT 789
    J75K5 810
    QQK28 258
    4K3J6 518
    2TTT7 135
    K3339 532
    27222 94
    29A29 857
    49882 351
    63J33 198
    5T5J7 910
    7443K 185
    4K44J 393
    K6626 417
    28888 347
    T47KT 882
    22562 273
    K8627 118
    Q92KK 926
    J2644 600
    AA6T7 86
    2QQ22 929
    447J7 246
    J8A25 167
    2A898 468
    46K55 660
    JTTT9 23
    QQQ7Q 219
    7Q7JQ 42
    77A37 108
    33244 850
    Q8529 46
    82A5Q 443
    76877 278
    A7J3T 320
    QKT4K 782
    57AJA 99
    8Q3J3 39
    KA4QQ 582
    KKKJK 481
    66864 876
    KK3K3 816
    Q8853 813
    223T6 544
    KAKTK 261
    99Q9A 764
    Q7425 235
    A86K5 321
    J483K 435
    KK8KK 339
    A52TQ 30
    TAA37 473
    K4AAK 658
    KK48A 429
    64484 497
    3K3TA 289
    8898J 144
    JAJAJ 356
    K8286 329
    82KQ6 818
    55T55 814
    7KA9Q 619
    727A7 817
    893J3 485
    452J5 371
    K6969 256
    5J528 490
    77498 990
    6J86K 699
    J9373 526
    KQQKK 157
    77AA2 120
    J488Q 165
    63885 4
    T94K3 233
    AA4JA 306
    7QQ9J 617
    88KKK 70
    485QT 341
    """
    }
}
