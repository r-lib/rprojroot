context("thisfile")

test_that("thisfile works with source", {
  skip_on_cran()
  res <- source("scripts/thisfile.R")
  expect_true(grepl("thisfile.R$", res$value))
})

test_that("thisfile works with Rscript", {
  skip_on_cran()
  p <- pipe("Rscript scripts/thisfile-cat.R")
  on.exit(close(p))
  res <- readLines(p)
  expect_equal("scripts/thisfile-cat.R", res[[length(res)]])
})

test_that("thisfile works with R", {
  skip_on_cran()
  p <- pipe("R --slave --vanilla --no-save -f scripts/thisfile-cat.R")
  on.exit(close(p))
  res <- readLines(p)
  expect_equal("scripts/thisfile-cat.R", res[[length(res)]])
})

test_that("thisfile works with knitr", {
  skip_if_not_installed("knitr")
  out <- tempfile(pattern = "rprojroot", fileext = ".md")
  expect_message(
    knitr::knit("scripts/thisfile.Rmd", output = out, quiet = TRUE),
    normalizePath("scripts/thisfile.Rmd"),
    fixed = TRUE
  )
})

test_that("thisfile works with rmarkdown", {
  skip_if_not_installed("rmarkdown")
  skip_if_not(rmarkdown::pandoc_available())

  out <- tempfile(pattern = "rprojroot", fileext = ".md")
  expect_message(
    rmarkdown::render(
      "scripts/thisfile.Rmd", output_file = out,
      output_format = "md_document", quiet = TRUE
    ),
    normalizePath("scripts/thisfile.Rmd"),
    fixed = TRUE
  )
})

test_that("thisfile works with spin", {
  skip("TODO")
  out <- tempfile(pattern = "rprojroot", fileext = ".md")
  knitr::spin("scripts/thisfile-cat.R", format = "Rmd", precious = TRUE)
  res <- readLines(out)
  expect_equal(normalizePath("scripts/thisfile.Rmd"), normalizePath(res))
})

test_that("thisfile works with rendering an R script", {
  skip("TODO")
  out <- tempfile(pattern = "rprojroot", fileext = ".md")
  rmarkdown::render("scripts/thisfile-cat.R", output_file = out,
                    output_format = "md_document", quiet = TRUE)
  res <- readLines(out)
  expect_equal(normalizePath("scripts/thisfile.Rmd"), normalizePath(res))
})
