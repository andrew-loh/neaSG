#' Gets per-minute air temperature readings in Singapore for specified set of dates.
#'
#' Returns a dataframe of per-minute air temperature readings for specified dates for various weather stations in Singapore.
#'
#' User inputs a starting and final date. Per-minute air temperature readings are then given for all dates from the starting date to the final date, inclusive. Temperature is in degrees Celsius. Data is provided for up to 16 weather stations across Singapore, depending on availability of data. To obtain location of weather stations, use function get_weatherstns.
#'
#' @import magrittr
#' @import dplyr
#' @param from Starting date. Must be a character string, in "YYYY-MM-DD" format.
#' @param to Final date, inclusive. Must be a character string, in "YYYY-MM-DD" format.
#' @return Per-minute air temperature readings in Singapore for various weather stations.
#' @examples
#' get_airtemp("2017-12-31", "2018-01-04")
#' @export

get_airtemp <- function(from, to) {
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
  URL <- "https://api.data.gov.sg/v1/environment/air-temperature"

  #Define function which can then be mapped over list of dates
  fn_result <- function(date) {
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = URL, query = query_params)
    json <- httr::content(get_result)
    return(json[[2]] %>% purrr::map(as.data.frame) %>% data.table::rbindlist(fill = T))
  }

  #Map function over list of dates to get list of daily dataframes
  df_list <- purrr::map(date_list, fn_result)

  #Binds list of daily dataframes into one
  df <- data.table::rbindlist(df_list, fill = T)
  return(df)
}
