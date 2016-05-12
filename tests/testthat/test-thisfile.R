context("thisfile")

test_that("thisfile works with source", {
  res <- source("scripts/thisfile.R")
  expect_true(grepl("thisfile.R$", res$value))
})

test_that("thisfile works with Rscript", {
  skip("Doesn't seem to work for R CMD check")
  p <- pipe("Rscript scripts/thisfile-cat.R")
  on.exit(close(p))
  res <- readLines(p)
  expect_equal("scripts/thisfile-cat.R", res)
})
