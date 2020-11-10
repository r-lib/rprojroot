test_that("has_file", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(
      find_root_file("c", criterion = "b/a", path = path),
      file.path(hierarchy(2L), "c")
    ),
    # Absolute paths are stripped
    expect_equal(
      find_root_file("/x", "y", criterion = "b/a", path = path),
      file.path("/x", "y")
    ),
    expect_identical(
      find_root_file("c", NA, criterion = "b/a", path = path),
      NA_character_
    ),
    expect_identical(
      find_root_file("c", character(), criterion = "b/a", path = path),
      character()
    ),
    expect_error(
      find_root_file(letters[1:2], letters[1:3], criterion = "a", path = path)
    ),
    expect_error(
      find_root_file(letters[1:2], character(), criterion = "a", path = path)
    ),
    expect_error(
      find_root_file(c("b", "/x"), "c", criterion = "a", path = path),
      "absolute and relative"
    )
  )
})
