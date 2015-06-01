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
#' @inheritParams find_root_file
#' @return The normalized path of the root as specified by the search criterion.
#'   Throws an error if no root is found
#'
#' @examples
#' \dontrun{
#' find_root(glob2rx("DESCRIPTION"), "^Package: ")
#' }
#'
#' @seealso \code{\link[utils]{glob2rx}} \code{\link{file.path}}
#'
#' @export
find_root <- function(criterion, path = ".") {
  criterion <- as.root_criterion(criterion)

  original_path <- path
  path <- normalizePath(path, winslash = "/", mustWork = TRUE)

  for (i in seq_len(.MAX_DEPTH)) {
    if (criterion$testfun(path)) {
      return(path)
    }

    if (is_root(path)) {
      stop("No root directory found. Test criterion:\n",
           criterion$desc, call. = FALSE)
    }

    path <- dirname(path)
  }

  stop("Maximum search of ", .MAX_DEPTH, " exceeded. Last path: ", path)
}

.MAX_DEPTH <- 100L

# Borrowed from devtools
is_root <- function(path) {
  identical(normalizePath(path, winslash = "/"),
            normalizePath(dirname(path), winslash = "/"))
}
