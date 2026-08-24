pkg_path <- function(...) normalizePath(file.path(...), winslash = "/")

test_that("a DESCRIPTION without a `Package:` field is not a package", {
  dir <- withr::local_tempdir()
  file.create(file.path(dir, "DESCRIPTION"))
  dir.create(file.path(dir, "pkg-r"))
  file.create(file.path(dir, "pkg-r", "DESCRIPTION"))
  expect_error(
    find_package_root_file(path = dir),
    "No root directory found"
  )
})

test_that("package at the root wins over a well-known subdirectory", {
  expect_equal(
    find_package_root_file(path = "monorepo-root-wins"),
    pkg_path("monorepo-root-wins")
  )
})

test_that("package in a well-known subdirectory is found", {
  expect_equal(
    find_package_root_file(path = "monorepo"),
    pkg_path("monorepo", "pkg-r")
  )
  expect_equal(
    find_package_root_file(path = "monorepo/js"),
    pkg_path("monorepo", "pkg-r")
  )
  expect_equal(
    find_package_root_file("DESCRIPTION", path = "monorepo"),
    pkg_path("monorepo", "pkg-r", "DESCRIPTION")
  )
})

test_that("well-known subdirectories are consulted in order", {
  expect_equal(
    find_package_root_file(path = "monorepo-priority"),
    pkg_path("monorepo-priority", "pkg-r")
  )
})

test_that("`PackagePath:` wins over a well-known subdirectory", {
  expect_equal(
    find_package_root_file(path = "monorepo-rproj"),
    pkg_path("monorepo-rproj", "rkeops")
  )
})

test_that("a `PackagePath:` without a package warns and falls back", {
  expect_warning(
    path <- find_package_root_file(path = "monorepo-bad-rproj"),
    "Ignoring 'PackagePath: does-not-exist'"
  )
  expect_equal(path, pkg_path("monorepo-bad-rproj", "pkg-r"))
})

test_that("more than one .Rproj file warns and is skipped", {
  expect_warning(
    path <- find_package_root_file(path = "monorepo-two-rproj"),
    "expected at most one, found 2"
  )
  expect_equal(path, pkg_path("monorepo-two-rproj", "pkg-r"))
})

# The fixtures above live inside rprojroot itself, so a failed search would
# find rprojroot's own DESCRIPTION; the cases below need an isolated hierarchy.
local_monorepo <- function(rproj = NULL, .env = parent.frame()) {
  dir <- withr::local_tempdir(.local_envir = .env)
  dir.create(file.path(dir, "pkg-r"))
  writeLines("Package: isolated", file.path(dir, "pkg-r", "DESCRIPTION"))
  if (!is.null(rproj)) {
    writeLines(c("Version: 1.0", rproj), file.path(dir, "isolated.Rproj"))
  }
  normalizePath(dir, winslash = "/")
}

test_that("`subdirs = NULL` restores the historical behavior", {
  dir <- local_monorepo()
  expect_error(
    find_package_root_file(path = dir, subdirs = NULL),
    "No root directory found"
  )
  expect_equal(find_package_root_file(path = dir), file.path(dir, "pkg-r"))
})

test_that("`subdirs = character()` consults .Rproj files only", {
  dir <- local_monorepo(rproj = "PackagePath: pkg-r")
  expect_equal(
    find_package_root_file(path = dir, subdirs = character()),
    file.path(dir, "pkg-r")
  )

  bare <- local_monorepo()
  expect_error(
    find_package_root_file(path = bare, subdirs = character()),
    "No root directory found"
  )
})

test_that("no package anywhere is an error", {
  dir <- withr::local_tempdir()
  expect_error(
    find_package_root_file(path = dir),
    "No root directory found"
  )
})

test_that("absolute paths are passed through", {
  expect_equal(
    find_package_root_file("/absolute", path = "not-a-package"),
    "/absolute"
  )
})

test_that("r_package_subdirs()", {
  expect_snapshot(r_package_subdirs())
  expect_snapshot(package_root_desc(r_package_subdirs()))
})
