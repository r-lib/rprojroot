context("criterion")

test_that("is.root_criterion", {
  expect_true(is.root_criterion(has_file("DESCRIPTION")))
  expect_false(is.root_criterion("DESCRIPTION"))
  expect_true(is.root_criterion(as.root_criterion("DESCRIPTION")))
  expect_equal(as.root_criterion("x"), has_file("x"))
})
