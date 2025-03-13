# 534-omdb-api

[![Travis build status](https://travis-ci.org/bi1lqv/534-omdb-api.svg?branch=master)](https://travis-ci.org/bi1lqv/534-omdb-api)

An R package for interacting with the OMDB (Open Movie Database) API.

## Installation

You can install the development version from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("bi1lqv/534-omdb-api")
```

## Usage

```r
library(omdbapi)

# Search for movies
search_movies("The Matrix")

# Get detailed information about a movie
get_movie("tt0133093")  # The Matrix
```

## Development

This project uses Travis CI for continuous integration. The build status badge above shows the current state of the master branch.

## License

This project is licensed under the terms of the MIT License - see the [LICENSE](LICENSE) file for details.
