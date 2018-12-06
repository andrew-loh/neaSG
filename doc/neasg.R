## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- message=FALSE, warning=FALSE, eval=FALSE---------------------------
#  library(devtools)
#  install_github("andrew-loh/neaSG", force = TRUE)

## ---- message=FALSE, warning=FALSE---------------------------------------
library(neaSG)
ls(package:neaSG)

## ---- message=FALSE, warning=FALSE---------------------------------------
get_weatherstns()

## ---- message=FALSE, warning=FALSE---------------------------------------
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_airtemp(from = "2017-12-31", to = "2018-01-04")
head(data)

## ---- message=FALSE, warning=FALSE---------------------------------------
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_humidity(from = "2017-12-31", to = "2018-01-04")
head(data)

## ---- message=FALSE, warning=FALSE---------------------------------------
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_rainfall(from = "2017-12-31", to = "2018-01-04")
head(data)

## ---- message=FALSE, warning=FALSE---------------------------------------
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_UV(from = "2017-12-31", to = "2018-01-04")
head(data)

## ---- message=FALSE, warning=FALSE---------------------------------------
#Dates must be input as characters in a "YYYY-MM-DD" format
data <- get_pollutants(from = "2017-12-31", to = "2018-01-04")
head(data)

## ---- message=FALSE, warning=FALSE---------------------------------------
data <- get_weathersumm(from = "2017-12-31", to = "2018-01-04")
head(data)

