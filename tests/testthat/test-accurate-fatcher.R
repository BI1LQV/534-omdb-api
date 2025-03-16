setup({
  set.omdb.api.key("22bda3a2") # key for test
})


test_that("get.accurate.omdb.info validates input parameters", {
  # Test missing both id and title
  expect_error(
    get.accurate.omdb.info(),
    "Must provide either IMDb ID or movie title"
  )
  
  # Test invalid type parameter
  expect_error(
    get.accurate.omdb.info(id = "tt1285016", type = "invalid"),
    "Type must be one of: movie, series, episode"
  )
  
  # Test invalid plot parameter
  expect_error(
    get.accurate.omdb.info(id = "tt1285016", plot = "invalid"),
    "Plot must be either 'short' or 'full'"
  )
})

test_that("get.accurate.omdb.info can fetch movie by ID", {
  result <- get.accurate.omdb.info(id = "tt1285016")
  expect_type(result, "list")
  expect_equal(result$imdbID, "tt1285016")
}) 

test_that("get.batch.accurate.omdb.info can fetch multiple movies", {
  results <- get.batch.accurate.omdb.info(c("tt1285016", "tt1285017"))
  expect_type(results, "list")
  expect_equal(length(results), 2)
})

