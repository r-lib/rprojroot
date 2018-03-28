context("make")

test_that("Shortcuts", {
  expect_equal(make_find_root_file("testthat.R")("testthat"),
               normalizePath(getwd(), winslash = "/"))

  R <- make_fix_root_file("testthat.R", getwd())
  oldwd <- setwd("~")
  on.exit(setwd(oldwd))

  expect_equal(normalizePath(R("testthat"), mustWork = TRUE),
               normalizePath(oldwd, mustWork = TRUE))
})
