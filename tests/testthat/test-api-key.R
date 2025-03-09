test_that("assert.api.key requires API key", {
  unset.omdb.api.key()
  expect_error(
    get.accurate.omdb.info("tt1285016"), 
    regexp = "OMDB API key not set"
  )
})


test_that("set_omdb_api_key validates input", {
  # Test invalid input
  expect_error(set.omdb.api.key(123), "API key must be a character string")
  expect_error(set.omdb.api.key(NULL), "API key must be a character string")
  
  # Test valid input
  expect_invisible(set.omdb.api.key("valid_key"))
}) 

