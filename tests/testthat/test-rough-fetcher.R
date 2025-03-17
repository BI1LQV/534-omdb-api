setup({
  set.omdb.api.key("22bda3a2") # key for test
})

# Test input parameter validation
test_that("get.rough.omdb.info validates input parameters", {
  # Test title is not empty
  expect_error(
    get.rough.omdb.info(NULL),
    "Movie title is required for rough search"
  )
  
  # Test invalid type parameter
  expect_error(
    get.rough.omdb.info(title = "Avengers", type = "invalid"),
    "Type must be one of: movie, series, episode"
  )
  
  # Test invalid year parameter
  expect_error(
    get.rough.omdb.info(title = "Avengers", year = "abc"),
    "Year must be numeric"
  )
  
  # Test invalid min_rating parameter
  expect_error(
    get.rough.omdb.info("Avengers", min_rating = -1),
    "min_rating must be a numeric value between 0 and 10"
  )
  expect_error(
    get.rough.omdb.info("Avengers", min_rating = 11),
    "min_rating must be a numeric value between 0 and 10"
  )
})

# Test successful rough search with valid parameters
test_that("get.rough.omdb.info works with valid parameters", {
  result <- get.rough.omdb.info(title = "Avengers")
  expect_true("Title" %in% colnames(result))
  expect_true("Year" %in% colnames(result))
  expect_true("Type" %in% colnames(result))
  expect_true("imdbID" %in% colnames(result))
  expect_true("Genre" %in% colnames(result))
  expect_true("imdbRating" %in% colnames(result))
})

# Test filtering by Genre
test_that("get.rough.omdb.info filters by genre", {
  result <- get.rough.omdb.info(title = "Avengers", genre = "Action")
  expect_true(all(grepl("Action", result$Genre, ignore.case = TRUE)))
})

# Test filtering by MinRating
test_that("get.rough.omdb.info filters by minimum rating", {
  result <- get.rough.omdb.info(title = "Avengers", min_rating = 7)
  expect_true(all(result$imdbRating >= 7, na.rm = TRUE))
})

# Test sorting functionality
test_that("get.rough.omdb.info sorts movies correctly based on sort_order", {
  # Test invalid sort_order
  expect_error(
    get.rough.omdb.info("Avengers", sort_order = "invalid"),
    "sort_order must be one of: 'desc', 'asc', or 'none'"
  )
  
  # Test descending order
  result_desc <- get.rough.omdb.info("Avengers", sort_order = "desc")
  expect_true(all(diff(result_desc$imdbRating) <= 0, na.rm = TRUE))
  
  # Test ascending order
  result_asc <- get.rough.omdb.info("Avengers", sort_order = "asc")
  expect_true(all(diff(result_asc$imdbRating) >= 0, na.rm = TRUE))
  
  # Test no sorting (none)
  result_none <- get.rough.omdb.info("Avengers", sort_order = "none")
  # Compare with default behavior
  result_default <- get.rough.omdb.info("Avengers")
  expect_equal(result_none$imdbRating, result_default$imdbRating)
})
