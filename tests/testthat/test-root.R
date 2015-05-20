context("root")

test_that("has_file", {
  wd <- normalizePath(getwd())
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  with_mock(
    `rprojroot:::is_root` = function(x) x == stop_path,
    expect_equal(find_root(has_file("a"), path = path), hierarchy(3L)),
    expect_equal(find_root(has_file("b"), path = path), hierarchy(3L)),
    expect_equal(find_root(has_file("b/a"), path = path), hierarchy(2L)),
    expect_equal(find_root(has_file("c"), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file("d"), path = path), hierarchy(4L)),
    expect_equal(find_root(has_file("DESCRIPTION", "^Package: ", 1), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file("DESCRIPTION", "^Package: "), path = path), hierarchy(1L)),
    expect_error(find_root(has_file("test-root.R"), path = path),
                 "No root directory found.* file '.*'"),
    expect_error(find_root(has_file("rprojroot.Rproj"), path = path),
                 "No root directory found.* file '.*'"),
    expect_error(find_root(has_file("e", "f"), path = path),
                 "No root directory found.* file '.*' with contents"),
    expect_error(find_root(has_file("e", "f", 1), path = path),
                 "No root directory found.* file '.*' with contents .* in the first .* lines")
  )
})

test_that("has_file_pattern", {
  wd <- normalizePath(getwd())
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  with_mock(
    `rprojroot:::is_root` = function(x) x == stop_path,
    expect_equal(find_root(has_file_pattern(glob2rx("a")), path = path), hierarchy(3L)),
    expect_equal(find_root(has_file_pattern(glob2rx("b")), path = path), hierarchy(3L)),
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
