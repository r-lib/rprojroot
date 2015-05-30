context("make")

test_that("Shortcuts", {
  expect_equal(make_find_root_file("testthat.R")("testthat"),
               normalizePath(getwd()))

  R <- make_fix_root_file("testthat.R")
  oldwd <- setwd("~")
  on.exit(setwd(oldwd))

  expect_equal(R("testthat"), oldwd)
})
