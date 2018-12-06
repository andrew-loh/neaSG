#' Gets UV levels in Singapore for specified set of dates.
#'
#' Returns a dataframe of UV levels for dates between starting and final date.
#'
#' User inputs a starting and final date. UV levels are then given for all dates from the starting date to the final date, inclusive. Data is available for when the sun is up - from 0700 to 1900hrs.
#'
#' @import magrittr
#' @import dplyr
#' @param from Starting date. Must be a character string, in "YYYY-MM-DD" format.
#' @param to Final date, inclusive. Must be a character string, in "YYYY-MM-DD" format.
#' @return UV levels in Singapore for dates between starting and final date.
#' @examples
#' get_UV("2017-12-31", "2018-01-04")
#' @export

get_UV <- function(from, to){
  requireNamespace("magrittr")
  if(class(from) != "character") stop("Parameter 'from' must be character string")
  if(class(to) != "character") stop("Parameter 'to' must be character string")
  tryCatch({test <- as.Date(from); print(test)},
           error = function(e){stop("Input all dates in 'YYYY-MM-DD' format")})
  tryCatch({test <- as.Date(to); print(test)},
           error = function(e){stop("Input all dates in 'YYYY-MM-DD' format")})
  if(as.Date(from) > as.Date(to)) stop("Date put into parameter 'from' is later than date put into parameter 'to'")

  #Getting list of individual dates
  from1 <- as.Date(from)
  to1 <- as.Date(to)
  date_list <- seq(from1, to1, by = 1)

  #Endpoint for API
  URL <- "https://api.data.gov.sg/v1/environment/uv-index"

  #Define function which can then be mapped over list of dates
  fn_result <- function(date) {
    query_params <- list(
      "date" = date
    )
    get_result <- httr::GET(url = URL, query = query_params)
    json <- httr::content(get_result)
    return(jsonlite::fromJSON(jsonlite::toJSON(json[[1]][[length(json[[1]])]]))[[3]])
  }

  #Map function over list of dates to get list of daily dataframes
  df_list <- purrr::map(date_list, fn_result)

  #Binds list of daily dataframes into one
  df <- data.table::rbindlist(df_list)
  return(df)
}
