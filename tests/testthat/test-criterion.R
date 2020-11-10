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

test_that("is_root_criterion", {
  expect_true(is_root_criterion(has_file("DESCRIPTION")))
  expect_false(is_root_criterion("DESCRIPTION"))
  expect_true(is_root_criterion(as_root_criterion("DESCRIPTION")))
})

test_that("as_root_criterion", {
  reset_env <- function(x) {
    if (is.function(x)) {
      environment(x) <- .GlobalEnv
    } else if (is.list(x)) {
      x <- lapply(x, reset_env)
    }
    x
  }

  expect_equal(
    lapply(as_root_criterion("x"), reset_env),
    lapply(has_file("x"), reset_env)
  )
  expect_error(as_root_criterion(5), "Cannot coerce")
})

test_that("Absolute paths are returned", {
  expect_equal(
    find_root("testthat.R"),
    normalizePath(find_root("testthat.R"), winslash = "/")
  )
})

test_that("Formatting", {
  expect_snapshot(format(is_r_package))
  expect_snapshot(is_r_package)
  expect_snapshot(is_vcs_root)
  expect_snapshot(criteria)
  expect_snapshot(str(criteria))
})

test_that("Combining criteria", {
  comb_crit <- is_r_package | is_rstudio_project

  expect_true(is_root_criterion(comb_crit))

  expect_snapshot(comb_crit)

  expect_equal(
    find_root(comb_crit, "hierarchy"),
    find_root(is_rstudio_project, "hierarchy/a")
  )
})
