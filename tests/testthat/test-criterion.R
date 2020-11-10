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
  expect_match(
    paste(format(is_r_package), collapse = "\n"),
    "^Root criterion: .*DESCRIPTION"
  )
  expect_output(print(is_r_package), "^Root criterion: .*DESCRIPTION")
  expect_output(print(is_vcs_root), "^Root criterion: one of\n- .*[.]git.*\n- .*[.]svn")
})

test_that("Formatting criteria", {
  expect_output(
    str(criteria),
    "^List of "
  )
})

test_that("Combining criteria", {
  skip_on_cran()

  comb_crit <- is_r_package | is_rstudio_project

  expect_true(is_root_criterion(comb_crit))

  expect_match(paste0(format(comb_crit), collapse = "\n"), "\n- .*\n- ")

  expect_equal(
    find_root(comb_crit, "hierarchy"),
    find_root(is_rstudio_project, "hierarchy/a")
  )
})
