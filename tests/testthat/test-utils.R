test_that("match_contents in non-native encoding", {
  desc <- c("Package: test", "Author: Kirill M\xFCller", "Encoding: latin1")
  Encoding(desc) <- "latin1"
  writeLines(desc, descfile <- tempfile(), useBytes = TRUE)
  expect_silent(expect_true(
    rprojroot:::match_contents(descfile,
      contents = "^Package: ",
      n = -1L, fixed = FALSE
    )
  ))
})
