format_lines <- function(n) {
  if (n == 1) "line" else paste0(n, " lines")
}

#' @details
#' The `has_file()` function constructs a criterion that checks for the
#' existence of a specific file (which itself can be in a subdirectory of the
#' root) with specific contents.
#'
#' @rdname root_criterion
#' @param filepath File path (can contain directories)
#' @param contents Regular expression to match the file contents
#' @inheritParams base::readLines
#' @export
has_file <- function(filepath, contents = NULL, n = -1L) {
  force(filepath)
  force(contents)
  force(n)

  testfun <- eval(bquote(function(path) {
    testfile <- file.path(path, .(filepath))
    if (!file.exists(testfile)) {
      return(FALSE)
    }
    if (is_dir(testfile)) {
      return(FALSE)
    }
    match_contents(testfile, .(contents), .(n))
  }))

  desc <- paste0(
    "contains a file `", filepath, "`",
    if (!is.null(contents)) {
      paste0(
        " with contents matching `", contents, "`",
        if (n >= 0L) paste0(" in the first ", format_lines(n))
      )
    }
  )

  root_criterion(testfun, desc)
}

#' @details
#' The `has_dir()` function constructs a criterion that checks for the
#' existence of a specific directory.
#'
#' @rdname root_criterion
#' @export
has_dir <- function(filepath) {
  force(filepath)

  testfun <- eval(bquote(function(path) {
    testfile <- file.path(path, .(filepath))
    if (!file.exists(testfile)) {
      return(FALSE)
    }
    is_dir(testfile)
  }))

  desc <- paste0("contains a directory `", filepath, "`")

  root_criterion(testfun, desc)
}

#' @details
#' The `has_file_pattern()` function constructs a criterion that checks for the
#' existence of a file that matches a pattern, with specific contents.
#'
#' @rdname root_criterion
#' @param pattern Regular expression to match the file name
#' @inheritParams base::readLines
#' @export
has_file_pattern <- function(pattern, contents = NULL, n = -1L) {
  force(pattern)
  force(contents)
  force(n)

  testfun <- eval(bquote(function(path) {
    files <- list_files(path, .(pattern))
    for (f in files) {
      if (!match_contents(f, .(contents), .(n))) {
        next
      }
      return(TRUE)
    }
    return(FALSE)
  }))

  desc <- paste0(
    "contains a file matching `", pattern, "`",
    if (!is.null(contents)) {
      paste0(
        " with contents matching `", contents, "`",
        if (n >= 0L) paste0(" in the first ", format_lines(n))
      )
    }
  )

  root_criterion(testfun, desc)
}

#' @details
#' The `has_dirname()` function constructs a criterion that checks if the
#' [base::dirname()] has a specific name.
#'
#' @rdname root_criterion
#' @param dirname A directory name, without subdirectories
#' @export
has_dirname <- function(dirname, subdir = NULL) {
  force(dirname)

  testfun <- eval(bquote(function(path) {
    dir.exists(file.path(dirname(path), .(dirname)))
  }))

  desc <- paste0("directory name is `", dirname, "`")

  root_criterion(testfun, desc, subdir = subdir)
}

#' @export
is_rstudio_project <- has_file_pattern("[.]Rproj$", contents = "^Version: ", n = 1L)

#' @export
is_r_package <- has_file("DESCRIPTION", contents = "^Package: ")

#' @export
is_remake_project <- has_file("remake.yml")

#' @export
is_drake_project <- has_dir(".drake")

#' @export
is_projectile_project <- has_file(".projectile")

#' @export
is_git_root <- has_dir(".git") | has_file(".git", contents = "^gitdir: ")

#' @export
is_svn_root <- has_dir(".svn")

#' @export
is_vcs_root <- is_git_root | is_svn_root

#' @export
is_testthat <- has_dirname("testthat", c("tests/testthat", "testthat"))

#' @export
from_wd <- root_criterion(function(path) TRUE, "from current working directory")

#' Prespecified criteria
#'
#' This is a collection of commonly used root criteria.
#'
#' @export
criteria <- structure(
  list(
    is_rstudio_project = is_rstudio_project,
    is_r_package = is_r_package,
    is_remake_project = is_remake_project,
    is_projectile_project = is_projectile_project,
    is_git_root = is_git_root,
    is_svn_root = is_svn_root,
    is_vcs_root = is_vcs_root,
    is_testthat = is_testthat,
    from_wd = from_wd
  ),
  class = "root_criteria"
)

#' @export
#' @importFrom utils str
str.root_criteria <- function(object, ...) {
  str(lapply(object, format))
}

#' @details
#' `is_rstudio_project` looks for a file with extension `.Rproj`.
#'
#' @rdname criteria
#' @export
"is_rstudio_project"

#' @details
#' `is_r_package` looks for a `DESCRIPTION` file.
#'
#' @rdname criteria
#' @export
"is_r_package"

#' @details
#' `is_remake_project` looks for a `remake.yml` file.
#'
#' @rdname criteria
#' @export
"is_remake_project"

#' @details
#' `is_drake_project` looks for a `.drake` directory.
#'
#' @rdname criteria
#' @export
"is_drake_project"

#' @details
#' `is_projectile_project` looks for a `.projectile` file.
#'
#' @rdname criteria
#' @export
"is_projectile_project"

#' @details
#' `is_git_root` looks for a `.git` directory.
#'
#' @rdname criteria
#' @export
"is_git_root"

#' @details
#' `is_svn_root` looks for a `.svn` directory.
#'
#' @rdname criteria
#' @export
"is_svn_root"

#' @details
#' `is_vcs_root` looks for the root of a version control
#' system, currently only Git and SVN are supported.
#'
#' @rdname criteria
#' @export
"is_vcs_root"

#' @details
#' `is_testthat` looks for the `testthat` directory, works when
#'   developing, testing, and checking a package.
#'
#' @rdname criteria
#' @export
"is_testthat"

#' @details
#' `from_wd` uses the current working directory.
#'
#' @rdname criteria
#' @export
"from_wd"


list_files <- function(path, filename) {
  files <- dir(path = path, pattern = filename, all.files = TRUE, full.names = TRUE)
  dirs <- is_dir(files)
  files <- files[!dirs]
  files
}

is_dir <- function(x) {
  dir.exists(x)
}

match_contents <- function(f, contents, n) {
  if (is.null(contents)) {
    return(TRUE)
  }

  fc <- readLines(f, n)
  any(grepl(contents, fc))
}
