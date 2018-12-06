neaSG Package README
================
Andrew Loh
2018-12-06

R Interface for Singapore's Weather, UV and Pollutants Data from National Environment Agency (NEA) APIs.

No API key is required for these APIs. The library can hence be installed without any authentication required.

As a caveat, this API client will be significantly slower than other APIs, as the NEA APIs allow only for queries of individual dates, one at a time. This interface helps to automate the querying of a list of dates, and the tidying of appropriate data into tidy data frames.

To install
----------

``` r
library(devtools)
install_github("andrew-loh/neaSG", force = TRUE)
```

Examples
--------

To list all functions supported by this package:

``` r
library(neaSG)
ls(package:neaSG)
#> [1] "get_airtemp"     "get_humidity"    "get_pollutants"  "get_rainfall"   
#> [5] "get_UV"          "get_weatherstns" "get_weathersumm"
```

### Weather Stations

Air temperature, humidity and rainfall are given by weather station IDs. To get data frame of weather stations in Singapore by name, geographic coordinates and ID:

``` r
get_weatherstns()
#>       id device_id                        name location.latitude
#>  1:  S77       S77              Alexandra Road           1.29370
#>  2: S109      S109         Ang Mo Kio Avenue 5           1.37640
#>  3: S117      S117                 Banyan Road           1.25600
#>  4:  S55       S55              Buangkok Green           1.38370
#>  5:  S64       S64          Bukit Panjang Road           1.38240
#>  6:  S90       S90            Bukit Timah Road           1.31910
#>  7:  S61       S61            Chai Chee Street           1.32300
#>  8: S114      S114      Choa Chu Kang Avenue 4           1.38000
#>  9:  S11       S11          Choa Chu Kang Road           1.37460
#> 10:  S50       S50               Clementi Road           1.33370
#> 11: S101      S101            Corporation Road           1.35053
#> 12: S107      S107          East Coast Parkway           1.31350
#> 13: S215      S215        GEYLANG EAST CENTRAL           1.32785
#> 14: S118      S118                  Handy Road           1.29940
#> 15: S120      S120                Holland Road           1.30874
#> 16:  S33       S33            Jurong Pier Road           1.30810
#> 17:  S71       S71             Kent Ridge Road           1.29230
#> 18:  S43       S43              Kim Chuan Road           1.33990
#> 19:  S66       S66                  Kranji Way           1.43870
#> 20: S112      S112           Lim Chu Kang Road           1.43854
#> 21:  S07       S07                 Lornie Road           1.34150
#> 22:  S40       S40            Mandai Lake Road           1.40440
#> 23: S108      S108        Marina Gardens Drive           1.27990
#> 24: S113      S113          Marine Parade Road           1.30648
#> 25:  S44       S44              Nanyang Avenue           1.34583
#> 26: S119      S119              Nicoll Highway           1.30105
#> 27: S121      S121      Old Choa Chu Kang Road           1.37288
#> 28:  S35       S35           Old Toh Tuck Road           1.33290
#> 29:  S29       S29          Pasir Ris Drive 12           1.38700
#> 30:  S94       S94         Pasir Ris Street 51           1.36620
#> 31:  S78       S78                  Poole Road           1.30703
#> 32: S106      S106                  Pulau Ubin           1.41680
#> 33:  S81       S81             Punggol Central           1.40290
#> 34: S111      S111                 Scotts Road           1.31055
#> 35: S900      S900      Seletar Aerospace View           1.41284
#> 36: S122      S122              Sembawang Road           1.41731
#> 37:  S60       S60                     Sentosa           1.25000
#> 38:  S84       S84                Simei Avenue           1.34370
#> 39:  S79       S79               Somerset Road           1.30040
#> 40:  S92       S92      South Buona Vista Road           1.28410
#> 41:  S88       S88             Toa Payoh North           1.34270
#> 42: S123      S123                 Towner Road           1.32140
#> 43:  S89       S89                   Tuas Road           1.31985
#> 44: S115      S115         Tuas South Avenue 3           1.29377
#> 45:  S82       S82              Tuas West Road           1.32470
#> 46:  S24       S24     Upper Changi Road North           1.36780
#> 47:  S69       S69 Upper Peirce Reservoir Park           1.37000
#> 48:  S08       S08          Upper Thomson Road           1.37010
#> 49: S116      S116          West Coast Highway           1.28100
#> 50: S100      S100              Woodlands Road           1.41720
#> 51:  S91       S91             Yishun Avenue 5           1.43010
#> 52:  S46       S46                   Sime Road           1.34160
#> 53:  S36       S36        Upper Serangoon Road           1.33820
#>       id device_id                        name location.latitude
#>     location.longitude
#>  1:           103.8125
#>  2:           103.8492
#>  3:           103.6790
#>  4:           103.8860
#>  5:           103.7603
#>  6:           103.8191
#>  7:           103.9217
#>  8:           103.7300
#>  9:           103.6938
#> 10:           103.7768
#> 11:           103.7134
#> 12:           103.9625
#> 13:           103.8890
#> 14:           103.8461
#> 15:           103.8180
#> 16:           103.7100
#> 17:           103.7815
#> 18:           103.8878
#> 19:           103.7363
#> 20:           103.7013
#> 21:           103.8334
#> 22:           103.7896
#> 23:           103.8703
#> 24:           103.9104
#> 25:           103.6817
#> 26:           103.8666
#> 27:           103.7224
#> 28:           103.7556
#> 29:           103.9350
#> 30:           103.9528
#> 31:           103.8907
#> 32:           103.9673
#> 33:           103.9092
#> 34:           103.8365
#> 35:           103.8692
#> 36:           103.8249
#> 37:           103.8279
#> 38:           103.9444
#> 39:           103.8372
#> 40:           103.7886
#> 41:           103.8482
#> 42:           103.8577
#> 43:           103.6616
#> 44:           103.6184
#> 45:           103.6351
#> 46:           103.9826
#> 47:           103.8050
#> 48:           103.8271
#> 49:           103.7540
#> 50:           103.7485
#> 51:           103.8308
#> 52:           103.8106
#> 53:           103.8657
#>     location.longitude
```

### Temperature

Temperature is provided in degrees Celsius. Documentation is provided [here](https://data.gov.sg/dataset/realtime-weather-readings?resource_id=17494bed-23e9-4b3b-ae89-232f87987163).
To get data frame of per-minute air temperature in Singapore for specific dates:

``` r
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_airtemp(from = "2017-12-31", to = "2018-01-04")
#> [1] "2017-12-31"
#> [1] "2018-01-04"
head(data)
#>                    timestamp readings.station_id readings.value
#> 1: 2017-12-31T00:01:00+08:00                S109           24.8
#> 2: 2017-12-31T00:02:00+08:00                S109           24.8
#> 3: 2017-12-31T00:03:00+08:00                S109           24.8
#> 4: 2017-12-31T00:04:00+08:00                S109           24.8
#> 5: 2017-12-31T00:05:00+08:00                S109           24.8
#> 6: 2017-12-31T00:06:00+08:00                S109           24.8
#>    readings.station_id.1 readings.value.1 readings.station_id.2
#> 1:                  S117             25.0                  S107
#> 2:                  S117             24.9                  S107
#> 3:                  S117             24.9                   S50
#> 4:                  S117             25.0                  S107
#> 5:                  S117             25.0                   S50
#> 6:                  S117             25.0                  S107
#>    readings.value.2 readings.station_id.3 readings.value.3
#> 1:             26.8                   S43             25.2
#> 2:             26.8                   S43             25.2
#> 3:             24.5                  S107             26.8
#> 4:             26.8                   S43             25.3
#> 5:             24.5                  S107             26.8
#> 6:             26.8                   S43             25.3
#>    readings.station_id.4 readings.value.4 readings.station_id.5
#> 1:                   S44             25.0                  S121
#> 2:                   S44             25.0                  S121
#> 3:                   S43             25.3                   S44
#> 4:                   S44             24.9                  S121
#> 5:                   S43             25.3                   S44
#> 6:                   S44             24.9                  S121
#>    readings.value.5 readings.station_id.6 readings.value.6
#> 1:             25.5                  S106             24.9
#> 2:             25.5                  S106             24.9
#> 3:             24.9                  S121             25.4
#> 4:             25.4                  S106             24.8
#> 5:             24.9                  S121             25.5
#> 6:             25.5                  S106             24.8
#>    readings.station_id.7 readings.value.7 readings.station_id.8
#> 1:                  S111             24.4                  S122
#> 2:                  S111             24.4                  S122
#> 3:                  S106             24.8                  S111
#> 4:                  S111             24.4                  S122
#> 5:                  S106             24.9                  S111
#> 6:                  S111             24.4                  S122
#>    readings.value.8 readings.station_id.9 readings.value.9
#> 1:             25.0                   S60             25.2
#> 2:             25.0                   S60             25.2
#> 3:             24.4                   S60             25.2
#> 4:             25.0                   S60             25.2
#> 5:             24.4                  S122             25.0
#> 6:             25.0                   S60             25.1
#>    readings.station_id.10 readings.value.10 readings.station_id.11
#> 1:                   S115              26.2                    S24
#> 2:                   S115              26.2                    S24
#> 3:                   S115              26.2                    S24
#> 4:                   S115              26.2                    S24
#> 5:                    S60              25.2                   S115
#> 6:                   S115              26.1                    S24
#>    readings.value.11 readings.station_id.12 readings.value.12
#> 1:              25.7                   S116              25.1
#> 2:              25.7                   S116              25.2
#> 3:              25.7                   S116              25.2
#> 4:              25.7                   S116              25.2
#> 5:              26.2                    S24              25.7
#> 6:              25.7                   S116              25.2
#>    readings.station_id.13 readings.value.13 readings.station_id.14
#> 1:                   S100              25.7                   <NA>
#> 2:                   S100              25.7                   <NA>
#> 3:                   S100              25.7                   <NA>
#> 4:                   S100              25.7                   <NA>
#> 5:                   S116              25.2                   S100
#> 6:                   S100              25.7                   <NA>
#>    readings.value.14 readings.station_id.15 readings.value.15
#> 1:                NA                   <NA>                NA
#> 2:                NA                   <NA>                NA
#> 3:                NA                   <NA>                NA
#> 4:                NA                   <NA>                NA
#> 5:              25.7                   <NA>                NA
#> 6:                NA                   <NA>                NA
#>    readings.station_id.16 readings.value.16
#> 1:                   <NA>                NA
#> 2:                   <NA>                NA
#> 3:                   <NA>                NA
#> 4:                   <NA>                NA
#> 5:                   <NA>                NA
#> 6:                   <NA>                NA
```

### Relative Humidity

Relative humidity is given as percentage, as is convention. Documentation is provided [here](https://data.gov.sg/dataset/realtime-weather-readings?resource_id=59eb2883-2ceb-4d16-85f0-7e3a3176ef46).
To get data frame of per-minute relative humidity readings in Singapore for specific dates:

``` r
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_humidity(from = "2017-12-31", to = "2018-01-04")
#> [1] "2017-12-31"
#> [1] "2018-01-04"
head(data)
#>                    timestamp readings.station_id readings.value
#> 1: 2017-12-31T00:01:00+08:00                S117           95.4
#> 2: 2017-12-31T00:02:00+08:00                S117           95.6
#> 3: 2017-12-31T00:03:00+08:00                S117           95.8
#> 4: 2017-12-31T00:04:00+08:00                S117           95.9
#> 5: 2017-12-31T00:05:00+08:00                S117           96.1
#> 6: 2017-12-31T00:06:00+08:00                S117           96.2
#>    readings.station_id.1 readings.value.1 readings.station_id.2
#> 1:                  S107             89.1                   S43
#> 2:                  S107             89.5                   S43
#> 3:                   S50             99.2                  S107
#> 4:                  S107             89.6                   S43
#> 5:                   S50             99.2                  S107
#> 6:                  S107             89.7                   S43
#>    readings.value.2 readings.station_id.3 readings.value.3
#> 1:             99.4                  S121             69.5
#> 2:             99.8                  S121             69.9
#> 3:             89.6                   S43            100.3
#> 4:            100.5                  S121             70.0
#> 5:             89.6                   S43            100.8
#> 6:            100.9                  S121             70.1
#>    readings.station_id.4 readings.value.4 readings.station_id.5
#> 1:                  S111             97.4                   S60
#> 2:                  S111             97.5                   S60
#> 3:                  S121             70.0                  S111
#> 4:                  S111             97.6                   S60
#> 5:                  S121             69.9                  S111
#> 6:                  S111             97.7                   S60
#>    readings.value.5 readings.station_id.6 readings.value.6
#> 1:             95.0                  S115             85.1
#> 2:             95.1                  S115             85.2
#> 3:             97.6                   S60             95.1
#> 4:             95.1                  S115             85.5
#> 5:             97.7                   S60             95.2
#> 6:             95.3                  S115             85.7
#>    readings.station_id.7 readings.value.7 readings.station_id.8
#> 1:                   S24             93.3                  S100
#> 2:                   S24             93.4                  S100
#> 3:                  S115             85.3                   S24
#> 4:                   S24             93.6                  S100
#> 5:                  S115             85.7                   S24
#> 6:                   S24             93.7                  S100
#>    readings.value.8 readings.station_id.9 readings.value.9
#> 1:             90.9                  <NA>               NA
#> 2:             91.0                  <NA>               NA
#> 3:             93.5                  S100             91.1
#> 4:             91.2                  <NA>               NA
#> 5:             93.7                  S100             91.2
#> 6:             91.3                  <NA>               NA
#>    readings.station_id.10 readings.value.10 readings.station_id.11
#> 1:                   <NA>                NA                   <NA>
#> 2:                   <NA>                NA                   <NA>
#> 3:                   <NA>                NA                   <NA>
#> 4:                   <NA>                NA                   <NA>
#> 5:                   <NA>                NA                   <NA>
#> 6:                   <NA>                NA                   <NA>
#>    readings.value.11 readings.station_id.12 readings.value.12
#> 1:                NA                   <NA>                NA
#> 2:                NA                   <NA>                NA
#> 3:                NA                   <NA>                NA
#> 4:                NA                   <NA>                NA
#> 5:                NA                   <NA>                NA
#> 6:                NA                   <NA>                NA
#>    readings.station_id.13 readings.value.13 readings.station_id.14
#> 1:                   <NA>                NA                   <NA>
#> 2:                   <NA>                NA                   <NA>
#> 3:                   <NA>                NA                   <NA>
#> 4:                   <NA>                NA                   <NA>
#> 5:                   <NA>                NA                   <NA>
#> 6:                   <NA>                NA                   <NA>
#>    readings.value.14 readings.station_id.15 readings.value.15
#> 1:                NA                   <NA>                NA
#> 2:                NA                   <NA>                NA
#> 3:                NA                   <NA>                NA
#> 4:                NA                   <NA>                NA
#> 5:                NA                   <NA>                NA
#> 6:                NA                   <NA>                NA
#>    readings.station_id.16 readings.value.16
#> 1:                   <NA>                NA
#> 2:                   <NA>                NA
#> 3:                   <NA>                NA
#> 4:                   <NA>                NA
#> 5:                   <NA>                NA
#> 6:                   <NA>                NA
```

### Rainfall

Rainfall is given by mm/5-minutes. Documentation is provided [here](https://data.gov.sg/dataset/realtime-weather-readings?resource_id=8bd37e06-cdd7-4ca4-9ad8-5754eb70a33d).
To get data frame of 5-minute rainfall readings in Singapore for specific dates:

``` r
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_rainfall(from = "2017-12-31", to = "2018-01-04")
#> [1] "2017-12-31"
#> [1] "2018-01-04"
head(data)
#>                    timestamp readings.station_id readings.value
#> 1: 2017-12-31T00:05:00+08:00                 S77            5.2
#> 2: 2017-12-31T00:10:00+08:00                 S77            4.4
#> 3: 2017-12-31T00:15:00+08:00                 S77            1.0
#> 4: 2017-12-31T00:20:00+08:00                 S77            0.4
#> 5: 2017-12-31T00:25:00+08:00                 S77            0.2
#> 6: 2017-12-31T00:30:00+08:00                 S77            0.0
#>    readings.station_id.1 readings.value.1 readings.station_id.2
#> 1:                  S109                0                  S117
#> 2:                  S109                0                  S117
#> 3:                  S109                0                  S117
#> 4:                  S109                0                  S117
#> 5:                  S109                0                  S117
#> 6:                  S109                0                  S117
#>    readings.value.2 readings.station_id.3 readings.value.3
#> 1:              0.4                   S55                0
#> 2:              0.8                   S55                0
#> 3:              1.2                   S55                0
#> 4:              1.0                   S55                0
#> 5:              0.4                   S55                0
#> 6:              0.4                   S55                0
#>    readings.station_id.4 readings.value.4 readings.station_id.5
#> 1:                   S64              0.4                   S90
#> 2:                   S64              0.2                   S90
#> 3:                   S64              0.0                   S90
#> 4:                   S64              0.0                   S90
#> 5:                   S64              0.2                   S90
#> 6:                   S64              0.2                   S90
#>    readings.value.5 readings.station_id.6 readings.value.6
#> 1:              0.4                   S61                0
#> 2:              0.6                   S61                0
#> 3:              0.2                   S61                0
#> 4:              0.0                   S61                0
#> 5:              0.0                   S61                0
#> 6:              0.0                   S61                0
#>    readings.station_id.7 readings.value.7 readings.station_id.8
#> 1:                  S114              0.0                   S11
#> 2:                  S114              0.2                   S11
#> 3:                  S114              0.0                   S11
#> 4:                  S114              0.0                   S11
#> 5:                  S114              0.0                   S11
#> 6:                  S114              0.0                   S11
#>    readings.value.8 readings.station_id.9 readings.value.9
#> 1:                0                   S50              0.2
#> 2:                0                   S50              0.2
#> 3:                0                   S50              0.0
#> 4:                0                   S50              0.0
#> 5:                0                   S50              0.0
#> 6:                0                   S50              0.2
#>    readings.station_id.10 readings.value.10 readings.station_id.11
#> 1:                   S107                 0                   S118
#> 2:                   S107                 0                   S118
#> 3:                   S107                 0                   S118
#> 4:                   S107                 0                   S118
#> 5:                   S107                 0                   S118
#> 6:                   S107                 0                   S118
#>    readings.value.11 readings.station_id.12 readings.value.12
#> 1:               4.4                   S120               3.8
#> 2:               2.2                   S120               0.6
#> 3:               2.6                   S120               0.4
#> 4:               3.4                   S120               0.0
#> 5:               0.8                   S120               0.0
#> 6:               0.2                   S120               0.0
#>    readings.station_id.13 readings.value.13 readings.station_id.14
#> 1:                    S33               0.2                    S71
#> 2:                    S33               0.0                    S71
#> 3:                    S33               0.0                    S71
#> 4:                    S33               0.2                    S71
#> 5:                    S33               0.2                    S71
#> 6:                    S33               0.4                    S71
#>    readings.value.14 readings.station_id.15 readings.value.15
#> 1:               0.0                    S43               1.6
#> 2:               0.0                    S43               0.2
#> 3:               0.2                    S43               0.2
#> 4:               1.0                    S43               0.0
#> 5:               1.4                    S43               0.0
#> 6:               0.0                    S43               0.0
#>    readings.station_id.16 readings.value.16 readings.station_id.17
#> 1:                    S66               0.2                   S112
#> 2:                    S66               0.0                   S112
#> 3:                    S66               0.0                   S112
#> 4:                    S66               0.0                   S112
#> 5:                    S66               0.0                   S112
#> 6:                    S66               0.2                   S112
#>    readings.value.17 readings.station_id.18 readings.value.18
#> 1:               0.0                    S07               0.2
#> 2:               0.2                    S07               0.0
#> 3:               0.0                    S07               0.0
#> 4:               0.2                    S07               0.0
#> 5:               0.2                    S07               0.0
#> 6:               0.0                    S07               0.0
#>    readings.station_id.19 readings.value.19 readings.station_id.20
#> 1:                    S40               0.0                   S113
#> 2:                    S40               0.0                   S113
#> 3:                    S40               0.2                   S113
#> 4:                    S40               0.0                   S113
#> 5:                    S40               0.6                   S113
#> 6:                    S40               0.0                   S113
#>    readings.value.20 readings.station_id.21 readings.value.21
#> 1:                 0                    S44                 0
#> 2:                 0                    S44                 0
#> 3:                 0                    S44                 0
#> 4:                 0                    S44                 0
#> 5:                 0                    S44                 0
#> 6:                 0                    S44                 0
#>    readings.station_id.22 readings.value.22 readings.station_id.23
#> 1:                   S119               1.4                   S121
#> 2:                   S119               3.2                   S121
#> 3:                   S119               4.2                   S121
#> 4:                   S119               1.0                   S121
#> 5:                   S119               0.4                   S121
#> 6:                   S119               0.0                   S121
#>    readings.value.23 readings.station_id.24 readings.value.24
#> 1:               0.0                    S35               2.0
#> 2:               0.0                    S35               1.8
#> 3:               0.0                    S35               1.2
#> 4:               0.0                    S35               0.2
#> 5:               0.0                    S35               0.0
#> 6:               0.2                    S35               0.2
#>    readings.station_id.25 readings.value.25 readings.station_id.26
#> 1:                    S29                 0                    S94
#> 2:                    S29                 0                    S94
#> 3:                    S29                 0                    S94
#> 4:                    S29                 0                    S94
#> 5:                    S29                 0                    S94
#> 6:                    S29                 0                    S94
#>    readings.value.26 readings.station_id.27 readings.value.27
#> 1:                 0                    S78               0.2
#> 2:                 0                    S78               0.2
#> 3:                 0                    S78               0.0
#> 4:                 0                    S78               0.0
#> 5:                 0                    S78               0.0
#> 6:                 0                    S78               0.0
#>    readings.station_id.28 readings.value.28 readings.station_id.29
#> 1:                   S106                 0                    S81
#> 2:                   S106                 0                    S81
#> 3:                   S106                 0                    S81
#> 4:                   S106                 0                    S81
#> 5:                   S106                 0                    S81
#> 6:                   S106                 0                    S81
#>    readings.value.29 readings.station_id.30 readings.value.30
#> 1:                 0                   S111               1.8
#> 2:                 0                   S111               0.4
#> 3:                 0                   S111               0.0
#> 4:                 0                   S111               0.6
#> 5:                 0                   S111               0.0
#> 6:                 0                   S111               0.0
#>    readings.station_id.31 readings.value.31 readings.station_id.32
#> 1:                   S900                 0                   S122
#> 2:                   S900                 0                   S122
#> 3:                   S900                 0                   S122
#> 4:                   S900                 0                   S122
#> 5:                   S900                 0                   S122
#> 6:                   S900                 0                   S122
#>    readings.value.32 readings.station_id.33 readings.value.33
#> 1:               0.0                    S60               0.2
#> 2:               0.6                    S60               0.2
#> 3:               0.4                    S60               1.0
#> 4:               0.0                    S60               2.2
#> 5:               0.0                    S60               0.4
#> 6:               0.0                    S60               0.8
#>    readings.station_id.34 readings.value.34 readings.station_id.35
#> 1:                    S46               0.0                    S84
#> 2:                    S46               0.2                    S84
#> 3:                    S46               0.0                    S84
#> 4:                    S46               0.0                    S84
#> 5:                    S46               0.0                    S84
#> 6:                    S46               0.0                    S84
#>    readings.value.35 readings.station_id.36 readings.value.36
#> 1:                 0                    S79               4.6
#> 2:                 0                    S79               1.2
#> 3:                 0                    S79               1.4
#> 4:                 0                    S79               1.8
#> 5:                 0                    S79               1.6
#> 6:                 0                    S79               0.0
#>    readings.station_id.37 readings.value.37 readings.station_id.38
#> 1:                    S92               0.2                    S88
#> 2:                    S92               3.0                    S88
#> 3:                    S92               3.6                    S88
#> 4:                    S92               4.0                    S88
#> 5:                    S92               1.0                    S88
#> 6:                    S92               0.2                    S88
#>    readings.value.38 readings.station_id.39 readings.value.39
#> 1:               0.2                   S123               0.2
#> 2:               0.2                   S123               0.6
#> 3:               0.0                   S123               0.4
#> 4:               0.0                   S123               0.4
#> 5:               0.0                   S123               0.2
#> 6:               0.0                   S123               0.2
#>    readings.station_id.40 readings.value.40 readings.station_id.41
#> 1:                    S89               0.0                   S115
#> 2:                    S89               0.0                   S115
#> 3:                    S89               0.0                   S115
#> 4:                    S89               0.0                   S115
#> 5:                    S89               0.2                   S115
#> 6:                    S89               0.2                   S115
#>    readings.value.41 readings.station_id.42 readings.value.42
#> 1:               0.0                    S82               0.0
#> 2:               0.0                    S82               0.0
#> 3:               0.0                    S82               0.0
#> 4:               0.0                    S82               0.2
#> 5:               0.0                    S82               0.4
#> 6:               0.4                    S82               0.0
#>    readings.station_id.43 readings.value.43 readings.station_id.44
#> 1:                    S24                 0                    S69
#> 2:                    S24                 0                    S69
#> 3:                    S24                 0                    S69
#> 4:                    S24                 0                    S69
#> 5:                    S24                 0                    S69
#> 6:                    S24                 0                    S69
#>    readings.value.44 readings.station_id.45 readings.value.45
#> 1:               0.0                    S36               0.0
#> 2:               0.0                    S36               0.4
#> 3:               0.4                    S36               0.4
#> 4:               0.0                    S36               0.2
#> 5:               0.0                    S36               0.0
#> 6:               0.4                    S36               0.0
#>    readings.station_id.46 readings.value.46 readings.station_id.47
#> 1:                    S08                 0                   S116
#> 2:                    S08                 0                   S116
#> 3:                    S08                 0                   S116
#> 4:                    S08                 0                   S116
#> 5:                    S08                 0                   S116
#> 6:                    S08                 0                   S116
#>    readings.value.47 readings.station_id.48 readings.value.48
#> 1:               0.2                   S100               0.0
#> 2:               0.0                   S100               0.0
#> 3:               0.2                   S100               0.0
#> 4:               2.4                   S100               0.2
#> 5:               1.8                   S100               0.0
#> 6:               0.6                   S100               0.0
#>    readings.station_id.49 readings.value.49 readings.station_id.50
#> 1:                    S91               0.2                   <NA>
#> 2:                    S91               0.2                   <NA>
#> 3:                    S91               0.0                   <NA>
#> 4:                    S91               0.0                   <NA>
#> 5:                    S91               0.0                   <NA>
#> 6:                    S91               0.0                   <NA>
#>    readings.value.50 readings.station_id.51 readings.value.51
#> 1:                NA                   <NA>                NA
#> 2:                NA                   <NA>                NA
#> 3:                NA                   <NA>                NA
#> 4:                NA                   <NA>                NA
#> 5:                NA                   <NA>                NA
#> 6:                NA                   <NA>                NA
```

### UV Index

UV Index provides data for hours when the sun is up - from 0700 to 1900hrs. As Singapore is a tropical country, sunrise and sunset times do not vary significantly through the year. Documentation is provided [here](https://data.gov.sg/dataset/ultraviolet-index-uvi).

``` r
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_UV(from = "2017-12-31", to = "2018-01-04")
#> [1] "2017-12-31"
#> [1] "2018-01-04"
head(data)
#>    value                 timestamp
#> 1:     0 2017-12-31T19:00:00+08:00
#> 2:     0 2017-12-31T18:00:00+08:00
#> 3:     0 2017-12-31T17:00:00+08:00
#> 4:     0 2017-12-31T16:00:00+08:00
#> 5:     0 2017-12-31T15:00:00+08:00
#> 6:     1 2017-12-31T14:00:00+08:00
```

### Pollutants

Pollutants are given by hourly measures for respective indices. Data is provided for national and 5 subnational regions, in the form of 12 pollutant indices: O3 Sub-Index, PM10 24-hourly, PM10 Sub-Index, CO Sub-Index, PM2.5 24-Hourly, SO2 Sub-Index, CO 8-Hour-Max, NO2 1-Hour-Max, SO2 24-Hourly, PM2.5 Sub-Index, PSI 24-Hourly and O3 8-Hour Max. Documentation is provided [here](https://data.gov.sg/dataset/psi).

Additional argument `natl_only` is, by default, `TRUE`. If true, provides only national readings. If the user desires subnational readings, set `natl_only = FALSE`

``` r
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_pollutants(from = "2017-12-31", to = "2018-01-04")
#> [1] "2017-12-31"
#> [1] "2018-01-04"
head(data)
#>                    timestamp          update_timestamp
#> 1: 2017-12-31T01:00:00+08:00 2017-12-31T01:06:18+08:00
#> 2: 2017-12-31T02:00:00+08:00 2017-12-31T02:06:18+08:00
#> 3: 2017-12-31T03:00:00+08:00 2017-12-31T03:06:18+08:00
#> 4: 2017-12-31T04:00:00+08:00 2017-12-31T04:06:17+08:00
#> 5: 2017-12-31T05:00:00+08:00 2017-12-31T05:06:18+08:00
#> 6: 2017-12-31T06:00:00+08:00 2017-12-31T06:06:18+08:00
#>    readings.o3_sub_index.national
#> 1:                             11
#> 2:                             11
#> 3:                             11
#> 4:                             12
#> 5:                             12
#> 6:                             12
#>    readings.pm10_twenty_four_hourly.national
#> 1:                                        42
#> 2:                                        42
#> 3:                                        42
#> 4:                                        41
#> 5:                                        41
#> 6:                                        41
#>    readings.pm10_sub_index.national readings.co_sub_index.national
#> 1:                               42                              5
#> 2:                               42                              5
#> 3:                               42                              5
#> 4:                               41                              5
#> 5:                               41                              5
#> 6:                               41                              5
#>    readings.pm25_twenty_four_hourly.national
#> 1:                                        12
#> 2:                                        12
#> 3:                                        12
#> 4:                                        12
#> 5:                                        12
#> 6:                                        12
#>    readings.so2_sub_index.national readings.co_eight_hour_max.national
#> 1:                               3                                0.53
#> 2:                               3                                0.54
#> 3:                               3                                0.53
#> 4:                               3                                0.52
#> 5:                               3                                0.51
#> 6:                               3                                0.50
#>    readings.no2_one_hour_max.national
#> 1:                                 32
#> 2:                                 31
#> 3:                                 18
#> 4:                                 25
#> 5:                                 27
#> 6:                                 30
#>    readings.so2_twenty_four_hourly.national
#> 1:                                        5
#> 2:                                        5
#> 3:                                        5
#> 4:                                        5
#> 5:                                        5
#> 6:                                        5
#>    readings.pm25_sub_index.national
#> 1:                               49
#> 2:                               49
#> 3:                               49
#> 4:                               49
#> 5:                               48
#> 6:                               48
#>    readings.psi_twenty_four_hourly.national
#> 1:                                       49
#> 2:                                       49
#> 3:                                       49
#> 4:                                       49
#> 5:                                       48
#> 6:                                       48
#>    readings.o3_eight_hour_max.national
#> 1:                                  27
#> 2:                                  27
#> 3:                                  27
#> 4:                                  27
#> 5:                                  28
#> 6:                                  27
```

### Weather Summary

The final function aims to provide an hourly weather summary for specified dates. Hourly aggregated weather data on air temperature, humidity, rainfall, UV and PSI 24-Hourly readings will be returned as a data frame. As each separate API returns data of varying granularity - geographical or temporal, this summary will aggregate across all of Singapore and over each hour. Documentation for each separate index can be acquired from each of the separate functions above.

``` r
data <- get_weathersumm(from = "2017-12-31", to = "2018-01-04")
#> [1] "2017-12-31"
#> [1] "2018-01-04"
head(data)
#>                  Hour Average Hourly Rainfall UV Index
#> 1 2017-12-31 00:00:00                2.901818        0
#> 2 2017-12-31 01:00:00                5.016000        0
#> 3 2017-12-31 02:00:00               13.878449        0
#> 4 2017-12-31 03:00:00                3.803020        0
#> 5 2017-12-31 04:00:00                0.896000        0
#> 6 2017-12-31 05:00:00                0.176000        0
#>   Average Air Temperature PSI 24-Hourly Average Relative Humidity
#> 1                25.20341            NA                  91.71302
#> 2                25.03904            49                  93.62464
#> 3                24.85914            49                  93.89126
#> 4                24.81281            49                  93.99837
#> 5                24.94275            49                  93.63647
#> 6                25.07144            48                  93.64695
```
