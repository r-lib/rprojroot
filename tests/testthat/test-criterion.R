context("criterion")

test_that("root_criterion", {
  expect_error(
    suppressWarnings(root_criterion(5, "Bogus")),
    "must have exactly one argument"
  )
  expect_error(root_criterion(identity, "Bogus"), "must have exactly one argument")
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
  expect_equal(find_root("testthat.R"),
               normalizePath(find_root("testthat.R"), winslash = "/"))
})

test_that("Formatting", {
  expect_match(paste(format(is_r_package), collapse = "\n"),
               "^Root criterion: .*DESCRIPTION")
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

  expect_true(is.root_criterion(comb_crit))

  expect_match(paste0(format(comb_crit), collapse = "\n"), "\n- .*\n- ")

  expect_equal(find_root(comb_crit, "hierarchy"),
               find_root(is_rstudio_project, "hierarchy/a"))
})
