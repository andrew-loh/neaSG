#' Gets pollutant levels in Singapore for specified set of dates.
#'
#' Returns a dataframe of pollutant levels for dates between starting and final date for national and 5 subnational regions.
#'
#' User inputs a starting and final date. Hourly pollutant levels are then given for all dates from the starting date to the final date, inclusive. Data is provided for national and 5 subnational regions, in the form of 12 pollutant indices: O3 Sub-Index, PM10 24-hourly, PM10 Sub-Index, CO Sub-Index, PM2.5 24-Hourly, SO2 Sub-Index, CO 8-Hour-Max, NO2 1-Hour-Max, SO2 24-Hourly, PM2.5 Sub-Index, PSI 24-Hourly and O3 8-Hour Max
#'
#' @import magrittr
#' @import dplyr
#' @param from Starting date. Must be a character string, in "YYYY-MM-DD" format.
#' @param to Final date, inclusive. Must be a character string, in "YYYY-MM-DD" format.
#' @param natl_only True or False, defaults to true. If true, returns only national values. If false, returns data for national and 5 subnational regions.
#' @return Pollutant indices readings in Singapore for national and subnational regions for selected dates.
#' @examples
#' get_pollutants("2017-12-31", "2018-01-04")
#' #' get_pollutants("2018-07-05", "2018-08-06", natl_only = F)
#' @export

get_pollutants <- function(from, to, natl_only = T) {
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

  #Endpoint for API
  URL <- "https://api.data.gov.sg/v1/environment/psi"

  #Define function which can then be mapped over list of dates
  fn_result <- function(date) {
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = URL, query = query_params)
    json <- httr::content(get_result)
    days <- json[[2]] %>% purrr::map(as.data.frame)
    if (natl_only == F) {
      return(json[[2]] %>% purrr::map(as.data.frame) %>% data.table::rbindlist)
    }
    if (natl_only == T) {
      to_select <- stringr::str_detect(names(days[[1]]), "national")
      to_select[1:2] <- c(TRUE, TRUE)
      return(purrr::map(days, function (x) x[to_select]) %>% data.table::rbindlist())
    }
  }

  #Map function over list of dates to get list of daily dataframes
  df_list <- purrr::map(date_list, fn_result)

  #Binds list of daily dataframes into one
  df <- data.table::rbindlist(df_list)
  return(df)
}
