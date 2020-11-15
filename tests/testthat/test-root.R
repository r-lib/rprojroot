
test_that("is_root_criterion", {
  expect_true(is_root_criterion(has_file("DESCRIPTION")))
  expect_false(is_root_criterion("DESCRIPTION"))
  expect_true(is_root_criterion(as_root_criterion("DESCRIPTION")))
})

test_that("as_root_criterion", {
  reset_env <- function(x) {
    if (is.function(x)) {
      environment(x) <- .GlobalEnv
    } else if (is.list(x)) {
      x <- lapply(x, reset_env)
    }
    x
  }

  expect_equal(
    lapply(as_root_criterion("x"), reset_env),
    lapply(has_file("x"), reset_env)
  )
  expect_error(as_root_criterion(5), "Cannot coerce")
})

test_that("Formatting", {
  expect_snapshot(format(is_r_package))
  expect_snapshot(is_r_package)
  expect_snapshot(is_vcs_root)
  expect_snapshot(has_file("a", contents = "foo", fixed = TRUE))
  expect_snapshot(has_file_pattern("a.*b", contents = "foo", fixed = TRUE))
  expect_snapshot(criteria)
  expect_snapshot(str(criteria))
})

test_that("Combining criteria", {
  comb_crit <- is_r_package | is_rstudio_project

  expect_true(is_root_criterion(comb_crit))

  expect_snapshot(comb_crit)

  expect_equal(
    find_root(comb_crit, "hierarchy"),
    find_root(is_rstudio_project, "hierarchy/a")
  )
})

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
    expect_equal(find_root("c", path = path), hierarchy(1L)),
    expect_equal(find_root("d", path = path), hierarchy(4L)),
    expect_equal(find_root(has_file("DESCRIPTION", "^Package: ", 1), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file("DESCRIPTION", "^Package: "), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file("DESCRIPTION", "package* does", fixed = TRUE), path = path), hierarchy(1L)),
    expect_error(
      find_root("test-root.R", path = path),
      "No root directory found"
    ),
    expect_error(
      find_root("rprojroot.Rproj", path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_file("e", "f"), path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_file("e", "f", 1), path = path),
      "No root directory found"
    ),
    expect_error(has_file("/a"), "absolute"),
    TRUE
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
    expect_equal(
      find_root(has_file_pattern("[ab]", "File b"), path = path),
      hierarchy(3L)
    ),
    expect_equal(
      find_root(has_file_pattern("[ab]", "File b in root"), path = path),
      hierarchy(1L)
    ),
    expect_equal(find_root(has_file_pattern(glob2rx("c")), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file_pattern(glob2rx("d")), path = path), hierarchy(4L)),
    expect_equal(find_root(has_file_pattern(glob2rx("DES*ION"), "^Package: ", 1), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file_pattern(glob2rx("DESCRI?TION"), "^Package: "), path = path), hierarchy(1L)),
    expect_equal(find_root(has_file_pattern(glob2rx("D?SCRIPTI?N"), "package* does", fixed = TRUE), path = path), hierarchy(1L)),
    expect_error(
      find_root(has_file_pattern(glob2rx("test-root.R")), path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_file_pattern(glob2rx("rprojroot.Rproj")), path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_file_pattern(glob2rx("e"), "f"), path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_file_pattern(glob2rx("e"), "f", 1), path = path),
      "No root directory found"
    ),
    TRUE
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
    expect_equal(find_root(has_dir("c"), path = path), hierarchy(3L)),
    expect_error(
      find_root(has_dir("e"), path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_dir("rprojroot.Rproj"), path = path),
      "No root directory found"
    ),
    expect_error(has_dir("/a"), "absolute"),
    TRUE
  )
})

test_that("has_basename", {
  wd <- normalizePath(getwd(), winslash = "/")
  hierarchy <- function(n = 0L) {
    do.call(file.path, list(wd, "hierarchy", "a", "b", "c")[seq_len(n + 1L)])
  }

  stop_path <- hierarchy(1L)
  path <- hierarchy(4L)

  mockr::with_mock(
    is_root = function(x) x == stop_path,
    expect_equal(find_root(has_basename("a"), path = path), hierarchy(2L)),
    expect_equal(find_root(has_basename("b"), path = path), hierarchy(3L)),
    expect_equal(find_root(has_basename("c"), path = path), hierarchy(4L)),
    expect_error(
      find_root(has_basename("d"), path = path),
      "No root directory found"
    ),
    expect_error(
      find_root(has_basename("rprojroot.Rproj"), path = path),
      "No root directory found"
    ),
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
    expect_error(
      find_root(is_svn_root, path = hierarchy(0L)),
      "No root directory found"
    ),
    expect_error(
      find_root(is_vcs_root, path = hierarchy(0L)),
      "No root directory found"
    ),
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
    expect_error(
      find_root(is_git_root, path = hierarchy(0L)),
      "No root directory found"
    ),
    expect_error(
      find_root(is_vcs_root, path = hierarchy(0L)),
      "No root directory found"
    ),
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
    expect_error(
      find_root(is_git_root, path = hierarchy(0L)),
      "No root directory found"
    ),
    expect_error(
      find_root(is_vcs_root, path = hierarchy(0L)),
      "No root directory found"
    ),
    TRUE
  )
})

test_that("finds root", {
  skip_on_cran()
  # Checks that search for root actually terminates
  expect_error(
    find_root("9259cfa7884bf51eb9dd80b52c26dcdf9cd28e82"),
    "No root directory found"
  )
})

test_that("stops if depth reached", {
  find_root_mocked <- find_root
  mock_env <- new.env()
  mock_env$dirname <- identity
  environment(find_root_mocked) <- mock_env

  # Checks that search for root terminates for very deep hierarchies
  expect_error(find_root_mocked(""), "Maximum search of [0-9]+ exceeded")
})
