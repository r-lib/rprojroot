#' Is a directory the project root?
#'
#' Objects of the \code{root_criterion} class decide if a
#' given directory is a project root.
#'
#' Construct criteria using \code{root_criterion} in a very general fashion
#' by specifying a function with a \code{path} argument, and a description.
#'
#' @param testfun A function with one parameter that returns \code{TRUE}
#'   if the directory specified by this parameter is the project root,
#'   and \code{FALSE} otherwise
#' @param desc A textual description of the test criterion
#'
#' @include rrmake.R
#' @export
root_criterion <- function(testfun, desc) {
  if (!isTRUE(all.equal(names(formals(testfun)), "path"))) {
    stop("testfun must be a function with one argument 'path'")
  }
  criterion <- structure(
    list(
      testfun = testfun,
      desc = desc
    ),
    class = "root_criterion"
  )

  criterion$find_file <- make_find_root_file(criterion)
  criterion$make_fix_file <-
    function(path = getwd()) make_fix_root_file(criterion, path)

  criterion
}

#' @rdname root_criterion
#' @param x An object
#' @export
is.root_criterion <- function(x) {
  inherits(x, "root_criterion")
}

#' @rdname root_criterion
#' @export
as.root_criterion <- function(x) UseMethod("as.root_criterion", x)

#' @details
#' The \code{as.root_criterion} function accepts objects of class
#' \code{root_criterion}, and character values; the latter will be
#' converted to criteria using \code{has_file}.
#'
#' @rdname root_criterion
#' @export
as.root_criterion.character <- function(x) {
  has_file(x)
}

#' @rdname root_criterion
#' @export
as.root_criterion.root_criterion <- identity

#' @export
as.root_criterion.default <- function(x) {
  stop("Cannot coerce ", x, " to type root_criterion.")
}

#' @export
format.root_criterion <- function(x, ...) {
  paste("Root criterion:", x$desc)
}

#' @export
print.root_criterion <- function(x, ...) {
  cat(paste0(format(x), "\n"))
}
