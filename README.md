
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfm

> Tools for RFM Analysis

<!-- badges: start -->

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rfm)](https://cran.r-project.org/package=rfm)
[![cran
checks](https://badges.cranchecks.info/summary/rfm.svg)](https://cran.r-project.org/web/checks/check_results_rfm.html)
[![R build
status](https://github.com/rsquaredacademy/rfm/workflows/R-CMD-check/badge.svg)](https://github.com/rsquaredacademy/rfm/actions)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rsquaredacademy/rfm/master.svg)](https://codecov.io/github/rsquaredacademy/rfm?branch=master)
[![status](https://tinyverse.netlify.com/badge/rfm)](https://CRAN.R-project.org/package=rfm)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![](https://cranlogs.r-pkg.org/badges/grand-total/rfm)](https://cran.r-project.org/package=rfm)
<!-- badges: end -->

## Overview

Tools for RFM (recency, frequency and monetary) analysis. Generate RFM
score from both transaction and customer level data. Visualize the
relationship between recency, frequency and monetary value using
heatmap, histograms, bar charts and scatter plots.

## Installation

``` r
# Install rfm from CRAN
install.packages("rfm")

# Or the development version from GitHub
# install.packages("devtools")
devtools::install_github("rsquaredacademy/rfm")
```

## Articles

- [RFM Customer
  Data](https://rfm.rsquaredacademy.com/articles/rfm-customer-level-data.html)
- [RFM Transaction
  Data](https://rfm.rsquaredacademy.com/articles/rfm-transaction-level-data.html)

## Usage

### Introduction

**RFM** (recency, frequency, monetary) analysis is a behavior based
technique used to segment customers by examining their transaction
history such as

- how recently a customer has purchased (recency)
- how often they purchase (frequency)
- how much the customer spends (monetary)

It is based on the marketing axiom that **80% of your business comes
from 20% of your customers**. RFM helps to identify customers who are
more likely to respond to promotions by segmenting them into various
categories.

### Data

To calculate the RFM score for each customer we need transaction data
which should include the following:

- a unique customer id
- date of transaction/order
- transaction/order amount

### RFM Table

rfm uses consistent prefix `rfm_` for easy tab completion. Use
`rfm_table_order()` to generate the RFM score.

``` r
analysis_date <- as.Date('2006-12-31')
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
rfm_result
#> $rfm
#>                       customer_id recency_days transaction_count amount
#> 1             Mr. Brion Stark Sr.          229                 8    852
#> 2                  Ethyl Botsford          252                 8    526
#> 3                  Hosteen Jacobi          545                 4    300
#> 4                   Mr. Edw Frami           44                10    868
#> 5                     Josef Lemke           48                 5    391
#> 6                Julisa Halvorson          127                12    987
#> 7                Judyth Lueilwitz          662                 5    552
#> 8               Mr. Mekhi Goyette          416                 4    350
#> 9               Hansford Moen PhD          186                 7   1004
#> 10                  Fount Flatley          146                11    937
#> 11                 Reynaldo Davis          681                 3    358
#> 12                  Shirl Keebler           90                 4    377
#> 13                Dr. Aden Murphy           98                 7    596
#> 14                 Hattie Roberts          122                 5    436
#> 15                  Luciano Kling          101                 6    587
#> 16                 Admiral Senger          132                 5    448
#> 17                   Hyman Kemmer          203                 5    455
#> 18                 Torry Reynolds          135                 7    650
#> 19             Ms. Erica Gottlieb          340                 8    829
#> 20                 Jabbar Dickens          160                10   1060
#> 21                 Gunner Wiegand           96                 4    234
#> 22                Devante Gerhold          529                 5    713
#> 23            Dr. Jeff Bartoletti           81                 8    771
#> 24          Dr. Tyreke DuBuque IV          210                 7    690
#> 25          Dr. Dell Baumbach III           80                 3    270
#> 26                   Bobby Corwin          365                 3    246
#> 27                 Helyn Ondricka          277                 5    384
#> 28           Curtis Runolfsdottir          431                 5    566
#> 29            Dr. Lucious Langosh          116                 4    265
#> 30               Ronan McLaughlin          289                 4    496
#> 31           Barrett Turcotte DVM          186                 4    319
#> 32                 Lyndon McClure          270                 5    575
#> 33                    Brooks Funk          497                 2     96
#> 34                  Alf Lueilwitz          202                 7    596
#> 35               Lilah Blanda PhD          202                 6    358
#> 36                   Daryn Hickle          352                 4    364
#> 37                  Davy Leuschke          295                 4    356
#> 38                  Shirl Kuvalis          276                 5    450
#> 39         Miss Lovie Keeling DVM          103                 5    348
#> 40                    Burns Mayer          266                 5    419
#> 41                 Elza Gleichner          457                 3    268
#> 42            Darrion Stoltenberg          176                 6    766
#> 43                 Somer Turcotte          190                10   1018
#> 44                Mr. Tad Johnson          206                10   1184
#> 45             Robert Satterfield          135                 4    317
#> 46                Quintin Tillman           64                 9    960
#> 47              Vivienne Medhurst          517                 3    390
#> 48                  Holland Lynch          486                 6    499
#> 49                  Davian Ledner          199                 4    291
#> 50                   Vannie Kunze          397                 9    823
#> 51              Dr. Micayla Kutch           32                10    834
#> 52             Dr. Jaren Schmeler          102                 3    421
#> 53                  Gracia Wunsch          225                 6    662
#> 54                   Rebeca Kling          129                 8    956
#> 55               Avery Bartoletti          183                 4    370
#> 56                  Collie Von MD          462                 6    612
#> 57                     Etta Towne          134                 6    581
#> 58           Josephus Bradtke DVM          374                 4    520
#> 59            Jacqueline Nikolaus          280                 7    434
#> 60                  Aileen Barton           84                 9    763
#> 61                 Doshia Stroman          102                 3    123
#> 62                  Texas Keebler          484                 5    702
#> 63                  Triston Mills          332                 4    366
#> 64              Dr. Kieth Wiegand          210                 4    350
#> 65               Torrance Pollich           54                 3    377
#> 66               Essence Metz DDS          379                 8    722
#> 67               Rochelle Johnson          204                 7    652
#> 68        Margarette Eichmann DVM          220                 3    345
#> 69                 Omie Cummerata          519                 4    220
#> 70                  Casen Kuhlman           27                 2    186
#> 71                   Korey Cronin          479                 2     82
#> 72                     Tia Zulauf          149                 6    522
#> 73                Mitzi Bergstrom          375                 3    188
#> 74                 Latoya Stanton           21                10    814
#> 75                  Winifred Kris          452                 6    459
#> 76                Suzette Pollich          335                 4    395
#> 77             Delfina Watsica MD           10                 6    668
#> 78                  Mykel Johnson          276                 8    453
#> 79            Marcello Torphy Jr.            4                 6    464
#> 80                   Cary McGlynn          222                 5    520
#> 81               Rolla Hodkiewicz          564                 4    409
#> 82          Dr. Cheyenne Dach DVM          153                 5    406
#> 83              Mrs. Lucetta Auer          229                 3    128
#> 84              Devaughn Erdman V           99                 4    384
#> 85                 Benji Jacobson          632                 2     94
#> 86      Miss Katelynn Lebsack DVM           99                 7    382
#> 87                   Amina Renner          215                 5    663
#> 88           Miss Halle Davis DDS          132                 8    665
#> 89         Dr. Jeannie Rutherford          511                 4    416
#> 90                  Casen Blick V          391                 4    407
#> 91         Miss Haleigh Wilkinson          198                10    900
#> 92                 Alex Armstrong          482                 6    634
#> 93                 Warren Osinski          129                10   1038
#> 94              Mr. Lary Champlin          124                14   1074
#> 95            Mr. Armin Klocko IV          482                 6    492
#> 96             Dr. Bree Stehr DVM          376                 7    607
#> 97                  Dow Halvorson          317                 6    836
#> 98      Dr. Valentine Volkman DVM           81                 8   1068
#> 99              Mrs. Hildur Mante          431                 3    386
#> 100                    Ivy Kohler          356                 7    719
#> 101                 Dr. Darl Rice          433                 4    392
#> 102             Murl Wilkinson II          135                 7    936
#> 103                  Jayden Hayes          478                 7    435
#> 104                    Franz Mohr          527                 4    430
#> 105                  Byrd Kuhn MD          225                 5    532
#> 106               Buddie Terry MD          294                 7    635
#> 107               Candido Krajcik           71                 8    613
#> 108       Ms. Maebell Reinger DVM          443                 6    673
#> 109                Dwan Wilderman          174                 3    268
#> 110              Laisha VonRueden           27                 9   1003
#> 111            Damarcus Erdman II          446                 5    589
#> 112                 Elinor Howell          320                 6    746
#> 113                  Johney Mayer          272                 3    101
#> 114                 Hiroshi Terry          239                 6    434
#> 115           Lyndsey Heidenreich          384                 9   1050
#> 116                     Ebb Doyle          170                 5    307
#> 117                   Roger Green          663                 4    468
#> 118      Chastity Greenfelder PhD          506                 3    222
#> 119                 Almedia Yundt          146                 4    436
#> 120                   Katlyn Mann          297                 7    698
#> 121                   Juana Bogan          505                 5    416
#> 122                Aubrey Witting           53                 4    229
#> 123                Makenzie Hintz          497                 2    252
#> 124               Kalvin Prosacco          129                 7    751
#> 125               Yazmin Borer MD          549                 5    716
#> 126                Shelton Hudson          153                 8    867
#> 127               Kem Medhurst II          287                 4    275
#> 128              Herschel Flatley          379                 6    518
#> 129           Miss Jovita Reinger          200                 3    243
#> 130            Mrs. Oneta Lebsack          258                 7    777
#> 131                 Elizbeth West          187                 2    183
#> 132                 Skylar Hoeger          282                 4    255
#> 133                   Alfred Metz          245                 7    703
#> 134           Mrs. Alysa Cummings            1                 9    876
#> 135             Miss Kesha Daniel           79                 6    447
#> 136                    Olof Swift           88                 5    453
#> 137         Luverne Rodriguez DDS          279                 6    582
#> 138                    Burr O'Kon          172                 4    381
#> 139                   True Conroy           40                 5    471
#> 140                  Gayle Kuphal           20                 5    460
#> 141                  Mabell Lemke          164                 7    583
#> 142                 Leone Fritsch          359                 4    375
#> 143          Dr. Elroy Kirlin Jr.           28                 5    363
#> 144                    Bessie Kub          457                 9    977
#> 145                 Marvin Wisozk          553                 3    356
#> 146                Warner Kessler          290                 4    310
#> 147                   Mila Gibson          486                 4    620
#> 148               Cari Renner PhD          180                 8    787
#> 149                   Suzann Koss          288                 6    353
#> 150                   Kamren Moen          336                 3    274
#> 151              Dr. Sherie Mayer          172                 7    654
#> 152              Nigel Leannon II           63                 5    579
#> 153                  Jeanie Berge          539                 4    570
#> 154             Mervyn Vandervort          723                 3    294
#> 155                Tamisha Crooks           11                 6    627
#> 156          Dr. Willis Bahringer           42                 6    665
#> 157             Mr. Torry Bogan I          107                 2    195
#> 158              Jayvion Cummings           53                 9   1090
#> 159                Shakira Stokes           75                 5    438
#> 160              Etta Franecki MD          481                 8    892
#> 161               Mr. Semaj Sauer           31                 8    806
#> 162              Dr. Camilo Kiehn          445                 4    281
#> 163              Casandra Krajcik          144                10    968
#> 164                  Jules Harber          673                 2     77
#> 165                Lisandro Swift           97                 6    479
#> 166                  Shea Gerlach          201                 7    760
#> 167         Mr. Demetric Franecki          149                 4    387
#> 168              Isabela Mertz MD           97                13   1104
#> 169                 Maebell Terry          107                 4    258
#> 170                  Pratt Crooks          182                 5    300
#> 171            Dominique McKenzie          332                 5    615
#> 172                Burke Connelly           41                 6    465
#> 173         Ms. Leaner Jacobs PhD          647                 4    458
#> 174                Rosanne Maggio           67                 7    597
#> 175              Nathanael Wisozk          636                 3    343
#> 176                 Soren Gleason          103                 9   1061
#> 177                 Jaliyah Purdy          241                 3    249
#> 178                  Ruel Ruecker          176                 5    436
#> 179              Lillianna Larkin          148                 9   1011
#> 180       Miss Cristi Quitzon PhD          152                 5    425
#> 181                Leyla Dietrich          118                 5    485
#> 182                   Lott Larkin          472                 6    437
#> 183                 Daisha Torphy           82                 5    371
#> 184              Joana Kemmer DDS          153                 8    806
#> 185            Nery Ankunding PhD          574                 4    425
#> 186             Rikki Watsica DVM           43                 7    581
#> 187             Laurene Considine          311                 9   1008
#> 188                   Lissa White          417                 6    492
#> 189               Santana Bradtke          152                 8    732
#> 190       Mrs. Cleone Hagenes DDS          537                 3    331
#> 191             Mr. Hurley Brekke          444                 2    175
#> 192               Benjamin Barton          181                 5    552
#> 193                Ms. Zola Nolan          224                 4    375
#> 194                     Lesa Hane           77                 3    157
#> 195             Dr. Arnoldo Marks          129                 6    567
#> 196            Romaine McCullough          232                 5    405
#> 197                 Fidel Kilback           94                 4    411
#> 198                 Delia Witting           17                 4    323
#> 199               Krista Hartmann          695                 4    155
#> 200             Ashleigh Eichmann          162                 4    681
#> 201                    Iesha Mraz          131                 6    466
#> 202                  Howell Blick          245                 5    235
#> 203                Verona Langosh          539                 5    492
#> 204                 Bethel Wunsch          331                 3    190
#> 205          Vivian McLaughlin MD          416                 6    574
#> 206                 Velda Goyette          151                 6    473
#> 207 Miss Katherine Balistreri DDS          288                 4    357
#> 208               Dr. Barrie Bins            4                 4    446
#> 209          Madyson Bergnaum PhD           85                 8    965
#> 210              Dr. Jeffie Johns          294                 8    665
#> 211                   Imani Swift          443                 6    546
#> 212               Mr. Lupe Kohler          299                 7    716
#> 213             Mr. Owens Gaylord          123                 3    172
#> 214           Devontae Swaniawski          508                 4    274
#> 215        Mrs. Maura Schamberger          266                 5    434
#> 216             Mr. Michal Murphy          136                 5    548
#> 217            Johnathon Schimmel          455                 4    436
#> 218                   Tori Bailey          129                 2    121
#> 219                Agness O'Keefe           90                 9    843
#> 220              Ronin Beatty Jr.          146                 4    434
#> 221                   Jessy Emard          281                 7    653
#> 222              Blair Erdman PhD          181                 8    845
#> 223        Mrs. Madelyn Hermiston          122                 4    446
#> 224             Donie Stroman PhD           92                 2     97
#> 225          Seaborn Bogisich III          178                 3    459
#> 226              Dominik Anderson           20                10   1249
#> 227              Jessica Koepp MD           88                 5    450
#> 228             Peyton Runolfsson          174                 4    335
#> 229              Shirlie Nikolaus          210                 7    688
#> 230                 Carlton Mante          164                 5    522
#> 231               Ezzard Bernhard          423                 6    317
#> 232                 Claus Bradtke          676                 4    435
#> 233               Evelyn Schinner          317                 2     91
#> 234               Dr. Hoke Jacobs          133                 5    708
#> 235        Dr. Chas Cummerata Jr.          510                 2    169
#> 236                  Lydia Willms          116                11    713
#> 237                  Gaylen Kiehn          652                 4    489
#> 238       Dr. Niles Altenwerth II          380                 7    644
#> 239              Malcolm Medhurst          275                 4    350
#> 240              Mr. Wendel Hintz           87                 6    798
#> 241              Dwain Skiles Jr.          481                 6    805
#> 242             Marguerite Heaney          114                 4    265
#> 243                Butler Schmitt          122                 7    689
#> 244               Gilmore Schmitt          125                 5    353
#> 245       Ms. Forest Hartmann DVM          538                 3    311
#> 246           Dr. Eliezer Wuckert          130                 6    529
#> 247            Ms. Jacklyn Casper          105                 5    415
#> 248               Deontae Effertz          135                 7    544
#> 249          Dr. Dustyn Rodriguez          439                 7    265
#> 250                 Rice Prohaska           71                 6    319
#> 251               Karan Weber DVM           67                 4    276
#> 252              Mr. Jeff Denesik          235                 4    326
#> 253               Ingrid O'Kon MD          463                 9    922
#> 254                Violette O'Kon          246                 4    565
#> 255                Avah Schneider          122                 7    777
#> 256                 Rakeem Harvey          454                10    809
#> 257                Epifanio Kozey          493                 1     43
#> 258           Mr. Ray Stanton III          144                11    816
#> 259         Ms. Peyton Larson DVM          433                 6    664
#> 260                Vonda Connelly          515                 2    297
#> 261               Kylie Kertzmann          117                 2    209
#> 262           Ms. Brea Nienow DDS           90                 6    580
#> 263                Britton Brekke          363                 3    336
#> 264       Ms. Amira Gutkowski DDS          576                 2    191
#> 265              Latesha Bernhard          195                 8    724
#> 266               Link Carroll MD          494                 7    648
#> 267               Ms. Delpha King           43                12   1233
#> 268     Miss Fronnie Schaefer DDS           51                 6    573
#> 269         Dr. Lovett Legros DDS          151                 5    420
#> 270        Miss Tillie Crooks DVM          164                 7    709
#> 271            Ms. Giada Weissnat          102                 6    346
#> 272             Carmella Schiller          200                 6    721
#> 273              Mathilda Farrell          242                 7    736
#> 274             Aurthur Kirlin II          116                 9    856
#> 275                  Thor Schultz           38                 3    274
#> 276                 Murray Harvey          145                 5    646
#> 277                  Lesta Carter          427                 9    773
#> 278                Enos VonRueden          629                 3     99
#> 279                 Derek Witting          556                 5    674
#> 280                Orpha Bernhard          153                 9    955
#> 281            Abbey O'Reilly DVM          205                 6    472
#> 282          Mrs. Danika Schulist          443                 5    495
#> 283                 Blair Cormier          250                 5    733
#> 284                  Mimi Goldner          468                 4    404
#> 285                  Masao Deckow            6                 3    239
#> 286              Stefani Kshlerin          186                 7    520
#> 287                Ailene Hermann          281                 8    699
#> 288        Dr. Christal Wolff PhD          116                 9   1007
#> 289                   Corda Towne          183                 8   1018
#> 290              Mrs. Laila Bayer           72                 4    516
#> 291                 Flo Gulgowski          379                 4    416
#> 292              Jessica Connelly          352                 7    438
#> 293                Caylee Carroll          240                 7    636
#> 294                Shari Rowe PhD          426                 5    665
#> 295                 Bronson Towne           89                 4    161
#> 296            Mr. Colin Prohaska          479                 7    700
#> 297                 Manilla Braun          372                 3    513
#> 298          Jammie Runolfsdottir          276                 5    374
#> 299                Bryson Reinger          175                 6    580
#> 300                Gregg Franecki          225                 4    317
#> 301               Hershel Shields          179                 6    819
#> 302                Lidie Gislason           94                 3    285
#> 303         Mrs. Astrid Bayer PhD          141                 8    687
#> 304                    Elgie Cole          172                 5    476
#> 305             Alpheus Wilkinson          405                 6    597
#> 306            Mr. Manuel DuBuque          126                 9    927
#> 307             Mariano Lueilwitz          400                 6    540
#> 308                Alvah Bogisich          191                 8    598
#> 309                 Odelia Rippin          488                 6    585
#> 310          Dr. Hildegard Murray          213                 7    672
#> 311          Mrs. Noma Hessel PhD          298                 7    815
#> 312                Reggie Leffler          455                 5    413
#> 313        Mr. Saverio Weimann II          263                 5    534
#> 314              Susannah Bernier           33                 6    754
#> 315                Diego Gislason          224                 5    198
#> 316                Starling Welch          128                 7    590
#> 317                Wally Nikolaus          181                 5    419
#> 318             Bertina Renner MD            5                 6    528
#> 319        Georgene Aufderhar PhD          122                 6    464
#> 320               Robert Schmeler          243                 3    254
#> 321                    Donta Veum          515                 7    792
#> 322             Dr. Woodson Klein          152                 4    515
#> 323                 Nobie Hermann          597                 4    353
#> 324                Peyton Koelpin          604                 1     89
#> 325   Miss Chante Stoltenberg PhD          316                 6    805
#> 326         Mr. Paulo Stoltenberg          487                 3    308
#> 327             Dr. Keenen Parker           57                 8    532
#> 328                    Posey Metz          183                10   1060
#> 329                  Toney Marvin          212                 5    558
#> 330                  Sylva Littel          178                 7    778
#> 331                 Nikita Becker          140                 4    462
#> 332               Iliana Donnelly          251                 5    486
#> 333              Caswell Anderson          499                 5    559
#> 334                    Flem Kozey          182                 6    365
#> 335               Keri Williamson          180                 9    741
#> 336              Shania Stamm DDS          188                 9    997
#> 337              Azariah Lubowitz          179                 5    425
#> 338             Devon Osinski DVM          545                 3    579
#> 339                 Art Hyatt III          274                 6    803
#> 340                Buford Pollich          101                 4    492
#> 341                Fannie Watsica          181                 7    648
#> 342                Alyssia Hickle          209                 5    387
#> 343                Bush Schroeder          236                 6    639
#> 344                   Kizzy Doyle          168                13   1488
#> 345   Ms. Hayleigh Swaniawski DDS          289                 4    489
#> 346           Dr. Jerod Berge Jr.          422                 6    392
#> 347         Mr. Lillard McGlynn V          588                 2     96
#> 348                    Add Senger          140                 3    340
#> 349                 Alannah Borer          619                 4    196
#> 350           Ruthe Macejkovic MD          373                 9    805
#> 351                 Jeanette Lind           41                10   1062
#> 352                 Dorathy Nader          101                 5    456
#> 353                  Claire Terry          167                 6    775
#> 354                Kelsey Pollich           48                 3    473
#> 355                Mohammad Smith          201                 6    600
#> 356        Dr. Dillon Pollich DDS          558                 5    284
#> 357               Mrs. Kyrie Funk          502                 5    520
#> 358                  Lane Roberts          372                 5    585
#> 359                 Cathey Beatty          250                 6    343
#> 360            Shellie Brekke III          591                 3    384
#> 361                 Dr. Vic Bauch           64                 9    850
#> 362                 Irwin Ritchie          159                 6    694
#> 363                 Esker Cormier           33                 4    283
#> 364                 Loy Olson Sr.          151                 6    560
#> 365          Dr. Franco Kemmer II          260                12   1065
#> 366              Dr. Ras Kshlerin           78                 5    672
#> 367                   Tracy Feest          530                 4    253
#> 368     Dr. Isaak Oberbrunner DVM          228                 5    228
#> 369                  Karon Torphy          398                 5    554
#> 370        Miss Lacey Sanford PhD          284                 5    652
#> 371            Marlene Runolfsson          230                 5    554
#> 372                  Hansel Kiehn          134                 6    416
#> 373                 Elias Huels V          569                 7    841
#> 374                Tilden Hermann          545                 2     96
#> 375             Lorean Stokes DVM           82                 9    708
#> 376                Theo Buckridge           15                 6    446
#> 377                  Taylor Crist          261                 6    643
#> 378               Lakeshia Harris          549                 7    309
#> 379           Dr. Grady Beier DDS          408                 5    542
#> 380           Alphonse Champlin V          214                 7    367
#> 381             Ms. Gracelyn Dare          112                 6    548
#> 382             Stetson Ferry DVM          500                 3    237
#> 383               Marissa Goyette          120                 7    693
#> 384               Nathaly Streich          525                 6    681
#> 385            Scottie Beahan PhD          275                 3    538
#> 386             Hurley Schiller I          442                 6    687
#> 387               Arlie Brekke IV          327                 5    434
#> 388                Alethea Blanda          157                 4    245
#> 389               Corey Bechtelar          846                 2    237
#> 390               Elmyra Schaefer          326                12   1150
#> 391         Jarred Stiedemann DDS          372                 4    291
#> 392                   Ariel Yundt          126                10   1069
#> 393       Dr. Shaniece Herzog PhD          148                 4    308
#> 394           Iyanna Schmeler PhD          182                 4    473
#> 395                 Deonte Zemlak           95                 5    586
#> 396           Mr. Christ Zieme MD          111                 7    510
#> 397               Tyshawn Witting          573                 3    208
#> 398             Rexford Greenholt          196                 5    570
#> 399                 Nan O'Connell          143                 2     79
#> 400              Morton O'Connell          409                 3    258
#> 401          Mr. Tegan Farrell MD          295                 5    378
#> 402             Darrian Bartell I           48                 8    819
#> 403              Schuyler Volkman          160                10    658
#> 404                   Tamia Hills          443                 5    694
#> 405              Dr. Gerard Bauch          173                 4    282
#> 406                   Claire Torp          280                 3    353
#> 407                 Olena Kessler          214                 2    163
#> 408                Tamika Labadie          138                 7    839
#> 409            Zechariah Gislason          207                 9   1196
#> 410            Mr. Thad Nader Sr.          282                 5    480
#> 411                    Uriel Kuhn          542                 5    567
#> 412                 Domingo Block          511                 5    532
#> 413             Ms. Gracie Willms          504                 4    556
#> 414                  Hilma Little           65                 7    513
#> 415                   Lindy Pagac          446                 4    306
#> 416              Dr. Linn Schuppe          200                 3    111
#> 417               Mason Rodriguez          469                 3    270
#> 418                Jerald Gaylord          173                 4    275
#> 419                    Julia Koch          171                 5    236
#> 420                  Riley Heller          171                 4    446
#> 421             Mr. Fount Towne I            8                 6    540
#> 422               Benson Schulist          217                 7    764
#> 423                Londyn Reinger           45                 9    782
#> 424           Antonio Bechtelar V          666                 3    336
#> 425              Gabriel Schiller          416                 3    420
#> 426           Ms. Iliana O'Conner          194                 6    613
#> 427                 Jerold Sporer          135                 6    506
#> 428                  Price Harvey          411                 3    137
#> 429           Ms. Nada Barton PhD          114                 7    576
#> 430           Miss Eugenia Barton          218                 9    753
#> 431           Miss Goldie Smitham          498                 5    631
#> 432                  Exie Gutmann          103                 7    651
#> 433                 Yoselin Bauch          346                 8    760
#> 434          Mrs. Michal Feil DVM          463                 5    390
#> 435                   Rose Kuphal           69                 4    400
#> 436                   Sydell West          191                 6    642
#> 437                 Leonel Rippin          307                 5    515
#> 438                   Myer Stokes          491                 7    826
#> 439              Verlene Emmerich          240                 5    359
#> 440          Miss Latosha O'Keefe          197                 6    854
#> 441              Leala Schuppe MD          193                 6    512
#> 442                  Mendy Ledner          142                 4    523
#> 443               Bascom Prosacco          253                 3    211
#> 444                  Gee Nitzsche          176                 2    165
#> 445                Tallie Gleason          227                 3    293
#> 446                  Enid Reinger            7                 9    792
#> 447                   Roma Daniel          229                 4    197
#> 448            Dr. Bertrand Wolff          870                 1    120
#> 449        Mrs. Jerilynn Schulist          116                 7    888
#> 450                  Cali Weimann          473                 5    533
#> 451         Dr. Mazie Predovic MD           99                 5    283
#> 452               Dr. Mike Legros          186                 1     23
#> 453             Ginger Wintheiser          633                 4    340
#> 454                 Magdalen Ward          533                 2    184
#> 455                Amit Langworth          414                 2    253
#> 456              Kamron Halvorson          403                 8    829
#> 457                Kendrick Boyle            8                 4    347
#> 458                  Tera Collins          546                 3    324
#> 459               Burke Boehm Sr.          578                 3    316
#> 460             Dr. Jett Schaefer          589                 3    366
#> 461                  Verna Hudson          106                 5    789
#> 462               Kraig Hayes DDS          171                 6    781
#> 463             Ms. Hollie Crooks          493                 5    400
#> 464                Kingston Hayes          190                 3    347
#> 465                 Perley Renner          427                 6    406
#> 466              Miss Jonnie Veum          148                 8    770
#> 467             Deasia Lockman MD          392                 1    185
#> 468                 Erla Schulist           77                 3    270
#> 469           Mr. Fletcher Hudson          600                 2    165
#> 470             Ms. Liliana Haley          473                 7    589
#> 471          Mr. Hosie Howell PhD          421                 5    496
#> 472          Ms. Val McKenzie PhD          122                 4    380
#> 473              Dr. Patti Rempel          462                 7    625
#> 474             Mrs. Vivien Bauch          109                 7    676
#> 475             Harrie Swaniawski          636                 5    363
#> 476                  Lockie Fahey          509                 3    284
#> 477              Jeremie Wehner V           50                 8    488
#> 478                  Noma Dare MD          475                 4    597
#> 479                    Lyn Parker           68                 5    639
#> 480              Matthew Schmeler          110                 4    422
#> 481                 Pearl Schmidt          446                 5    536
#> 482            Mr. Marcus Langosh           98                 3    363
#> 483              Emanuel Reichert          269                 5    421
#> 484            Dr. Collie Krajcik          144                 7    704
#> 485                  Auther Haley           57                 9    878
#> 486          Dr. Shirl Cremin PhD          201                 4    326
#> 487                  Tierra Hayes          128                 8    952
#> 488                   Marci Nader           48                 6    494
#> 489                 Rosina Abbott          339                 7    652
#> 490              Gilmer Kertzmann          582                 5    677
#> 491               Aryan Bahringer          286                 4    527
#> 492                Phylis Gaylord          210                 5    185
#> 493      Francisquita Heidenreich          734                 3     72
#> 494           Mr. Francisco Kiehn          620                 2    133
#> 495            Dr. Ned Swaniawski          208                 6    457
#> 496             Dr. Elzy Anderson          168                 6    448
#> 497                Isidore Skiles          189                 4    410
#> 498       Miss Madison Lehner DVM          583                 6    475
#> 499           Chadrick Williamson           46                 5    281
#> 500           Mrs. Marti Johnston          377                 5    409
#> 501                 Tobie Carroll          344                 9    870
#> 502              Corrine Champlin          265                 6    510
#> 503                 Joelle Deckow          101                 5    479
#> 504             Giuseppe Tremblay          577                 3    162
#> 505              Mrs. Lois Russel          632                 2    166
#> 506                  Byrd Abshire           59                 3    456
#> 507                  Hampton Rath          127                 6    619
#> 508             Payten Morissette          296                 3    466
#> 509          Mrs. Chiquita Jacobs          158                 4    144
#> 510             Bonny Breitenberg          573                 6    531
#> 511                 Celine Wisozk           95                 7    596
#> 512             Egbert McLaughlin           63                 6    466
#> 513                Zackery Spinka          387                 6    406
#> 514                   Louis Toy I           48                 6    711
#> 515            Berkley Ernser DDS          269                 9    696
#> 516             Cristine Baumbach          265                 6    620
#> 517              Dellar Schroeder           39                 6    460
#> 518                Zander Lebsack          204                 6    574
#> 519              Eugenie Conn PhD          548                 2    286
#> 520               Keri Schuppe MD          206                 5    528
#> 521              Britni Daugherty           62                 3    226
#> 522                 Bea Considine          312                 5    527
#> 523                 Clovis Feil I          268                 3    312
#> 524                  Clemens Torp          221                 7    950
#> 525            Miss Nealy Stanton          441                 3    248
#> 526             Ms. Marolyn Walsh           90                 3    180
#> 527            Dr. Hansel Steuber          393                 4    333
#> 528      Miss Dorotha Kuvalis PhD           55                 7    958
#> 529            Grisel Reichert MD          150                 5    260
#> 530             Lisandro Kassulke          312                 5    730
#> 531       Mr. Zakary Gleichner II           43                 7    615
#> 532           Laddie Donnelly Sr.          352                 3    196
#> 533             Dr. Kyle Doyle II          183                 8    889
#> 534    Mr. Marquise Swaniawski MD          569                 8    799
#> 535               Zillah Koch PhD          548                 4    516
#> 536              Pat Nitzsche PhD          162                 4    306
#> 537        Dr. Skyler Windler Sr.          102                 6    472
#> 538                Josette Bailey          449                 5    663
#> 539             Chantelle Gaylord          526                 3    293
#> 540               Shantel Jenkins          724                 4    388
#> 541      Dr. Hjalmar Langworth II          119                 2    114
#> 542            Mrs. Breann Harris          310                 5    599
#> 543               Samira Medhurst          430                 7    826
#> 544                Janiyah Cassin          360                 2     75
#> 545               Ala Schmidt DDS          349                 3    363
#> 546               Eller Marquardt          488                 4    401
#> 547            Mr. Hosea Schiller          410                 9    840
#> 548      Mr. Junior Wintheiser II          429                 3    529
#> 549             Geoffrey Reichert          548                 3    301
#> 550         Ms. Gussie Bartoletti          172                 8    885
#> 551                 Lucia Flatley          309                 4    289
#> 552         Mr. Zackery Armstrong          341                 4    490
#> 553           Mrs. Vernie Ryan MD          159                 6    422
#> 554                Karlie Treutel           61                 5    318
#> 555           Dr. Crawford Mayert          504                 4    222
#> 556        Claudette Cummings DVM          140                 6    313
#> 557               Lassie Lindgren           63                 8    775
#> 558             Dr. Myles Stroman          485                 2    187
#> 559           Miss Mistie Torp MD          103                 6    303
#> 560                 Sonny Dickens          250                 6    362
#> 561                 Halbert Nolan          516                 2     95
#> 562       Ms. Katherine Schroeder          407                 6    566
#> 563                Catalina Ortiz          426                 7    837
#> 564            Erastus Macejkovic           80                 5    519
#> 565            Miss Evita Howe MD          632                 6    579
#> 566          Alwina Wilkinson DDS          227                 6    712
#> 567               Michell Gerlach          279                 7    654
#> 568                     Roma Rath          490                 6    420
#> 569          Princess Hermann PhD          597                 1     55
#> 570                   Roni Carter          128                 4    365
#> 571               Piper Buckridge          601                 3    265
#> 572                   Romie Upton          145                 8    622
#> 573             Mr. Kenji Cormier          177                 3    359
#> 574      Wellington Runolfsdottir          265                 2     39
#> 575              Miguelangel Dach           16                 4    316
#> 576               Cato Cartwright          144                 5    314
#> 577            Mauricio VonRueden          509                 5    371
#> 578              Ms. Kelis Rau MD           86                 5    537
#> 579               Ryland Predovic          436                 5    665
#> 580               Christal Dooley          537                 3    311
#> 581             Jazlyn Casper PhD          512                 5    403
#> 582             Bernetta O'Conner          114                 4    276
#> 583            Mr. Tripp Batz PhD          291                 5    446
#> 584                William Sawayn          321                 5    570
#> 585               Franz Powlowski          427                 1    169
#> 586              Mervin Pfeffer V          222                 5    463
#> 587            Dr. Charlton Kutch          135                 4    360
#> 588             Parker Bailey DVM          852                 7    476
#> 589                Karren Schuppe          381                 6    549
#> 590              Oley Schroeder I          402                 6    632
#> 591                    Ottis Wiza          244                 4    242
#> 592           Cristofer VonRueden          229                 6    615
#> 593             Charity Rodriguez          350                 5    420
#> 594                   Odis Schoen          150                 5    512
#> 595                   Jaime Nader          191                 4    276
#> 596         Mrs. Ila Leuschke DVM          392                 6    396
#> 597                 Cleveland Fay           88                 8    790
#> 598                 Naima Treutel          150                 5    613
#> 599             Myrtis Larkin DDS          132                 4    423
#> 600                Latrice Stokes          181                 4    574
#> 601                Izetta Stracke          106                 7    523
#> 602         Dr. Santana Schultz V          131                 4    390
#> 603             Esequiel Kirlin I          159                12    768
#> 604                     Luda Kihn          304                 4    371
#> 605          Dr. Jesse Schowalter           29                 6    714
#> 606                   Shane Haley          157                 5    424
#> 607                Con Altenwerth          463                 2    271
#> 608                 Myrle Krajcik          335                 6    937
#> 609      Mrs. Makenna Bernier PhD          410                 4    386
#> 610              Tarik Marvin Jr.          585                 6    510
#> 611                 Lute Batz DVM          333                 4    505
#> 612                 Tate Turcotte          516                 3    394
#> 613                    Ewart Haag          168                10    595
#> 614                 Dorr Lindgren          208                 5    583
#> 615           Marrion Emmerich IV          149                 7    490
#> 616              Stephaine Graham          105                 4    609
#> 617             Ms. Penni Corkery           98                 6    620
#> 618                  Elsie Parker           13                 8    839
#> 619                 Arnett Waters          210                 5    341
#> 620       Dr. Rayburn Wilkinson I          561                 6    489
#> 621               Lexi Altenwerth          399                 4    655
#> 622                 Lani Dicki MD          112                 6    356
#> 623                   Trudie Mraz           89                 5    474
#> 624             Darrell Heathcote          160                 4    316
#> 625       Mrs. Jaquelin Weber DVM          147                 4    332
#> 626             Emmaline Stark MD          129                 5    282
#> 627                  Alcide Rohan          138                 5    500
#> 628                Nico Dickinson          616                 8    569
#> 629           Dr. Letta Daniel MD          161                 7    688
#> 630               Elenora Trantow          172                 9    826
#> 631          Ms. Hessie Gleichner          414                 6    368
#> 632                 Marla Sanford           93                 9    637
#> 633           Mrs. Delisa Kilback          263                 5    476
#> 634          Dr. Mettie Green DVM          179                 3    464
#> 635                  Jules Jacobi          453                 9    935
#> 636                  Malaya White           86                 6    546
#> 637            Jensen Cormier Jr.          236                 5    556
#> 638               Germaine Becker          444                 4    400
#> 639              Dennie Powlowski          467                 5    581
#> 640              Donaciano Corwin           12                 8    892
#> 641                    Case Weber           77                 6    564
#> 642          Dr. Erving Pagac Sr.           62                 3    244
#> 643                   Ewin Torphy           98                 2    424
#> 644         Dr. Nehemiah Kassulke          534                 1    111
#> 645            Waldemar Greenholt          267                 9    859
#> 646                Patience Ferry          249                 6    644
#> 647                  Braelyn King          170                 5    435
#> 648                 Lollie Heaney          568                 1     28
#> 649            Dereck Denesik DDS            9                 4    633
#> 650                   Donell Dach          146                 3    260
#> 651                  Trudy Stokes          472                 8    855
#> 652               Stafford Willms          506                 3    295
#> 653               Dr. Carma Wyman           44                 7    620
#> 654                Ophelia Ernser          281                 6    622
#> 655                  Floy Krajcik          272                 5    484
#> 656             Rayna Hagenes PhD          538                 4    587
#> 657                   Boyd Cronin          298                 3    318
#> 658             Finnegan Franecki          572                 6    263
#> 659                     Shea Feil          176                 6    588
#> 660                Ayesha Carroll           35                 5    390
#> 661           Mr. Erin Zboncak IV           26                 6    895
#> 662                Maudie Waelchi          720                 2    277
#> 663        Angeles McLaughlin PhD          937                 2    316
#> 664            Ms. Oralia Kilback          182                 6    480
#> 665                    Ricci Bins          535                 4    210
#> 666        Dr. Shea Buckridge PhD          166                 6    420
#> 667                   Joana Crist           67                 4    552
#> 668                   Handy Walsh          116                 7    758
#> 669             Catharine Pacocha          601                 3    346
#> 670                Mr. Rohan Wolf          502                 6    820
#> 671                   Corene Lind           59                 4    218
#> 672              Lorelai Parisian          186                 9    788
#> 673            Lavern Pfeffer DDS          426                 4    632
#> 674             Yetta Gorczany MD          120                 6    378
#> 675                   Lisha Hayes          105                 4    340
#> 676                   Vic Volkman          102                 6    492
#> 677             Mr. Almer Osinski          123                10    862
#> 678         Miss Kacie Miller DVM          169                10   1027
#> 679            Kadence Morissette          144                 7    613
#> 680                Melvin Schmidt           73                 6    673
#> 681                 Rosario Boyle          417                 5    512
#> 682               Wong Bradtke II          287                 3    280
#> 683               Yessenia Rempel          163                 4    236
#> 684           Mrs. Cali Considine          349                 5    416
#> 685                Helmer Monahan          331                 3    264
#> 686             Mittie Jacobs PhD          119                 4    292
#> 687                  Kenny Wisozk          182                 6    630
#> 688               Braulio Haag MD          186                 3    381
#> 689            Diandra Brakus DVM          557                 3    211
#> 690            Dr. Kelcie Yost MD          481                 7    646
#> 691                    Desi Ortiz          154                 7    626
#> 692               Dr. Alva Klocko          267                 5    548
#> 693          Dr. Alberto Kunze II          210                 7    669
#> 694                 Jadiel Wunsch          343                 5    714
#> 695                 Lashawn Hoppe          469                 5    437
#> 696              Charolette Klein          474                 4    602
#> 697                    Drew Rohan          432                 2    230
#> 698                    Bilal Hahn          588                 2    241
#> 699              Kingston Waelchi          533                 3    292
#> 700                 Iverson Robel          160                 9    880
#> 701         Mrs. Anice O'Hara DDS          360                 7    469
#> 702               Anjelica Klocko          458                 4    589
#> 703               Monique Reichel          532                 4    360
#> 704      Ms. Amaris Williamson MD          241                 5    289
#> 705                  Brayan Terry          601                 4    338
#> 706                 Elizah Abbott          102                 6    431
#> 707            Ms. Grecia Schultz          164                 6    357
#> 708     Dr. Gussie McLaughlin III          132                 5    471
#> 709                 Gonzalo Jones          100                 5    450
#> 710             Ossie Schaden PhD           44                 7    600
#> 711            Margarita O'Reilly          127                 4    649
#> 712              Prudie Kertzmann           88                 8    580
#> 713                 Hardy Leannon          136                 3    236
#> 714                 Russell Boyle          614                 2    265
#> 715              Dulce Wintheiser          490                 4    203
#> 716                  Chase Skiles          525                 6    728
#> 717          Mrs. Kelcie Schimmel          142                 7    536
#> 718               Sherlyn Gutmann           19                 9    726
#> 719               Toccara Lebsack          209                 6    433
#> 720                  Luka Langosh          412                 4    482
#> 721      Mrs. Melany Mitchell DDS          681                 1     12
#> 722               Kristian Heaney          681                 3    479
#> 723             Travis Cartwright           45                 8    713
#> 724                Devante O'Hara           81                 3    166
#> 725                Dorcas Friesen          655                 5    648
#> 726            Iverson Herman Sr.          106                 6    584
#> 727             Cherrelle Bartell           84                 6    277
#> 728               Mrs. Trudy Rath          387                 6    547
#> 729             Loretto Romaguera           84                 2    237
#> 730                 Malcolm Bogan          140                 5    565
#> 731                 Jimmie Herzog          265                 5    401
#> 732        Ms. Katrina Barton PhD          136                 7    774
#> 733                     Mae O'Kon          168                 3    249
#> 734            Dr. Ismael Stracke          491                 5    521
#> 735             Geralyn Rosenbaum           80                 5    393
#> 736          Mrs. Janel Koepp DVM          285                 4    253
#> 737                   Sol Zboncak          508                 3     88
#> 738                 Bernhard Lind          152                 4    375
#> 739                   Saint Doyle          190                 6    558
#> 740   Mr. Alessandro Weissnat DDS          174                 7    591
#> 741                   Jayme Welch          760                 1     23
#> 742            Winifred Hills DDS          180                 5    618
#> 743          Mr. Jimmy Mayert PhD          512                 4    382
#> 744                 Deena Ziemann          137                 4    422
#> 745              Dr. Ferd Stroman          183                 3    298
#> 746             Trina Gaylord DDS          198                 3    264
#> 747                Burton Kuvalis          259                 4    393
#> 748            Cameron Abbott DDS          108                 8    723
#> 749                 Bud Marquardt          521                 5    323
#> 750                Reanna O'Keefe           35                 8    960
#> 751          Valencia Keebler DVM          328                 5    369
#> 752                Alexis Cormier          150                 8    786
#> 753             Elizabet Schiller           62                 2    194
#> 754              Kordell Hartmann          478                 2    260
#> 755                 Bernard Bruen           72                 8    875
#> 756                    Mont Mertz          125                 3    261
#> 757          Pershing Johnston MD          296                 2    108
#> 758                  Tomika Koepp          249                 6    542
#> 759         Hughey Bartoletti DDS           73                10   1036
#> 760            Pierre Stoltenberg          618                 2     82
#> 761           Mr. Celestino Bosco          133                 7    716
#> 762               Arlyn Dickinson           39                 7    600
#> 763                  Lennon Hilll          431                 6    621
#> 764                Hakeem Leffler          264                 5    332
#> 765                 Juliana Sipes          190                 4    314
#> 766               Earnest Rolfson          148                 4    433
#> 767            Dr. Donal Auer DDS          284                 4    370
#> 768                Britany O'Hara           18                 7    330
#> 769                Brionna Miller          174                 4    374
#> 770                 Tisa Mosciski          229                 4    159
#> 771                   Deann Dicki          430                 3    205
#> 772          Mr. Michale Howe DVM          430                 8    740
#> 773              Mr. Mikeal Block          526                 5    323
#> 774             Ms. Elda Schmeler          129                 8    744
#> 775            Mr. Harris Pollich           21                 5    734
#> 776                  Shirl Wisozk          630                 4    363
#> 777                Symone McClure          207                 4    449
#> 778           Maralyn Greenfelder          162                 4    401
#> 779            Porsche Mayert DDS          496                 6    515
#> 780          Dr. Lynn Gleason Jr.          476                 3    114
#> 781                    Arno Blick           46                 4    388
#> 782              Lionel Marquardt          976                 1    133
#> 783                 Haden Kautzer          171                 2    236
#> 784                   Kole Crooks           92                 5    332
#> 785           Mr. Lon Witting Jr.          295                 3    413
#> 786                Alferd Ziemann          245                 5    697
#> 787       Dr. Eddie Armstrong DDS           64                 6    433
#> 788              Suzette Hartmann          291                 6    427
#> 789                Vinson Tillman          490                 4    454
#> 790              Woodie Gleichner          395                 5    277
#> 791              Miss Ela Treutel          397                 3    336
#> 792                 Lim Langworth          106                 5    424
#> 793        Miss Akeelah Walsh PhD          160                 7    779
#> 794                  Marty Wisozk          354                 5    347
#> 795               Iverson Hilpert          161                 2    149
#> 796                    Von Cassin          402                 5    350
#> 797              Nikolai Welch MD          192                 4    212
#> 798         Anabel Jakubowski PhD          164                 6    443
#> 799                  Vick Okuneva           52                 4    569
#> 800               Melbourne Johns          173                 3    260
#> 801               Davie Hintz PhD          430                 4    363
#> 802                   Lesta Davis          239                 3    152
#> 803                    Odie Lakin          442                 2    132
#> 804                   Nevin Boehm           86                 6    694
#> 805         Tawanda Balistreri MD          103                 4    393
#> 806          Mr. Kolten Wyman Jr.          495                 5    668
#> 807        Ms. Merrilee Lueilwitz          699                 1    185
#> 808               Elam Hirthe DVM          652                 6    546
#> 809      Mr. Elian Vandervort Jr.          195                 5    332
#> 810                   Janeen West           66                 5    374
#> 811                 Mac Kertzmann           43                 3    438
#> 812                    Uriah West          653                 3    195
#> 813            Portia Schamberger           49                 7    762
#> 814                 Ariane Hansen          455                 6    507
#> 815             Alvera Balistreri          127                 5    539
#> 816                Herman Kling I          371                 6    578
#> 817             Janell Heller DVM          488                 3    203
#> 818              Christi Connelly          114                 3    295
#> 819             Jeraldine Waelchi          146                 3    359
#> 820                   Kittie Dare          233                 4    441
#> 821             Dashawn Schroeder          589                 2    244
#> 822                Cristen Hammes          392                 5    402
#> 823                 Bradford Bode           13                 5    330
#> 824               Garfield Hammes          433                 5    644
#> 825                   Azul Wehner          932                 1    190
#> 826               Bush Macejkovic          203                 3    442
#> 827                Yaakov Labadie          582                 1     91
#> 828          Ms. Starr Corwin DDS          171                 4    228
#> 829              Pleasant Ullrich          319                 7   1089
#> 830              Alton Wintheiser          475                 5    392
#> 831                Regina Collins          234                 5    360
#> 832               Pansy Bergstrom           88                 5    394
#> 833               Milissa Batz MD           75                 4    643
#> 834                  Savion Rohan           84                10   1118
#> 835                 Zenas Pacocha          405                 4    442
#> 836         Tressie Buckridge DDS          404                 4    504
#> 837    Ms. Sarita Heidenreich DVM          305                 4    462
#> 838          Ms. Arletta Jast PhD          130                 7    720
#> 839   Dr. Jaheem Pfannerstill III          153                 6    641
#> 840                 Andra Goodwin           12                 4    202
#> 841                  Elgin Abbott          575                 2    233
#> 842            Mrs. Malaya Russel           93                 3    209
#> 843                Kenton Dickens          575                 8    872
#> 844                Girtha Douglas          165                 3    143
#> 845              Nikolas Shanahan          264                 5    268
#> 846              Collie Greenholt          261                 3    342
#> 847             Malcolm Heathcote            9                 4    431
#> 848                  Exie Shields          227                 3    251
#> 849               Bartley Collier          872                 2    141
#> 850                   Odessa Haag          586                 5    641
#> 851                   Dorris Jast          629                 4    549
#> 852                   Werner Hahn          169                 6    594
#> 853               Madison Koelpin          231                 3    388
#> 854                   Andra Bosco          156                 4    225
#> 855          Rosevelt Murazik DDS          139                 5    447
#> 856                Letitia Stokes          175                 8    536
#> 857              Pershing Torp II          490                 2    241
#> 858                  Aleena Berge          102                 4    393
#> 859             Mr. Cayden Waters          120                 4    232
#> 860                Anastasia Howe          339                 4    425
#> 861              Lovisa Wilkinson          471                 3    311
#> 862                 Forest Pouros          613                 3    455
#> 863                Jacquez Jacobs          375                 2     87
#> 864             Gianna Stiedemann           30                 7    759
#> 865                    Zeno Lakin          524                 1     38
#> 866           Dr. Romeo Sauer PhD          276                 3    312
#> 867            Dominick Jewess IV          186                 4    575
#> 868                   Wendi Purdy          490                 5    560
#> 869                 Braiden Bogan          479                 5    470
#> 870                  Elaine Emard          480                 4    301
#> 871         Dr. Mallory Dooley MD          399                 1     33
#> 872                 Willian Runte          157                 7    754
#> 873          Dr. Buffy Williamson          298                 3    353
#> 874                  Pink Murazik          449                 2    225
#> 875                 Robbin Herzog          366                 4    381
#> 876                Sharyn Barrows          155                 6    292
#> 877               Bennett Gleason          202                 1     37
#> 878              Jerrell Wisozk I          113                 7    764
#> 879                Latifah Carter          146                 4    601
#> 880                 Jazmin Harvey           34                 5    874
#> 881       Verlin Christiansen Sr.          389                 4    491
#> 882            Mr. Vito Ernser II           13                 5    461
#> 883                Kendal Wiegand          137                 6    712
#> 884             Mr. Cletus Corwin          558                 2     81
#> 885            Dr. Fredrick Klein          199                 6    471
#> 886                    Murl Dicki          178                 2    233
#> 887       Mr. Hunter Botsford Jr.          613                 2    267
#> 888                 Imelda Harber          455                 6    474
#> 889           Hassie Schiller PhD          187                 2    119
#> 890                Harlon Rolfson          449                 7    603
#> 891                  Ginger Stamm           34                 3    248
#> 892                 Dell Mitchell          359                 2    231
#> 893                Friend Stracke          456                 6    571
#> 894                    Moe Sawayn          522                 2    176
#> 895                Ewart Luettgen          528                 2    252
#> 896                   Karren Funk          449                 3    353
#> 897              Braydon Lindgren          176                 1    188
#> 898                 Joe McDermott          390                 3    317
#> 899                Darci Schaefer          583                 2    198
#> 900           Mr. Wilkie Moore MD          836                 2    244
#> 901                Aden Lesch Sr.          194                 4    405
#> 902                     Dema Beer           23                 4    251
#> 903          Shoji Wintheiser III          140                 5    329
#> 904                 Virgel Grimes          173                 5    675
#> 905                  Carmel Emard          182                 3    143
#> 906                     Katy King          246                 6    653
#> 907                Dyllan Osinski           47                 1    155
#> 908                   Sadie Upton          151                 4    541
#> 909  Mrs. Charolette McDermott MD          139                 1     82
#> 910                    Ean Raynor          499                 2     77
#> 911        Dr. Arnoldo Grimes PhD          282                 3    398
#> 912           Mr. Jeramiah Cronin            6                 6    547
#> 913                 Elinore Doyle           83                 7    531
#> 914                 Florine Jones          509                 4    269
#> 915           Gerold Bernhard Jr.          126                 2    149
#> 916                   Odie Jacobs          484                 3    353
#> 917                Mahlon Pfeffer          507                 3    166
#> 918            Dr. Humphrey Grant          164                 2    138
#> 919             Rob Wilderman Sr.          624                 1     34
#> 920               Mansfield Boyle          465                 6    640
#> 921              Jevon Rutherford          391                 2    268
#> 922       Dr. Halley Johnston PhD          399                 3    266
#> 923                  Glennis Howe          101                 3    188
#> 924                   Beda Paucek          488                 2    198
#> 925             Alessandra Heaney          168                 1     28
#> 926          Dr. Fleming Grant IV          686                 2    172
#> 927          Mr. Fredric Funk III          439                 3    228
#> 928          Dr. Rene Kuhlman DDS          515                 3    355
#> 929               Tamia Langworth          576                 1    103
#> 930                Anie Hettinger          444                 3    325
#> 931                  Olaf Witting          191                 2    143
#> 932             Aiyanna Bruen PhD          246                 4    157
#> 933               Rafael Mitchell          550                 3    421
#> 934                 Davian Stokes          143                 4    385
#> 935                Coley Lind Sr.          307                 3    439
#> 936            Dr. Fronnie Kemmer          531                 3    363
#> 937           Miss Velma Schulist          464                 3    224
#> 938             Dr. Flint Zboncak          327                 4    277
#> 939              Rollie Yundt DVM          600                 3    467
#> 940              Lacy Connelly MD          466                 4    113
#> 941            Corrina Little DDS          592                 3    484
#> 942             Orville Lemke III          215                 3    147
#> 943            Christal Lakin DDS          458                 3    491
#> 944                  Venice Smith          484                 3    219
#> 945             Charls Rempel DDS          155                 2    187
#> 946                 Livia Pfeffer          436                 2    139
#> 947                  Juliet Terry          410                 2    218
#> 948                 Hobson Barton          516                 1    102
#> 949                  Nyree Walker          550                 3    211
#> 950             Ms. Valorie Kling          155                 5    421
#> 951                  Darwyn Berge          480                 2     62
#> 952        Mozell Greenfelder DDS           37                 5    417
#> 953              Olen Steuber DVM          520                 1     39
#> 954                  Geri Wuckert          599                 1     86
#> 955              Miss Aleen Kunze          396                 2    320
#> 956                 Davion Hudson          251                 2    172
#> 957                      Link Orn          955                 1     61
#> 958                 Maxie Steuber          113                 2    181
#> 959               Dr. Kyra Littel          334                 4    259
#> 960                   Watt Cremin          127                 1     52
#> 961                  Laurel Morar          172                 5    230
#> 962         Dr. Wilfredo Wisozk V          477                 3    332
#> 963                Garrison Kling           28                 3    294
#> 964                  Daija Legros           30                 4    432
#> 965               Kristy Kunde MD          350                 4    242
#> 966                  Shaun Rempel          180                 4    427
#> 967                  Raheem Bosco          124                 4    182
#> 968                    Deion Auer          847                 4    328
#> 969                 Lollie Conroy          578                 2     94
#> 970                Asha Ankunding          399                 3     81
#> 971    Mrs. Carolann Anderson PhD          590                 3    217
#> 972           Dr. Karissa Kerluke          700                 1     57
#> 973                  Karen Harvey          249                 4    229
#> 974                   Carlyn Mann          172                 2    171
#> 975           Dr. Howard Zulauf V          569                 1    113
#> 976                      Kyla Orn           90                 4    251
#> 977             Loretta Lueilwitz          651                 1     79
#> 978              Neppie Armstrong          607                 1    219
#> 979              Anderson Quitzon          676                 3    287
#> 980         Mr. Marcelo Wunsch MD          446                 1     52
#> 981               Vernell Lockman          236                 1    153
#> 982            Mr. Dandre Nolan I          951                 1     30
#> 983                  Jerald Hintz          179                 3    286
#> 984                Tegan O'Conner          177                 2    199
#> 985                  Paulo Torphy          892                 2    219
#> 986                Errol Bogisich          684                 1     81
#> 987                   Joann Yundt          604                 2    223
#> 988             Dr. Matteo Little           93                 4    311
#> 989           Dr. Kloe Parker DVM          113                 4    289
#> 990                     Elon Haag          696                 1     32
#> 991            Miss Anaya Kerluke          687                 1    104
#> 992                 Alex Bergnaum          239                 1    175
#> 993               Dudley Franecki          222                 2    375
#> 994            Ms. Ermine Krajcik          595                 1    106
#> 995                  Cristy Ferry          559                 1    172
#>     recency_score frequency_score monetary_score rfm_score
#> 1               3               5              5       355
#> 2               3               5              4       354
#> 3               1               2              2       122
#> 4               5               5              5       555
#> 5               5               3              3       533
#> 6               4               5              5       455
#> 7               1               3              4       134
#> 8               2               2              2       222
#> 9               3               4              5       345
#> 10              4               5              5       455
#> 11              1               1              2       112
#> 12              5               2              2       522
#> 13              5               4              4       544
#> 14              4               3              3       433
#> 15              5               4              4       544
#> 16              4               3              3       433
#> 17              3               3              3       333
#> 18              4               4              4       444
#> 19              2               5              5       255
#> 20              4               5              5       455
#> 21              5               2              1       521
#> 22              1               3              5       135
#> 23              5               5              5       555
#> 24              3               4              5       345
#> 25              5               1              2       512
#> 26              2               1              1       211
#> 27              3               3              3       333
#> 28              2               3              4       234
#> 29              4               2              2       422
#> 30              3               2              3       323
#> 31              3               2              2       322
#> 32              3               3              4       334
#> 33              1               1              1       111
#> 34              3               4              4       344
#> 35              3               4              2       342
#> 36              2               2              2       222
#> 37              3               2              2       322
#> 38              3               3              3       333
#> 39              5               3              2       532
#> 40              3               3              3       333
#> 41              2               1              2       212
#> 42              4               4              5       445
#> 43              3               5              5       355
#> 44              3               5              5       355
#> 45              4               2              2       422
#> 46              5               5              5       555
#> 47              1               1              3       113
#> 48              1               4              3       143
#> 49              3               2              2       322
#> 50              2               5              5       255
#> 51              5               5              5       555
#> 52              5               1              3       513
#> 53              3               4              4       344
#> 54              4               5              5       455
#> 55              3               2              2       322
#> 56              2               4              4       244
#> 57              4               4              4       444
#> 58              2               2              4       224
#> 59              3               4              3       343
#> 60              5               5              5       555
#> 61              5               1              1       511
#> 62              1               3              5       135
#> 63              2               2              2       222
#> 64              3               2              2       322
#> 65              5               1              2       512
#> 66              2               5              5       255
#> 67              3               4              4       344
#> 68              3               1              2       312
#> 69              1               2              1       121
#> 70              5               1              1       511
#> 71              2               1              1       211
#> 72              4               4              4       444
#> 73              2               1              1       211
#> 74              5               5              5       555
#> 75              2               4              3       243
#> 76              2               2              3       223
#> 77              5               4              5       545
#> 78              3               5              3       353
#> 79              5               4              3       543
#> 80              3               3              4       334
#> 81              1               2              3       123
#> 82              4               3              3       433
#> 83              3               1              1       311
#> 84              5               2              3       523
#> 85              1               1              1       111
#> 86              5               4              3       543
#> 87              3               3              4       334
#> 88              4               5              4       454
#> 89              1               2              3       123
#> 90              2               2              3       223
#> 91              3               5              5       355
#> 92              1               4              4       144
#> 93              4               5              5       455
#> 94              4               5              5       455
#> 95              1               4              3       143
#> 96              2               4              4       244
#> 97              2               4              5       245
#> 98              5               5              5       555
#> 99              2               1              3       213
#> 100             2               4              5       245
#> 101             2               2              3       223
#> 102             4               4              5       445
#> 103             2               4              3       243
#> 104             1               2              3       123
#> 105             3               3              4       334
#> 106             3               4              4       344
#> 107             5               5              4       554
#> 108             2               4              5       245
#> 109             4               1              2       412
#> 110             5               5              5       555
#> 111             2               3              4       234
#> 112             2               4              5       245
#> 113             3               1              1       311
#> 114             3               4              3       343
#> 115             2               5              5       255
#> 116             4               3              2       432
#> 117             1               2              3       123
#> 118             1               1              1       111
#> 119             4               2              3       423
#> 120             3               4              5       345
#> 121             1               3              3       133
#> 122             5               2              1       521
#> 123             1               1              1       111
#> 124             4               4              5       445
#> 125             1               3              5       135
#> 126             4               5              5       455
#> 127             3               2              2       322
#> 128             2               4              4       244
#> 129             3               1              1       311
#> 130             3               4              5       345
#> 131             3               1              1       311
#> 132             3               2              1       321
#> 133             3               4              5       345
#> 134             5               5              5       555
#> 135             5               4              3       543
#> 136             5               3              3       533
#> 137             3               4              4       344
#> 138             4               2              2       422
#> 139             5               3              3       533
#> 140             5               3              3       533
#> 141             4               4              4       444
#> 142             2               2              2       222
#> 143             5               3              2       532
#> 144             2               5              5       255
#> 145             1               1              2       112
#> 146             3               2              2       322
#> 147             1               2              4       124
#> 148             4               5              5       455
#> 149             3               4              2       342
#> 150             2               1              2       212
#> 151             4               4              4       444
#> 152             5               3              4       534
#> 153             1               2              4       124
#> 154             1               1              2       112
#> 155             5               4              4       544
#> 156             5               4              4       544
#> 157             5               1              1       511
#> 158             5               5              5       555
#> 159             5               3              3       533
#> 160             2               5              5       255
#> 161             5               5              5       555
#> 162             2               2              2       222
#> 163             4               5              5       455
#> 164             1               1              1       111
#> 165             5               4              3       543
#> 166             3               4              5       345
#> 167             4               2              3       423
#> 168             5               5              5       555
#> 169             5               2              2       522
#> 170             3               3              2       332
#> 171             2               3              4       234
#> 172             5               4              3       543
#> 173             1               2              3       123
#> 174             5               4              4       544
#> 175             1               1              2       112
#> 176             5               5              5       555
#> 177             3               1              1       311
#> 178             4               3              3       433
#> 179             4               5              5       455
#> 180             4               3              3       433
#> 181             4               3              3       433
#> 182             2               4              3       243
#> 183             5               3              2       532
#> 184             4               5              5       455
#> 185             1               2              3       123
#> 186             5               4              4       544
#> 187             2               5              5       255
#> 188             2               4              3       243
#> 189             4               5              5       455
#> 190             1               1              2       112
#> 191             2               1              1       211
#> 192             3               3              4       334
#> 193             3               2              2       322
#> 194             5               1              1       511
#> 195             4               4              4       444
#> 196             3               3              3       333
#> 197             5               2              3       523
#> 198             5               2              2       522
#> 199             1               2              1       121
#> 200             4               2              5       425
#> 201             4               4              3       443
#> 202             3               3              1       331
#> 203             1               3              3       133
#> 204             2               1              1       211
#> 205             2               4              4       244
#> 206             4               4              3       443
#> 207             3               2              2       322
#> 208             5               2              3       523
#> 209             5               5              5       555
#> 210             3               5              4       354
#> 211             2               4              4       244
#> 212             2               4              5       245
#> 213             4               1              1       411
#> 214             1               2              2       122
#> 215             3               3              3       333
#> 216             4               3              4       434
#> 217             2               2              3       223
#> 218             4               1              1       411
#> 219             5               5              5       555
#> 220             4               2              3       423
#> 221             3               4              4       344
#> 222             3               5              5       355
#> 223             4               2              3       423
#> 224             5               1              1       511
#> 225             4               1              3       413
#> 226             5               5              5       555
#> 227             5               3              3       533
#> 228             4               2              2       422
#> 229             3               4              5       345
#> 230             4               3              4       434
#> 231             2               4              2       242
#> 232             1               2              3       123
#> 233             2               1              1       211
#> 234             4               3              5       435
#> 235             1               1              1       111
#> 236             4               5              5       455
#> 237             1               2              3       123
#> 238             2               4              4       244
#> 239             3               2              2       322
#> 240             5               4              5       545
#> 241             2               4              5       245
#> 242             5               2              2       522
#> 243             4               4              5       445
#> 244             4               3              2       432
#> 245             1               1              2       112
#> 246             4               4              4       444
#> 247             5               3              3       533
#> 248             4               4              4       444
#> 249             2               4              2       242
#> 250             5               4              2       542
#> 251             5               2              2       522
#> 252             3               2              2       322
#> 253             2               5              5       255
#> 254             3               2              4       324
#> 255             4               4              5       445
#> 256             2               5              5       255
#> 257             1               1              1       111
#> 258             4               5              5       455
#> 259             2               4              4       244
#> 260             1               1              2       112
#> 261             4               1              1       411
#> 262             5               4              4       544
#> 263             2               1              2       212
#> 264             1               1              1       111
#> 265             3               5              5       355
#> 266             1               4              4       144
#> 267             5               5              5       555
#> 268             5               4              4       544
#> 269             4               3              3       433
#> 270             4               4              5       445
#> 271             5               4              2       542
#> 272             3               4              5       345
#> 273             3               4              5       345
#> 274             4               5              5       455
#> 275             5               1              2       512
#> 276             4               3              4       434
#> 277             2               5              5       255
#> 278             1               1              1       111
#> 279             1               3              5       135
#> 280             4               5              5       455
#> 281             3               4              3       343
#> 282             2               3              3       233
#> 283             3               3              5       335
#> 284             2               2              3       223
#> 285             5               1              1       511
#> 286             3               4              4       344
#> 287             3               5              5       355
#> 288             4               5              5       455
#> 289             3               5              5       355
#> 290             5               2              4       524
#> 291             2               2              3       223
#> 292             2               4              3       243
#> 293             3               4              4       344
#> 294             2               3              4       234
#> 295             5               2              1       521
#> 296             2               4              5       245
#> 297             2               1              4       214
#> 298             3               3              2       332
#> 299             4               4              4       444
#> 300             3               2              2       322
#> 301             4               4              5       445
#> 302             5               1              2       512
#> 303             4               5              5       455
#> 304             4               3              3       433
#> 305             2               4              4       244
#> 306             4               5              5       455
#> 307             2               4              4       244
#> 308             3               5              4       354
#> 309             1               4              4       144
#> 310             3               4              5       345
#> 311             2               4              5       245
#> 312             2               3              3       233
#> 313             3               3              4       334
#> 314             5               4              5       545
#> 315             3               3              1       331
#> 316             4               4              4       444
#> 317             3               3              3       333
#> 318             5               4              4       544
#> 319             4               4              3       443
#> 320             3               1              1       311
#> 321             1               4              5       145
#> 322             4               2              4       424
#> 323             1               2              2       122
#> 324             1               1              1       111
#> 325             2               4              5       245
#> 326             1               1              2       112
#> 327             5               5              4       554
#> 328             3               5              5       355
#> 329             3               3              4       334
#> 330             4               4              5       445
#> 331             4               2              3       423
#> 332             3               3              3       333
#> 333             1               3              4       134
#> 334             3               4              2       342
#> 335             4               5              5       455
#> 336             3               5              5       355
#> 337             4               3              3       433
#> 338             1               1              4       114
#> 339             3               4              5       345
#> 340             5               2              3       523
#> 341             3               4              4       344
#> 342             3               3              3       333
#> 343             3               4              4       344
#> 344             4               5              5       455
#> 345             3               2              3       323
#> 346             2               4              3       243
#> 347             1               1              1       111
#> 348             4               1              2       412
#> 349             1               2              1       121
#> 350             2               5              5       255
#> 351             5               5              5       555
#> 352             5               3              3       533
#> 353             4               4              5       445
#> 354             5               1              3       513
#> 355             3               4              4       344
#> 356             1               3              2       132
#> 357             1               3              4       134
#> 358             2               3              4       234
#> 359             3               4              2       342
#> 360             1               1              3       113
#> 361             5               5              5       555
#> 362             4               4              5       445
#> 363             5               2              2       522
#> 364             4               4              4       444
#> 365             3               5              5       355
#> 366             5               3              5       535
#> 367             1               2              1       121
#> 368             3               3              1       331
#> 369             2               3              4       234
#> 370             3               3              4       334
#> 371             3               3              4       334
#> 372             4               4              3       443
#> 373             1               4              5       145
#> 374             1               1              1       111
#> 375             5               5              5       555
#> 376             5               4              3       543
#> 377             3               4              4       344
#> 378             1               4              2       142
#> 379             2               3              4       234
#> 380             3               4              2       342
#> 381             5               4              4       544
#> 382             1               1              1       111
#> 383             4               4              5       445
#> 384             1               4              5       145
#> 385             3               1              4       314
#> 386             2               4              5       245
#> 387             2               3              3       233
#> 388             4               2              1       421
#> 389             1               1              1       111
#> 390             2               5              5       255
#> 391             2               2              2       222
#> 392             4               5              5       455
#> 393             4               2              2       422
#> 394             3               2              3       323
#> 395             5               3              4       534
#> 396             5               4              4       544
#> 397             1               1              1       111
#> 398             3               3              4       334
#> 399             4               1              1       411
#> 400             2               1              2       212
#> 401             3               3              2       332
#> 402             5               5              5       555
#> 403             4               5              4       454
#> 404             2               3              5       235
#> 405             4               2              2       422
#> 406             3               1              2       312
#> 407             3               1              1       311
#> 408             4               4              5       445
#> 409             3               5              5       355
#> 410             3               3              3       333
#> 411             1               3              4       134
#> 412             1               3              4       134
#> 413             1               2              4       124
#> 414             5               4              4       544
#> 415             2               2              2       222
#> 416             3               1              1       311
#> 417             2               1              2       212
#> 418             4               2              2       422
#> 419             4               3              1       431
#> 420             4               2              3       423
#> 421             5               4              4       544
#> 422             3               4              5       345
#> 423             5               5              5       555
#> 424             1               1              2       112
#> 425             2               1              3       213
#> 426             3               4              4       344
#> 427             4               4              3       443
#> 428             2               1              1       211
#> 429             5               4              4       544
#> 430             3               5              5       355
#> 431             1               3              4       134
#> 432             5               4              4       544
#> 433             2               5              5       255
#> 434             2               3              3       233
#> 435             5               2              3       523
#> 436             3               4              4       344
#> 437             2               3              4       234
#> 438             1               4              5       145
#> 439             3               3              2       332
#> 440             3               4              5       345
#> 441             3               4              4       344
#> 442             4               2              4       424
#> 443             3               1              1       311
#> 444             4               1              1       411
#> 445             3               1              2       312
#> 446             5               5              5       555
#> 447             3               2              1       321
#> 448             1               1              1       111
#> 449             4               4              5       445
#> 450             2               3              4       234
#> 451             5               3              2       532
#> 452             3               1              1       311
#> 453             1               2              2       122
#> 454             1               1              1       111
#> 455             2               1              1       211
#> 456             2               5              5       255
#> 457             5               2              2       522
#> 458             1               1              2       112
#> 459             1               1              2       112
#> 460             1               1              2       112
#> 461             5               3              5       535
#> 462             4               4              5       445
#> 463             1               3              3       133
#> 464             3               1              2       312
#> 465             2               4              3       243
#> 466             4               5              5       455
#> 467             2               1              1       211
#> 468             5               1              2       512
#> 469             1               1              1       111
#> 470             2               4              4       244
#> 471             2               3              3       233
#> 472             4               2              2       422
#> 473             2               4              4       244
#> 474             5               4              5       545
#> 475             1               3              2       132
#> 476             1               1              2       112
#> 477             5               5              3       553
#> 478             2               2              4       224
#> 479             5               3              4       534
#> 480             5               2              3       523
#> 481             2               3              4       234
#> 482             5               1              2       512
#> 483             3               3              3       333
#> 484             4               4              5       445
#> 485             5               5              5       555
#> 486             3               2              2       322
#> 487             4               5              5       455
#> 488             5               4              3       543
#> 489             2               4              4       244
#> 490             1               3              5       135
#> 491             3               2              4       324
#> 492             3               3              1       331
#> 493             1               1              1       111
#> 494             1               1              1       111
#> 495             3               4              3       343
#> 496             4               4              3       443
#> 497             3               2              3       323
#> 498             1               4              3       143
#> 499             5               3              2       532
#> 500             2               3              3       233
#> 501             2               5              5       255
#> 502             3               4              4       344
#> 503             5               3              3       533
#> 504             1               1              1       111
#> 505             1               1              1       111
#> 506             5               1              3       513
#> 507             4               4              4       444
#> 508             3               1              3       313
#> 509             4               2              1       421
#> 510             1               4              4       144
#> 511             5               4              4       544
#> 512             5               4              3       543
#> 513             2               4              3       243
#> 514             5               4              5       545
#> 515             3               5              5       355
#> 516             3               4              4       344
#> 517             5               4              3       543
#> 518             3               4              4       344
#> 519             1               1              2       112
#> 520             3               3              4       334
#> 521             5               1              1       511
#> 522             2               3              4       234
#> 523             3               1              2       312
#> 524             3               4              5       345
#> 525             2               1              1       211
#> 526             5               1              1       511
#> 527             2               2              2       222
#> 528             5               4              5       545
#> 529             4               3              2       432
#> 530             2               3              5       235
#> 531             5               4              4       544
#> 532             2               1              1       211
#> 533             3               5              5       355
#> 534             1               5              5       155
#> 535             1               2              4       124
#> 536             4               2              2       422
#> 537             5               4              3       543
#> 538             2               3              4       234
#> 539             1               1              2       112
#> 540             1               2              3       123
#> 541             4               1              1       411
#> 542             2               3              4       234
#> 543             2               4              5       245
#> 544             2               1              1       211
#> 545             2               1              2       212
#> 546             1               2              3       123
#> 547             2               5              5       255
#> 548             2               1              4       214
#> 549             1               1              2       112
#> 550             4               5              5       455
#> 551             2               2              2       222
#> 552             2               2              3       223
#> 553             4               4              3       443
#> 554             5               3              2       532
#> 555             1               2              1       121
#> 556             4               4              2       442
#> 557             5               5              5       555
#> 558             1               1              1       111
#> 559             5               4              2       542
#> 560             3               4              2       342
#> 561             1               1              1       111
#> 562             2               4              4       244
#> 563             2               4              5       245
#> 564             5               3              4       534
#> 565             1               4              4       144
#> 566             3               4              5       345
#> 567             3               4              4       344
#> 568             1               4              3       143
#> 569             1               1              1       111
#> 570             4               2              2       422
#> 571             1               1              2       112
#> 572             4               5              4       454
#> 573             4               1              2       412
#> 574             3               1              1       311
#> 575             5               2              2       522
#> 576             4               3              2       432
#> 577             1               3              2       132
#> 578             5               3              4       534
#> 579             2               3              4       234
#> 580             1               1              2       112
#> 581             1               3              3       133
#> 582             5               2              2       522
#> 583             3               3              3       333
#> 584             2               3              4       234
#> 585             2               1              1       211
#> 586             3               3              3       333
#> 587             4               2              2       422
#> 588             1               4              3       143
#> 589             2               4              4       244
#> 590             2               4              4       244
#> 591             3               2              1       321
#> 592             3               4              4       344
#> 593             2               3              3       233
#> 594             4               3              4       434
#> 595             3               2              2       322
#> 596             2               4              3       243
#> 597             5               5              5       555
#> 598             4               3              4       434
#> 599             4               2              3       423
#> 600             3               2              4       324
#> 601             5               4              4       544
#> 602             4               2              3       423
#> 603             4               5              5       455
#> 604             2               2              2       222
#> 605             5               4              5       545
#> 606             4               3              3       433
#> 607             2               1              2       212
#> 608             2               4              5       245
#> 609             2               2              3       223
#> 610             1               4              4       144
#> 611             2               2              3       223
#> 612             1               1              3       113
#> 613             4               5              4       454
#> 614             3               3              4       334
#> 615             4               4              3       443
#> 616             5               2              4       524
#> 617             5               4              4       544
#> 618             5               5              5       555
#> 619             3               3              2       332
#> 620             1               4              3       143
#> 621             2               2              4       224
#> 622             5               4              2       542
#> 623             5               3              3       533
#> 624             4               2              2       422
#> 625             4               2              2       422
#> 626             4               3              2       432
#> 627             4               3              3       433
#> 628             1               5              4       154
#> 629             4               4              5       445
#> 630             4               5              5       455
#> 631             2               4              2       242
#> 632             5               5              4       554
#> 633             3               3              3       333
#> 634             4               1              3       413
#> 635             2               5              5       255
#> 636             5               4              4       544
#> 637             3               3              4       334
#> 638             2               2              3       223
#> 639             2               3              4       234
#> 640             5               5              5       555
#> 641             5               4              4       544
#> 642             5               1              1       511
#> 643             5               1              3       513
#> 644             1               1              1       111
#> 645             3               5              5       355
#> 646             3               4              4       344
#> 647             4               3              3       433
#> 648             1               1              1       111
#> 649             5               2              4       524
#> 650             4               1              2       412
#> 651             2               5              5       255
#> 652             1               1              2       112
#> 653             5               4              4       544
#> 654             3               4              4       344
#> 655             3               3              3       333
#> 656             1               2              4       124
#> 657             2               1              2       212
#> 658             1               4              2       142
#> 659             4               4              4       444
#> 660             5               3              3       533
#> 661             5               4              5       545
#> 662             1               1              2       112
#> 663             1               1              2       112
#> 664             3               4              3       343
#> 665             1               2              1       121
#> 666             4               4              3       443
#> 667             5               2              4       524
#> 668             4               4              5       445
#> 669             1               1              2       112
#> 670             1               4              5       145
#> 671             5               2              1       521
#> 672             3               5              5       355
#> 673             2               2              4       224
#> 674             4               4              2       442
#> 675             5               2              2       522
#> 676             5               4              3       543
#> 677             4               5              5       455
#> 678             4               5              5       455
#> 679             4               4              4       444
#> 680             5               4              5       545
#> 681             2               3              4       234
#> 682             3               1              2       312
#> 683             4               2              1       421
#> 684             2               3              3       233
#> 685             2               1              2       212
#> 686             4               2              2       422
#> 687             3               4              4       344
#> 688             3               1              2       312
#> 689             1               1              1       111
#> 690             2               4              4       244
#> 691             4               4              4       444
#> 692             3               3              4       334
#> 693             3               4              5       345
#> 694             2               3              5       235
#> 695             2               3              3       233
#> 696             2               2              4       224
#> 697             2               1              1       211
#> 698             1               1              1       111
#> 699             1               1              2       112
#> 700             4               5              5       455
#> 701             2               4              3       243
#> 702             2               2              4       224
#> 703             1               2              2       122
#> 704             3               3              2       332
#> 705             1               2              2       122
#> 706             5               4              3       543
#> 707             4               4              2       442
#> 708             4               3              3       433
#> 709             5               3              3       533
#> 710             5               4              4       544
#> 711             4               2              4       424
#> 712             5               5              4       554
#> 713             4               1              1       411
#> 714             1               1              2       112
#> 715             1               2              1       121
#> 716             1               4              5       145
#> 717             4               4              4       444
#> 718             5               5              5       555
#> 719             3               4              3       343
#> 720             2               2              3       223
#> 721             1               1              1       111
#> 722             1               1              3       113
#> 723             5               5              5       555
#> 724             5               1              1       511
#> 725             1               3              4       134
#> 726             5               4              4       544
#> 727             5               4              2       542
#> 728             2               4              4       244
#> 729             5               1              1       511
#> 730             4               3              4       434
#> 731             3               3              3       333
#> 732             4               4              5       445
#> 733             4               1              1       411
#> 734             1               3              4       134
#> 735             5               3              3       533
#> 736             3               2              1       321
#> 737             1               1              1       111
#> 738             4               2              2       422
#> 739             3               4              4       344
#> 740             4               4              4       444
#> 741             1               1              1       111
#> 742             4               3              4       434
#> 743             1               2              3       123
#> 744             4               2              3       423
#> 745             3               1              2       312
#> 746             3               1              2       312
#> 747             3               2              3       323
#> 748             5               5              5       555
#> 749             1               3              2       132
#> 750             5               5              5       555
#> 751             2               3              2       232
#> 752             4               5              5       455
#> 753             5               1              1       511
#> 754             2               1              2       212
#> 755             5               5              5       555
#> 756             4               1              2       412
#> 757             3               1              1       311
#> 758             3               4              4       344
#> 759             5               5              5       555
#> 760             1               1              1       111
#> 761             4               4              5       445
#> 762             5               4              4       544
#> 763             2               4              4       244
#> 764             3               3              2       332
#> 765             3               2              2       322
#> 766             4               2              3       423
#> 767             3               2              2       322
#> 768             5               4              2       542
#> 769             4               2              2       422
#> 770             3               2              1       321
#> 771             2               1              1       211
#> 772             2               5              5       255
#> 773             1               3              2       132
#> 774             4               5              5       455
#> 775             5               3              5       535
#> 776             1               2              2       122
#> 777             3               2              3       323
#> 778             4               2              3       423
#> 779             1               4              4       144
#> 780             2               1              1       211
#> 781             5               2              3       523
#> 782             1               1              1       111
#> 783             4               1              1       411
#> 784             5               3              2       532
#> 785             3               1              3       313
#> 786             3               3              5       335
#> 787             5               4              3       543
#> 788             3               4              3       343
#> 789             1               2              3       123
#> 790             2               3              2       232
#> 791             2               1              2       212
#> 792             5               3              3       533
#> 793             4               4              5       445
#> 794             2               3              2       232
#> 795             4               1              1       411
#> 796             2               3              2       232
#> 797             3               2              1       321
#> 798             4               4              3       443
#> 799             5               2              4       524
#> 800             4               1              2       412
#> 801             2               2              2       222
#> 802             3               1              1       311
#> 803             2               1              1       211
#> 804             5               4              5       545
#> 805             5               2              3       523
#> 806             1               3              5       135
#> 807             1               1              1       111
#> 808             1               4              4       144
#> 809             3               3              2       332
#> 810             5               3              2       532
#> 811             5               1              3       513
#> 812             1               1              1       111
#> 813             5               4              5       545
#> 814             2               4              4       244
#> 815             4               3              4       434
#> 816             2               4              4       244
#> 817             1               1              1       111
#> 818             5               1              2       512
#> 819             4               1              2       412
#> 820             3               2              3       323
#> 821             1               1              1       111
#> 822             2               3              3       233
#> 823             5               3              2       532
#> 824             2               3              4       234
#> 825             1               1              1       111
#> 826             3               1              3       313
#> 827             1               1              1       111
#> 828             4               2              1       421
#> 829             2               4              5       245
#> 830             2               3              3       233
#> 831             3               3              2       332
#> 832             5               3              3       533
#> 833             5               2              4       524
#> 834             5               5              5       555
#> 835             2               2              3       223
#> 836             2               2              3       223
#> 837             2               2              3       223
#> 838             4               4              5       445
#> 839             4               4              4       444
#> 840             5               2              1       521
#> 841             1               1              1       111
#> 842             5               1              1       511
#> 843             1               5              5       155
#> 844             4               1              1       411
#> 845             3               3              2       332
#> 846             3               1              2       312
#> 847             5               2              3       523
#> 848             3               1              1       311
#> 849             1               1              1       111
#> 850             1               3              4       134
#> 851             1               2              4       124
#> 852             4               4              4       444
#> 853             3               1              3       313
#> 854             4               2              1       421
#> 855             4               3              3       433
#> 856             4               5              4       454
#> 857             1               1              1       111
#> 858             5               2              3       523
#> 859             4               2              1       421
#> 860             2               2              3       223
#> 861             2               1              2       212
#> 862             1               1              3       113
#> 863             2               1              1       211
#> 864             5               4              5       545
#> 865             1               1              1       111
#> 866             3               1              2       312
#> 867             3               2              4       324
#> 868             1               3              4       134
#> 869             2               3              3       233
#> 870             2               2              2       222
#> 871             2               1              1       211
#> 872             4               4              5       445
#> 873             2               1              2       212
#> 874             2               1              1       211
#> 875             2               2              2       222
#> 876             4               4              2       442
#> 877             3               1              1       311
#> 878             5               4              5       545
#> 879             4               2              4       424
#> 880             5               3              5       535
#> 881             2               2              3       223
#> 882             5               3              3       533
#> 883             4               4              5       445
#> 884             1               1              1       111
#> 885             3               4              3       343
#> 886             4               1              1       411
#> 887             1               1              2       112
#> 888             2               4              3       243
#> 889             3               1              1       311
#> 890             2               4              4       244
#> 891             5               1              1       511
#> 892             2               1              1       211
#> 893             2               4              4       244
#> 894             1               1              1       111
#> 895             1               1              1       111
#> 896             2               1              2       212
#> 897             4               1              1       411
#> 898             2               1              2       212
#> 899             1               1              1       111
#> 900             1               1              1       111
#> 901             3               2              3       323
#> 902             5               2              1       521
#> 903             4               3              2       432
#> 904             4               3              5       435
#> 905             3               1              1       311
#> 906             3               4              4       344
#> 907             5               1              1       511
#> 908             4               2              4       424
#> 909             4               1              1       411
#> 910             1               1              1       111
#> 911             3               1              3       313
#> 912             5               4              4       544
#> 913             5               4              4       544
#> 914             1               2              2       122
#> 915             4               1              1       411
#> 916             1               1              2       112
#> 917             1               1              1       111
#> 918             4               1              1       411
#> 919             1               1              1       111
#> 920             2               4              4       244
#> 921             2               1              2       212
#> 922             2               1              2       212
#> 923             5               1              1       511
#> 924             1               1              1       111
#> 925             4               1              1       411
#> 926             1               1              1       111
#> 927             2               1              1       211
#> 928             1               1              2       112
#> 929             1               1              1       111
#> 930             2               1              2       212
#> 931             3               1              1       311
#> 932             3               2              1       321
#> 933             1               1              3       113
#> 934             4               2              3       423
#> 935             2               1              3       213
#> 936             1               1              2       112
#> 937             2               1              1       211
#> 938             2               2              2       222
#> 939             1               1              3       113
#> 940             2               2              1       221
#> 941             1               1              3       113
#> 942             3               1              1       311
#> 943             2               1              3       213
#> 944             1               1              1       111
#> 945             4               1              1       411
#> 946             2               1              1       211
#> 947             2               1              1       211
#> 948             1               1              1       111
#> 949             1               1              1       111
#> 950             4               3              3       433
#> 951             2               1              1       211
#> 952             5               3              3       533
#> 953             1               1              1       111
#> 954             1               1              1       111
#> 955             2               1              2       212
#> 956             3               1              1       311
#> 957             1               1              1       111
#> 958             5               1              1       511
#> 959             2               2              2       222
#> 960             4               1              1       411
#> 961             4               3              1       431
#> 962             2               1              2       212
#> 963             5               1              2       512
#> 964             5               2              3       523
#> 965             2               2              1       221
#> 966             4               2              3       423
#> 967             4               2              1       421
#> 968             1               2              2       122
#> 969             1               1              1       111
#> 970             2               1              1       211
#> 971             1               1              1       111
#> 972             1               1              1       111
#> 973             3               2              1       321
#> 974             4               1              1       411
#> 975             1               1              1       111
#> 976             5               2              1       521
#> 977             1               1              1       111
#> 978             1               1              1       111
#> 979             1               1              2       112
#> 980             2               1              1       211
#> 981             3               1              1       311
#> 982             1               1              1       111
#> 983             4               1              2       412
#> 984             4               1              1       411
#> 985             1               1              1       111
#> 986             1               1              1       111
#> 987             1               1              1       111
#> 988             5               2              2       522
#> 989             5               2              2       522
#> 990             1               1              1       111
#> 991             1               1              1       111
#> 992             3               1              1       311
#> 993             3               1              2       312
#> 994             1               1              1       111
#> 995             1               1              1       111
#> 
#> $analysis_date
#> [1] "2006-12-31"
#> 
#> $frequency_bins
#> [1] 5
#> 
#> $recency_bins
#> [1] 5
#> 
#> $monetary_bins
#> [1] 5
#> 
#> $threshold
#>   recency_lower recency_upper frequency_lower frequency_upper monetary_lower
#> 1           1.0         115.0               1               4           12.0
#> 2         115.0         181.0               4               5          255.8
#> 3         181.0         297.4               5               6          382.0
#> 4         297.4         482.0               6               8          506.4
#> 5         482.0         977.0               8              15          666.0
#>   monetary_upper
#> 1          255.8
#> 2          382.0
#> 3          506.4
#> 4          666.0
#> 5         1489.0
```

### Heat Map

The heat map shows the average monetary value for different categories
of recency and frequency scores. Higher scores of frequency and recency
are characterized by higher average monetary value as indicated by the
darker areas in the heatmap.

``` r
rfm_heatmap(rfm_result)
```

<img src="tools/README-heatmap-1.png" style="display: block; margin: auto;" />

### Bar Chart

Use `rfm_bar_chart()` to generate the distribution of monetary scores
for the different combinations of frequency and recency scores.

``` r
rfm_bar_chart(rfm_result)
```

<img src="tools/README-barchart-1.png" style="display: block; margin: auto;" />

### Histogram

Use `rfm_histograms()` to examine the relative distribution of

- monetary value (total revenue generated by each customer)
- recency days (days since the most recent visit for each customer)
- frequency (transaction count for each customer)

``` r
rfm_histograms(rfm_result)
```

<img src="tools/README-rfmhist-1.png" style="display: block; margin: auto;" />

### Customers by Orders

Visualize the distribution of customers across orders.

``` r
rfm_order_dist(rfm_result)
```

<img src="tools/README-rfmorders-1.png" style="display: block; margin: auto;" />

### Scatter Plots

The best customers are those who:

- bought most recently
- most often
- and spend the most

Now let us examine the relationship between the above.

#### Recency vs Monetary Value

``` r
rfm_rm_plot(rfm_result)
```

<img src="tools/README-mr-1.png" style="display: block; margin: auto;" />

#### Frequency vs Monetary Value

``` r
rfm_fm_plot(rfm_result)
```

<img src="tools/README-fm-1.png" style="display: block; margin: auto;" />

#### Recency vs Frequency

``` r
rfm_rf_plot(rfm_result)
```

<img src="tools/README-fr-1.png" style="display: block; margin: auto;" />

## Getting Help

If you encounter a bug, please file a minimal reproducible example using
[reprex](https://reprex.tidyverse.org/index.html) on github. For
questions and clarifications, use
[StackOverflow](https://stackoverflow.com/).
