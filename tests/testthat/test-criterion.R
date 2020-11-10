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

test_that("root_criterion", {
  expect_error(
    suppressWarnings(root_criterion(5, "Bogus")),
    "must have exactly one argument"
  )
  expect_error(root_criterion(identity, "Bogus"), "must have exactly one argument")
  expect_true(is_root_criterion(root_criterion(function(path) FALSE, "Never")))
})

test_that("Absolute paths are returned", {
  expect_equal(
    find_root("testthat.R"),
    normalizePath(find_root("testthat.R"), winslash = "/")
  )
})
