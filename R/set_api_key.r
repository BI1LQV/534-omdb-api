.pkgenv <- new.env(parent = emptyenv())

#' Set OMDB API key for making requests
#' @param api_key Your OMDB API key string
#' @export
set.omdb.api.key <- function(api_key) {
  if (!is.character(api_key)) {
    stop("API key must be a character string")
  }

  # Store API key in package environment
  assign("omdb_api_key", api_key, envir = .pkgenv)

  invisible(TRUE)
}


#' Unset OMDB API key
#' @export
unset.omdb.api.key <- function() {
  if (exists("omdb_api_key", envir = .pkgenv)) {
    rm("omdb_api_key", envir = .pkgenv)
  }
  invisible(TRUE)
}
