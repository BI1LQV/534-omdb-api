utils::globalVariables(".pkgenv")

#' Fetch movie information from OMDB API by ID or title
#' @param id Optional IMDb ID (e.g. "tt1285016")
#' @param title Optional movie title to search for
#' @param type Optional type of result ("movie", "series", or "episode")
#' @param year Optional year of release
#' @param plot Optional plot length ("short" or "full")
#' @return Movie data from OMDB API
#' @export
get.accurate.omdb.info <- function(id = NULL,
                          title = NULL,
                          type = NULL,
                          year = NULL, 
                          plot = "short") {

  # Check that at least id or title is provided
  if (is.null(id) && is.null(title)) {
    stop("Must provide either IMDb ID or movie title")
  }
  
  # Validate type parameter if provided
  if (!is.null(type) && !type %in% c("movie", "series", "episode")) {
    stop("Type must be one of: movie, series, episode")
  }
  
  # Validate plot parameter
  if (!plot %in% c("short", "full")) {
    stop("Plot must be either 'short' or 'full'")
  }

  api_key <- if (!exists("omdb_api_key", envir = .pkgenv)) {
    stop("OMDB API key not set. Use set.omdb.api.key() first. If you don't have one, please register at https://www.omdbapi.com/apikey.aspx")
  } else {
    get("omdb_api_key", envir = .pkgenv)
  }
  # Build query parameters
  params <- list(
    apikey = api_key,
    i = id,
    t = title,
    type = type,
    y = year,
    plot = plot,
    r = "json"
  )

  # Remove NULL parameters
  params <- params[!sapply(params, is.null)]

  # Make API request
  response <- httr::GET(
    "http://www.omdbapi.com/",
    query = params
  )

  httr::content(response, "parsed")

}

#' Fetch movie information from OMDB API
#' @param ids IMDb IDs of the movies (e.g. c("tt1285016", "tt1285017"))
#' @return List containing movie information from OMDB API
#' @export
get.batch.accurate.omdb.info <- function(ids) {
  # Create a list of promises for each ID
  promises <- lapply(ids, function(id) {
    future::future({
      get.accurate.omdb.info(id)
    })
  })
  
  # Resolve all promises in parallel
  results <- future::value(promises)

  # Return the results
  results
}
