#' Is a directory the project root?
#'
#' Objects of the \code{root_criterion} class decide if a
#' given directory is a project root.
#'
#' Construct criteria using \code{root_criterion} in a very general fashion
#' by specifying a function with a \code{path} argument, and a description.
#' The \code{has_file} function constructs a criterion that checks for the
#' existence of a specific file with specific contents.
#'
#' @param testfun A function with one parameter that returns \code{TRUE}
#'   if the directory specified by this parameter is the project root,
#'   and \code{FALSE} otherwise
#' @param desc A textual description of the test criterion
#'
#' @export
root_criterion <- function(testfun, desc) {
  if (!isTRUE(all.equal(names(formals(testfun)), "path"))) {
    stop("testfun must be a function with one argument 'path'")
  }
  structure(
    list(
      testfun = testfun,
      desc = desc
    ),
    class = "root_criterion"
  )
}

#' @export
format.root_criterion <- function(x, ...) {
  paste("Root criterion:", x$desc)
}

#' @export
print.root_criterion <- function(x, ...) {
  cat(paste0(format(x), "\n"))
}
