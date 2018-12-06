#' Gets data on weather stations in Singapore.
#'
#' Returns a dataframe of weather station IDs, names and coordinates.
#'
#' @import magrittr
#' @import dplyr
#' @return Dataframe with weather station IDs, locations and latitude-longitude coordinates
#' @examples
#' get_weatherstns()
#' @export

get_weatherstns <- function() {
  requireNamespace("magrittr")
  #Endpoint for API
  URL <- "https://api.data.gov.sg/v1/environment/rainfall"

  #Define function which can then be mapped over list of dates
  query_params <- list(
    "date" = Sys.Date()
  )
  get_result <- httr::GET(url = URL, query = query_params)
  json <- httr::content(get_result)

  return(purrr::map(json[[1]][[1]], function(x) as.data.frame(x)) %>% data.table::rbindlist())
}

stns3 <- get_weatherstns()


