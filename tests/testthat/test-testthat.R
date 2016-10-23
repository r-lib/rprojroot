context("testthat")

test_that("is_testthat", {
  expect_match(format(is_testthat), "^.*Directory name is 'testthat' .* subdirectories.*'tests/testthat'.*'testthat'.*$")

  testthat_path <- normalizePath("package/tests/testthat", winslash = "/")
  expect_equal(is_testthat$find_file(path = "package"), testthat_path)
  expect_equal(is_testthat$find_file(path = "package/tests"), testthat_path)
  expect_equal(is_testthat$find_file(path = "package/tests/testthat"), testthat_path)
})
