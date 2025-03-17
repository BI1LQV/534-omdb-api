utils::globalVariables(".pkgenv")

#' Fetch movie information from OMDB API by partial title and additional filters
#' @param title Partial movie title to search for
#' @param type Optional type of result ("movie", "series", or "episode")
#' @param year Optional year of release
#' @param min_rating Optimal minimum rating for the movie
#' @param genre Optional genre filter
#' @param sort_order Optional sorting order for ratings ("desc", "asc", or "none", default is "none")
#' @return A data frame with movies matching the search criteria
#' @export
get.rough.omdb.info <- function(title,
                                type = NULL,
                                year = NULL,
                                min_rating = NULL,
                                genre = NULL,
                                sort_order = "none") {
  
  # Check that the title is provided
  if (is.null(title)) {
    stop("Movie title is required for rough search")
  }
  
  # Validate type parameter if provided
  if (!is.null(type) && !type %in% c("movie", "series", "episode")) {
    stop("Type must be one of: movie, series, episode")
  }
  
  # Validate year parameter if provided
  if (!is.null(year) && !is.numeric(year)) {
    stop("Year must be numeric")
  }
  
  # Validate min_rating parameter if provided
  if (!is.null(min_rating) && (!is.numeric(min_rating) || min_rating < 0 || min_rating > 10)) {
    stop("min_rating must be a numeric value between 0 and 10")
  }
  
  # Validate sort_order parameter
  if (!sort_order %in% c("desc", "asc", "none")) {
    stop("sort_order must be one of: 'desc', 'asc', or 'none'")
  }
  
  # Fetch the OMDB API key.
  api_key <- if (!exists("omdb_api_key", envir = .pkgenv)) {
    stop("OMDB API key not set. Use set.omdb.api.key() first. If you don't have one, please register at https://www.omdbapi.com/apikey.aspx")
  } else {
    get("omdb_api_key", envir = .pkgenv)
  }
  
  # Build query parameters
  params <- list(
    apikey = api_key,
    s = title,
    type = type,
    y = year,
    r = "json"
  )
  
  # Remove NULL parameters
  params <- params[!sapply(params, is.null)]
  
  # Make API request
  response <- httr::GET(
    "http://www.omdbapi.com/",
    query = params
  )
  
  # Check for a successful response
  if (httr::status_code(response) != 200) {
    stop("Failed to retrieve data from OMDB API")
  }
  
  # Get the response data
  response_data <- httr::content(response, "parsed")
  
  # Get movie list and convert to dataframe
  movies <- response_data$Search
  
  movies_df <- data.frame(
    Title = sapply(movies, function(x) x$Title),
    Year = sapply(movies, function(x) x$Year),
    Type = sapply(movies, function(x) x$Type),
    imdbID = sapply(movies, function(x) x$imdbID),
    Poster = sapply(movies, function(x) x$Poster),  # Added Poster for completeness
    stringsAsFactors = FALSE
  )
  
  # Add additional information (Genre and ImdbRating) to the dataframe
  detailed_info <- sapply(movies_df$imdbID, function(id) {
    get.accurate.omdb.info(id = id)
  })
  
  movies_df$Genre <- sapply(detailed_info, function(d) ifelse(!is.null(d$Genre), d$Genre, NA))
  movies_df$imdbRating <- sapply(detailed_info, function(d) ifelse(!is.null(d$imdbRating), as.numeric(d$imdbRating), NA))
  
  # Apply additional filters (Genre and MinRating) if provided
  if (!is.null(genre)) {
    movies_df <- movies_df[grepl(genre, movies_df$Genre, ignore.case = TRUE), ]
  }
  
  if (!is.null(min_rating)) {
    movies_df <- movies_df[!is.na(movies_df$imdbRating) & movies_df$imdbRating >= min_rating, ]
  }
  
  # Reorder movies based on sort_order (if specified)
  if (sort_order != "none") {
    movies_df <- movies_df[order(ifelse(sort_order == "desc", -1, 1) * movies_df$imdbRating, 
                                na.last = TRUE), ]
  }
  
  # Return the filtered data frame
  return(movies_df)
}
