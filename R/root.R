#' Find the root of a directory hierarchy
#'
#' A \emph{root} is defined as a directory that contains a regular file
#' whose name matches a given pattern and which optionally contains a given text.
#' The search for a root starts at a given directory (the working directory
#' by default), and proceeds up the directory hierarchy.
#'
#' Starting from the working directory, the \code{find_root} function searches
#' for the root.
#' If a root is found, the \code{...} arguments are used to construct a path;
#' thus, if no extra arguments are given, the root is returned.
#' If no root is found, an error is thrown.
#'
#' The function \code{make_find_root} can be used to create shorthand functions
#' such as \code{find_rstudio_root} and \code{find_package_root}.
#'
#' @param filename,contents Regular expressions to match the file name or contents
#' @param path The start directory
#' @inheritParams base::readLines
#' @param ... Additional arguments passed to \code{\link{file.path}}
#' @return The normalized path of the root as specified by the search criteria.
#'   Throws an error if no root is found
#'
#' @seealso \code{\link[utils]{glob2rx}} \code{\link{file.path}}
find_root <- function(filename, contents = NULL, n = -1L, ..., path = getwd()) {
  original_path <- path
  path <- normalizePath(path, mustWork = TRUE)

  repeat {
    files <- list_files(path, filename)
    for (f in files) {
      if (!match_contents(f, contents, n)) {
        next
      }
      return(file.path(path, ...))
    }

    if (is_root(path)) {
      stop("No file matching '", filename,
           if (!is.null(contents)) {
             paste0("' with contents matching '", contents, "'",
                    if (n >= 0L) paste(" in the first", n, "lines"))
           },
           " found in ", original_path, " or above", call. = FALSE)
    }

    path <- normalizePath(file.path(path, ".."))
  }
}

list_files <- function(path, filename) {
  files <- dir(path = path, pattern = filename, all.files = TRUE)
  files <- file.info(file.path(path, files), extra_cols = FALSE)
  files <- rownames(files)[!files$isdir]
  files
}

match_contents <- function(f, contents, n) {
  if (is.null(contents)) {
    return(TRUE)
  }

  fc <- readLines(f, n)
  any(grepl(contents, fc))
}

# Borrowed from devtools
is_root <- function(path) {
  identical(path, dirname(path))
}
