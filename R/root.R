#' Find the root of a directory hierarchy
#'
#' A \emph{root} is defined as a directory that contains a regular file
#' whose name matches a given pattern and which optionally contains a given text.
#' The search for a root starts at a given directory (the working directory
#' by default), and proceeds up the directory hierarchy.
#'
#' Starting from the working directory, the `find_root()` function searches
#' for the root.
#' If a root is found, the `...` arguments are used to construct a path;
#' thus, if no extra arguments are given, the root is returned.
#' If no root is found, an error is thrown.
#'
#' @inheritParams find_root_file
#' @return The normalized path of the root as specified by the search criterion.
#'   Throws an error if no root is found
#'
#' @examples
#' \dontrun{
#' find_root(glob2rx("DESCRIPTION"), "^Package: ")
#' }
#'
#' @seealso [utils::glob2rx()] [file.path()]
#'
#' @export
find_root <- function(criterion, path = ".") {
  criterion <- as_root_criterion(criterion)

  start_path <- get_start_path(path, criterion$subdir)
  path <- start_path

  for (i in seq_len(.MAX_DEPTH)) {
    for (f in criterion$testfun) {
      if (f(path)) {
        return(path)
      }
    }

    if (is_root(path)) {
      stop("No root directory found in ", start_path, " or its parent directories. ",
        paste(format(criterion), collapse = "\n"),
        call. = FALSE
      )
    }

    path <- dirname(path)
  }

  stop("Maximum search of ", .MAX_DEPTH, " exceeded. Last path: ", path, call. = FALSE)
}

.MAX_DEPTH <- 100L

get_start_path <- function(path, subdirs) {
  path <- normalizePath(path, winslash = "/", mustWork = TRUE)

  for (subdir in subdirs) {
    subdir_path <- file.path(path, subdir)
    if (dir.exists(subdir_path)) {
      return(subdir_path)
    }
  }

  path
}

# Borrowed from devtools
is_root <- function(path) {
  identical(
    normalizePath(path, winslash = "/"),
    normalizePath(dirname(path), winslash = "/")
  )
}

#' @rdname find_root
#' @description `get_root_desc()` returns the description of the criterion
#'   for a root path. This is especially useful for composite root criteria
#'   created with [|.root_criterion()].
#' @export
get_root_desc <- function(criterion, path) {
  for (i in seq_along(criterion$testfun)) {
    if (criterion$testfun[[i]](path)) {
      return(criterion$desc[[i]])
    }
  }

  stop("path is not a root. ",
    paste(format(criterion), collapse = "\n"),
    call. = FALSE
  )
}
