test_that("Shortcuts", {
  expect_equal(
    make_find_root_file("testthat.R")("testthat"),
    normalizePath(getwd(), winslash = "/")
  )

  R <- make_fix_root_file("testthat.R", getwd())

  oldwd <- withr::local_dir("~")

  expect_equal(
    normalizePath(R("testthat"), mustWork = TRUE),
    normalizePath(oldwd, mustWork = TRUE)
  )

  path <- R()
  expect_equal(
    normalizePath(R(path, "testthat"), mustWork = TRUE),
    normalizePath(oldwd, mustWork = TRUE)
  )
})
