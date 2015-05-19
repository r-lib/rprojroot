context("root")

test_that("", {
  wd <- normalizePath(getwd())
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  with_mock(
    `rprojroot:::is_root` = function(x) x == stop_path,
    expect_equal(find_root(glob2rx("a"), path = path), hierarchy(3L)),
    expect_equal(find_root(glob2rx("b"), path = path), hierarchy(3L)),
    expect_equal(find_root(glob2rx("c"), path = path), hierarchy(1L)),
    expect_equal(find_root(glob2rx("d"), path = path), hierarchy(4L)),
    expect_equal(find_root(glob2rx("DESCRIPTION"), "^Package: ", 1, path = path), hierarchy(1L)),
    expect_equal(find_root(glob2rx("DESCRIPTION"), "^Package: ", path = path), hierarchy(1L)),
    expect_error(find_root(glob2rx("test-root.R"), path = path), "No file .* found"),
    expect_error(find_root(glob2rx("rprojroot.Rproj"), path = path), "No file .* found"),
    expect_error(find_root(glob2rx("e"), "f", path = path),
                 "No file .* with contents"),
    expect_error(find_root(glob2rx("e"), "f", 1, path = path),
                 "No file .* with contents .* in the first .* lines")
  )
})
