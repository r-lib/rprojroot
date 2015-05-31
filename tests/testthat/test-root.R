context("root")

test_that("has_file", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  with_mock(
    `rprojroot:::is_root` = function(x) x == stop_path,
    expect_equal(find_root("a", path = path), hierarchy(3L)),
    expect_equal(find_root("b", path = path), hierarchy(3L)),
    expect_equal(find_root("b/a", path = path), hierarchy(2L)),
    expect_equal(find_root_file("c", criterion = "b/a", path = path),
                 file.path(hierarchy(2L), "c")),
    expect_equal(find_root("c", path = path), hierarchy(1L)),
    expect_equal(find_root("d", path = path), hierarchy(4L)),
    expect_equal(find_root(has_file("DESCRIPTION", "^Package: ", 1), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file("DESCRIPTION", "^Package: "), path = path), hierarchy(1L)),
    expect_error(find_root("test-root.R", path = path),
                 "No root directory found.* file '.*'"),
    expect_error(find_root("rprojroot.Rproj", path = path),
                 "No root directory found.* file '.*'"),
    expect_error(find_root(has_file("e", "f"), path = path),
                 "No root directory found.* file '.*' with contents"),
    expect_error(find_root(has_file("e", "f", 1), path = path),
                 "No root directory found.* file '.*' with contents .* in the first .* lines")
  )
})

test_that("has_file_pattern", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  with_mock(
    `rprojroot:::is_root` = function(x) x == stop_path,
    expect_equal(find_root(has_file_pattern(glob2rx("a")), path = path), hierarchy(3L)),
    expect_equal(find_root(has_file_pattern(glob2rx("b")), path = path), hierarchy(3L)),
    expect_equal(find_root(has_file_pattern("[ab]", "File b"), path = path),
                 hierarchy(3L)),
    expect_equal(find_root(has_file_pattern("[ab]", "File b in root"), path = path),
                 hierarchy(1L)),
    expect_equal(find_root(has_file_pattern(glob2rx("c")), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file_pattern(glob2rx("d")), path = path), hierarchy(4L)),
    expect_equal(find_root(has_file_pattern(glob2rx("DESCRIPTION"), "^Package: ", 1), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file_pattern(glob2rx("DESCRIPTION"), "^Package: "), path = path), hierarchy(1L)),
    expect_error(find_root(has_file_pattern(glob2rx("test-root.R")), path = path),
                 "No root directory found.* file matching "),
    expect_error(find_root(has_file_pattern(glob2rx("rprojroot.Rproj")), path = path),
                 "No root directory found.* file matching "),
    expect_error(find_root(has_file_pattern(glob2rx("e"), "f"), path = path),
                 "No root directory found.* with contents"),
    expect_error(find_root(has_file_pattern(glob2rx("e"), "f", 1), path = path),
                 "No root directory found.* with contents .* in the first .* lines")
  )
})

test_that("finds root", {
  skip_on_cran()
  # Checks that search for root actually terminates
  expect_error(find_root("/"), "No root directory found.* file '.*'")
})
