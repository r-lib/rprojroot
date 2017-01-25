context("testthat")

test_that("is_testthat", {
  expect_match(paste(format(is_testthat), collapse = "\n"),
               "^.*directory name is `testthat` .* subdirectories.*`tests/testthat`.*`testthat`.*$")
  expect_match(paste(format(is_testthat), collapse = "\n"),
               "directory name is `testthat` .* subdirectories.*`tests/testthat`.*`testthat`.*")

  testthat_path <- normalizePath("package/tests/testthat", winslash = "/")
  expect_equal(is_testthat$find_file(path = "package"), testthat_path)
  expect_equal(is_testthat$find_file(path = "package/tests"), testthat_path)
  expect_equal(is_testthat$find_file(path = "package/tests/testthat"), testthat_path)
})

test_that("dogfood", {
  expect_true(file.exists(is_testthat$find_file("hierarchy", "a", "b", "c", "d")))
})
