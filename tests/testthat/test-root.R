context("root")

test_that("has_file", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
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
                 "No root directory found.* file `.*`"),
    expect_error(find_root("rprojroot.Rproj", path = path),
                 "No root directory found.* file `.*`"),
    expect_error(find_root(has_file("e", "f"), path = path),
                 "No root directory found.* file `.*` with contents"),
    expect_error(find_root(has_file("e", "f", 1), path = path),
                 "No root directory found.* file `.*` with contents .* in the first line")
  )
})

test_that("has_file_pattern", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
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
                 "No root directory found.* with contents .* in the first line")
  )
})

test_that("has_dir", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(has_dir("a"), path = path), hierarchy(1L)),
    expect_equal(find_root(has_dir("b"), path = path), hierarchy(2L)),
    expect_equal(find_root_file("c", criterion = has_dir("b"), path = path),
                 file.path(hierarchy(2L), "c")),
    expect_equal(find_root(has_dir("c"), path = path), hierarchy(3L)),
    expect_error(find_root(has_dir("d"), path = path),
                 "No root directory found.* a directory `.*`"),
    expect_error(find_root(has_dir("rprojroot.Rproj"), path = path),
                 "No root directory found.* a directory `.*`"),
    TRUE
  )
})

test_that("has_dirname", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(has_dirname("a"), path = path), hierarchy(2L)),
    expect_equal(find_root(has_dirname("b"), path = path), hierarchy(3L)),
    expect_equal(find_root_file("c", criterion = has_dirname("b"), path = path),
                 file.path(hierarchy(3L), "c")),
    expect_equal(find_root(has_dirname("c"), path = path), hierarchy(4L)),
    expect_error(find_root(has_dirname("d"), path = path),
                 "No root directory found.* is `.*`"),
    expect_error(find_root(has_dirname("rprojroot.Rproj"), path = path),
                 "No root directory found.* is `.*`"),
    TRUE
  )
})

test_that("concrete criteria", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  # HACK
  writeLines(character(), file.path(hierarchy(3L), ".projectile"))

  stop_path <- hierarchy(0L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(is_rstudio_project, path = path), hierarchy(1L)),
    expect_equal(find_root(is_remake_project, path = path), hierarchy(2L)),
    expect_equal(find_root(is_projectile_project, path = path), hierarchy(3L)),
    TRUE
  )
})

test_that("is_svn_root", {
  temp_dir <- tempfile("svn")
  unzip("vcs/svn.zip", exdir = temp_dir)
  wd <- normalizePath(temp_dir, winslash = "/")

  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "svn", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- normalizePath(tempdir(), winslash = "/")
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(is_svn_root, path = path), hierarchy(1L)),
    expect_equal(find_root(is_vcs_root, path = path), hierarchy(1L)),
    expect_error(find_root(is_svn_root, path = hierarchy(0L)),
                 "No root directory found.* a directory `.*`"),
    expect_error(find_root(is_vcs_root, path = hierarchy(0L)),
                 "No root directory found.* a directory `.*`"),
    TRUE
  )
})

setup_git_root <- function(separate_git_dir = FALSE) {
  temp_dir <- tempfile("git")
  unzip("vcs/git.zip", exdir = temp_dir)
  wd <- normalizePath(temp_dir, winslash = "/")

  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "git", "a", "b", "c")[seq_len(n + 1L)])
  }

  if (separate_git_dir) {
    # Copy .git dir to a separate location, then make a .git file.
    # (other_git_folder becomes a bare git repo)
    old_git_location <- file.path(wd, "git", ".git")
    new_git_location <- file.path(wd, "other_git_folder")
    file.rename(old_git_location, new_git_location)
    writeLines(paste("gitdir:", new_git_location), old_git_location)
  }
  return(hierarchy)
}

test_that("is_git_root", {
  hierarchy <- setup_git_root(separate_git_dir = FALSE)

  path <- hierarchy(4L)
  stop_path <- normalizePath(tempdir(), winslash = "/")

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(is_git_root, path = path), hierarchy(1L)),
    expect_equal(find_root(is_vcs_root, path = path), hierarchy(1L)),
    expect_error(find_root(is_git_root, path = hierarchy(0L)),
                 "No root directory found.* a directory `.*`"),
    expect_error(find_root(is_vcs_root, path = hierarchy(0L)),
                 "No root directory found.* a directory `.*`"),
    TRUE
  )
})

test_that("is_git_root for separated git directory", {
  hierarchy <- setup_git_root(separate_git_dir = TRUE)
  path <- hierarchy(4L)
  stop_path <- normalizePath(tempdir(), winslash = "/")

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(is_git_root, path = path), hierarchy(1L)),
    expect_equal(find_root(is_vcs_root, path = path), hierarchy(1L)),
    expect_error(find_root(is_git_root, path = hierarchy(0L)),
                 "No root directory found.* a directory `.*`"),
    expect_error(find_root(is_vcs_root, path = hierarchy(0L)),
                 "No root directory found.* a directory `.*`"),
    TRUE
  )
})

test_that("finds root", {
  skip_on_cran()
  # Checks that search for root actually terminates
  expect_error(find_root("/"), "No root directory found.* file `.*`")
})

test_that("stops if depth reached", {
  find_root_mocked <- find_root
  mock_env <- new.env()
  mock_env$dirname <- identity
  environment(find_root_mocked) <- mock_env

  # Checks that search for root terminates for very deep hierarchies
  expect_error(find_root_mocked(""), "Maximum search of [0-9]+ exceeded")
})
