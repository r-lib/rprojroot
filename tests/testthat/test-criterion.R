context("criterion")

test_that(".root_criterion", {
  expect_error(root_criterion(5, "Bogus"), "must be a function with one argument")
  expect_error(root_criterion(identity, "Bogus"), "must be a function with one argument")
  expect_true(is.root_criterion(root_criterion(function(path) FALSE, "Never")))
})

test_that("is.root_criterion", {
  expect_true(is.root_criterion(has_file("DESCRIPTION")))
  expect_false(is.root_criterion("DESCRIPTION"))
  expect_true(is.root_criterion(as.root_criterion("DESCRIPTION")))
  expect_equal(as.root_criterion("x"), has_file("x"))
  expect_error(as.root_criterion(5), "Cannot coerce")
})

test_that("Absolute paths are returned", {
  expect_equal(find_root("DESCRIPTION"), normalizePath(find_root("DESCRIPTION")))
})
