#' @details
#' `r_package_subdirs()` returns the well-known subdirectories that
#' [find_package_root_file()] consults when a directory in the hierarchy
#' contains no `DESCRIPTION` file itself.
#' The convention is shared with the \pkg{pkgdepends} package, which applies it
#' when installing from a Git remote.
#'
#' @rdname find_root_file
#' @export
#' @examples
#' r_package_subdirs()
r_package_subdirs <- function() {
  c("pkg-r", "r", "R")
}

#' @details
#' `find_package_root_file()` also finds packages that live in a subdirectory
#' of a multi-language repository, e.g. a repository that contains an R package,
#' a Python package and a JavaScript library side by side.
#' For each directory in the hierarchy, the following are consulted in order:
#'
#' 1. the directory itself, if it contains a `DESCRIPTION` file;
#' 2. the directory given by the `PackagePath:` field of an RStudio project
#'    file (`.Rproj`) in that directory, if that directory contains a
#'    `DESCRIPTION` file;
#' 3. the `subdirs`, in the order given, the first one that contains a
#'    `DESCRIPTION` file.
#'
#' Pass `subdirs = NULL` to consult only the directories themselves, the
#' behavior of rprojroot 2.1.1 and earlier.
#'
#' @rdname find_root_file
#' @param subdirs `[character()]`\cr
#'   Well-known subdirectories that may contain the R package,
#'   consulted in the order given,
#'   by default the value of `r_package_subdirs()`.
#'   Pass `character()` to consult only `.Rproj` files,
#'   or `NULL` to disable both and require a `DESCRIPTION` file in the
#'   directories themselves.
#' @export
find_package_root_file <- function(..., path = ".", subdirs = r_package_subdirs()) {
  if (!missing(..1)) {
    abs <- is_absolute_path(..1)
    if (all(abs)) {
      return(path(...))
    }
    if (any(abs)) {
      stop("Combination of absolute and relative paths not supported.", call. = FALSE)
    }
  }

  root <- find_package_root(path = path, subdirs = subdirs)
  path(root, ...)
}

find_package_root <- function(path = ".", subdirs = r_package_subdirs()) {
  start_path <- normalizePath(path, winslash = "/", mustWork = TRUE)
  path <- start_path

  for (i in seq_len(.MAX_DEPTH)) {
    package_path <- package_dir(path, subdirs)
    if (!is.null(package_path)) {
      return(package_path)
    }

    if (is_fs_root(path)) {
      stop("No root directory found in ", start_path, " or its parent directories. ",
        paste(format(package_root_desc(subdirs)), collapse = "\n"),
        call. = FALSE
      )
    }

    path <- dirname(path)
  }

  stop("Maximum search of ", .MAX_DEPTH, " exceeded. Last path: ", path, call. = FALSE)
}

# Returns the directory of the R package reachable from `path`, or NULL
package_dir <- function(path, subdirs) {
  if (is_r_package_dir(path)) {
    return(path)
  }

  package_path <- rproj_package_path(path, enabled = !is.null(subdirs))
  if (!is.null(package_path)) {
    candidate <- file.path(path, package_path)
    if (is_r_package_dir(candidate)) {
      return(normalizePath(candidate, winslash = "/", mustWork = TRUE))
    }

    warning("Ignoring 'PackagePath: ", package_path, "' in ", path,
      ": no 'DESCRIPTION' file found in that directory.",
      call. = FALSE
    )
  }

  for (subdir in subdirs) {
    candidate <- file.path(path, subdir)
    if (is_r_package_dir(candidate)) {
      return(normalizePath(candidate, winslash = "/", mustWork = TRUE))
    }
  }

  NULL
}

is_r_package_dir <- function(path) {
  is_r_package$testfun[[1]](path)
}

# Returns the `PackagePath:` field of the single .Rproj file in `path`, or NULL
rproj_package_path <- function(path, enabled = TRUE) {
  if (!enabled) {
    return(NULL)
  }

  rproj_files <- list.files(path, pattern = "[.]Rproj$", full.names = TRUE)
  rproj_files <- rproj_files[!dir.exists(rproj_files)]

  if (length(rproj_files) == 0) {
    return(NULL)
  }

  if (length(rproj_files) > 1) {
    warning("Ignoring the RStudio project files in ", path,
      ": expected at most one, found ", length(rproj_files), ".",
      call. = FALSE
    )
    return(NULL)
  }

  read_package_path(rproj_files)
}

read_package_path <- function(rproj_file) {
  lines <- readLines(rproj_file, warn = FALSE)
  lines <- grep("^PackagePath:", lines, value = TRUE)

  if (length(lines) == 0) {
    return(NULL)
  }

  package_path <- trimws(sub("^PackagePath:", "", lines[[1]]))

  if (package_path == "") {
    return(NULL)
  }

  package_path
}

package_root_desc <- function(subdirs) {
  criterion <- is_r_package

  if (!is.null(subdirs)) {
    criterion <- criterion |
      root_criterion(
        function(path) FALSE,
        "contains an RStudio project file with a 'PackagePath:' field pointing to a package"
      )
  }

  for (subdir in subdirs) {
    criterion <- criterion | has_file(file.path(subdir, "DESCRIPTION"), contents = "^Package: ")
  }

  criterion
}
