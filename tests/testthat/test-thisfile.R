context("thisfile")

test_that("thisfile works with source", {
  res <- source("scripts/thisfile.R")
  expect_true(grepl("thisfile.R$", res$value))
})

test_that("thisfile works with Rscript", {
  p <- pipe("Rscript scripts/thisfile-cat.R")
  on.exit(close(p))
  res <- readLines(p)
  expect_equal("scripts/thisfile-cat.R", res)
})

test_that("thisfile works with R", {
  p <- pipe("R --quiet --vanilla --no-save -f scripts/thisfile-cat.R")
  on.exit(close(p))
  res <- readLines(p)
  expect_equal("scripts/thisfile-cat.R", res[[2]])
})

test_that("thisfile works with knitr", {
  out <- tempfile(pattern = "rprojroot", fileext = ".md")
  knitr::knit("scripts/thisfile.Rmd", output = out, quiet = TRUE)
  res <- readLines(out)
  expect_equal("scripts/thisfile.Rmd", res)
})
