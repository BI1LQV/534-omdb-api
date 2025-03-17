# 534-omdb-api

[![R Package CI/CD](https://github.com/bi1lqv/534-omdb-api/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/bi1lqv/534-omdb-api/actions/workflows/R-CMD-check.yml/badge.svg)

An R package for interacting with the OMDB (Open Movie Database) API.

## Installation

You can install the development version from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("bi1lqv/534-omdb-api")
```

## Usage

```r
library(OMDB.API)

set.omdb.api.key("YOUR KEY")
movie_info_1 <- get.accurate.omdb.info(title = "Avengers")
print(movie_info_1)
```

See more details in [vignettes](./vignettes/package-vignette.Rmd).

## Development

This project uses Github Action for continuous integration. The build status badge above shows the current state of the master branch. See more details in [code of conduct](./CODE_OF_CONDUCT.md).

## License

This project is licensed under the terms of the MIT License - see the [LICENSE](LICENSE) file for details.
