#' Gets hourly aggregated weather data in Singapore for specified set of dates.
#'
#' Returns a dataframe of hourly aggregated weather data in Singapore for specified dates: Air temperature, Humidity, Rainfall, UV, PSI 24-Hourly
#'
#' User inputs a starting and final date. Returns hourly aggregated weather data from multiple API sources. Per-minute air temperature data, per-minute humidity data, 5-minute rainfall data is aggregated over the hour and across weather stations distributed across Singapore. PSI 24-hourly data and UV levels will be taken directly from APIs which provide national, hourly data.
#'
#' @import magrittr
#' @import dplyr
#' @param from Starting date. Must be a character string, in "YYYY-MM-DD" format.
#' @param to Final date, inclusive. Must be a character string, in "YYYY-MM-DD" format.
#' @return Dataframe of air temperature, humidity, rainfall, UV, PSI 24-hourly data aggregated over Singapore at the hourly level.
#' @examples
#' get_weathersumm("2017-12-31", "2018-01-04")
#' @export

get_weathersumm <- function(from, to) {
  requireNamespace("magrittr")
  #Checking inputs
  if(class(from) != "character") stop("Parameter 'from' must be character string")
  if(class(to) != "character") stop("Parameter 'to' must be character string")
  tryCatch({test <- as.Date(from); print(test)},
           error = function(e) {stop("Input all dates in 'YYYY-MM-DD' format")})
  tryCatch({test <- as.Date(to); print(test)},
           error = function(e) {stop("Input all dates in 'YYYY-MM-DD' format")})
  if(as.Date(from) > as.Date(to)) stop("Date put into parameter 'from' is later than date put into parameter 'to'")

  #Getting list of individual dates
  from1 <- as.Date(from)
  to1 <- as.Date(to)
  date_list <- seq(from1, to1, by = 1)

  #RAINFALL
  #Define function which can then be mapped over list of dates
  rain_result <- function(date) {
    rainfall_URL <- "https://api.data.gov.sg/v1/environment/rainfall"
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = rainfall_URL, query = query_params)
    json <- httr::content(get_result)
    rain_df <- json[[2]] %>% purrr::map(as.data.frame) %>% data.table::rbindlist(fill = T)
    values <- rain_df %>% dplyr::select(names(rain_df) %>% stringr::str_detect("value") %>% which())
    values_stns_count <- is.na(values) %>% apply(FUN = function(x) length(names(values)) - sum(x), MARGIN = 1)
    values_stns_sum <- values %>% apply(FUN = function(x) sum(x, na.rm = T), MARGIN = 1)
    values$avg <- values_stns_sum/values_stns_count
    values <- cbind(timestamp = rain_df$timestamp %>%
                      as.POSIXct(tryFormats = c("%Y-%m-%dT%H:%M:%OS")) %>%
                      as.character(),
                    values)
    values %<>% dplyr::mutate(hour = lubridate::hour(timestamp))

    rainfall <- values %>%
      dplyr::group_by(hour) %>%
      dplyr::summarise(count = n())

    hr_list = seq.POSIXt(as.POSIXct(as.character(date)),
                         as.POSIXct(as.character(date)) + 82800,
                         by = "1 hour") %>% as.character()
    rainfall %<>% cbind(aggregate(values$avg, by = list(values$hour), FUN = sum), hr_list) %>% dplyr::mutate(a = x*12/count) %>% select(hr_list, a)
    names(rainfall) <- c("Hour", "Average Hourly Rainfall")
    rainfall$Hour %<>% as.character()
    return(rainfall)
  }
  #Map function over list of dates to get list of daily dataframes
  df_list <- purrr::map(date_list, rain_result)
  #Binds list of daily dataframes into one
  rainfall_df <- data.table::rbindlist(df_list, fill = T)

  #UV INDEX
  #Define function which can then be mapped over list of dates
  uv_result <- function(date) {
    UV_URL <- "https://api.data.gov.sg/v1/environment/uv-index"
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = UV_URL, query = query_params)
    json <- httr::content(get_result)
    hr_list = seq.POSIXt(as.POSIXct(as.character(date)),
                         as.POSIXct(as.character(date)) + 82800,
                         by = "1 hour") %>% as.character()
    uv <- jsonlite::fromJSON(jsonlite::toJSON(json[[1]][[length(json[[1]])]]))[[3]] %>% as.data.frame()
    uv$time <- uv$timestamp %>% as.character() %>% as.POSIXct(tryFormats = c("%Y-%m-%dT%H:%M:%OS")) %>%
      as.character()
    uv$value %<>% unlist()
    uv <- data.frame(time = hr_list, stringsAsFactors = F) %>% left_join(uv %>% select(time, value), by = c("time" = "time"))
    uv$value[is.na(uv$value)] <- 0
    names(uv) <- c("Hour", "UV Index")
    return(uv)
  }
  #Map function over list of dates to get list of daily dataframes
  uv_list <- purrr::map(date_list, uv_result)
  #Binds list of daily dataframes into one
  uv_df <- data.table::rbindlist(uv_list)

  #AIR TEMPERATURE
  #Define function which can then be mapped over list of dates
  temp_result <- function(date) {
    temp_URL <- "https://api.data.gov.sg/v1/environment/air-temperature"
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = temp_URL, query = query_params)
    json <- httr::content(get_result)
    temp_df <- json[[2]] %>% purrr::map(as.data.frame) %>% data.table::rbindlist(fill = T)

    values <- temp_df %>% dplyr::select(names(temp_df) %>% stringr::str_detect("value") %>% which())
    values_stns_count <- is.na(values) %>% apply(FUN = function(x) length(names(values)) - sum(x), MARGIN = 1)
    values_stns_sum <- values %>% apply(FUN = function(x) sum(x, na.rm = T), MARGIN = 1)
    values$avg <- values_stns_sum/values_stns_count
    values <- cbind(timestamp = temp_df$timestamp %>%
                      as.POSIXct(tryFormats = c("%Y-%m-%dT%H:%M:%OS")) %>%
                      as.character(),
                    values)
    values %<>% dplyr::mutate(hour = lubridate::hour(timestamp))

    temp <- values %>%
      dplyr::group_by(hour) %>%
      dplyr::summarise(count = n())

    hr_list = seq.POSIXt(as.POSIXct(as.character(date)),
                         as.POSIXct(as.character(date)) + 82800,
                         by = "1 hour") %>% as.character()
    temp %<>% cbind(aggregate(values$avg, by = list(values$hour), FUN = mean), hr_list) %>% select(hr_list, x)
    names(temp) <- c("Hour", "Average Air Temperature")
    temp$Hour %<>% as.character()
    return(temp)
  }
  #Map function over list of dates to get list of daily dataframes
  temp_list <- purrr::map(date_list, temp_result)
  #Binds list of daily dataframes into one
  temp_df <- data.table::rbindlist(temp_list, fill = T)

  #GET PSI 24-HOURLY
  #Define function which can then be mapped over list of dates
  psi_result <- function(date) {
    psi_URL <- "https://api.data.gov.sg/v1/environment/psi"
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = psi_URL, query = query_params)
    json <- httr::content(get_result)
    days <- json[[2]] %>% purrr::map(as.data.frame)
    to_select <- stringr::str_detect(names(days[[1]]), "national")
    to_select[1:2] <- c(TRUE, TRUE)
    psi <- purrr::map(days, function (x) x[to_select]) %>% data.table::rbindlist()
    psi$time <- psi$timestamp %>% as.character() %>% as.POSIXct(tryFormats = c("%Y-%m-%dT%H:%M:%OS")) %>%
      as.character()
    psi %<>% dplyr::select(time, readings.psi_twenty_four_hourly.national)
    names(psi) <- c("Hour", "PSI 24-Hourly")
    return(psi)
  }
  #Map function over list of dates to get list of daily dataframes
  psi_list <- purrr::map(date_list, psi_result)
  #Binds list of daily dataframes into one
  psi_df <- data.table::rbindlist(psi_list)

  #HUMIDITY
  #Define function which can then be mapped over list of dates
  humid_result <- function(date) {
    humid_URL <- "https://api.data.gov.sg/v1/environment/relative-humidity"
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = humid_URL, query = query_params)
    json <- httr::content(get_result)
    humid_df <- json[[2]] %>% purrr::map(as.data.frame) %>% data.table::rbindlist(fill = T)
    values <- humid_df %>% dplyr::select(names(humid_df) %>% stringr::str_detect("value") %>% which())
    values_stns_count <- is.na(values) %>% apply(FUN = function(x) length(names(values)) - sum(x), MARGIN = 1)
    values_stns_sum <- values %>% apply(FUN = function(x) sum(x, na.rm = T), MARGIN = 1)
    values$avg <- values_stns_sum/values_stns_count
    values <- cbind(timestamp = humid_df$timestamp %>%
                      as.POSIXct(tryFormats = c("%Y-%m-%dT%H:%M:%OS")) %>%
                      as.character(),
                    values)
    values %<>% dplyr::mutate(hour = lubridate::hour(timestamp))

    humid <- values %>%
      dplyr::group_by(hour) %>%
      dplyr::summarise(count = n())

    hr_list = seq.POSIXt(as.POSIXct(as.character(date)),
                         as.POSIXct(as.character(date)) + 82800,
                         by = "1 hour") %>% as.character()
    humid %<>% cbind(aggregate(values$avg, by = list(values$hour), FUN = mean), hr_list) %>% select(hr_list, x)
    names(humid) <- c("Hour", "Average Relative Humidity")
    humid$Hour %<>% as.character()
    return(humid)
  }
  #Map function over list of dates to get list of daily dataframes
  humid_list <- purrr::map(date_list, humid_result)
  #Binds list of daily dataframes into one
  humid_df <- data.table::rbindlist(humid_list, fill = T)

  df <- left_join(rainfall_df, uv_df, by = c("Hour" = "Hour")) %>%
    left_join(temp_df, by = c("Hour" = "Hour")) %>%
    left_join(psi_df, by = c("Hour" = "Hour")) %>%
    left_join(humid_df, by = c("Hour" = "Hour"))
  return(df)
}
