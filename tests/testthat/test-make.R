context("make")

test_that("Shortcuts", {
  expect_equal(make_find_root_file(is_r_package)("tests", "testthat"), getwd())

  R <- make_fix_root_file(is_r_package)
  oldwd <- setwd("~")
  on.exit(setwd(oldwd))

  expect_equal(R("tests", "testthat"), oldwd)
})
