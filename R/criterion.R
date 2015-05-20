#' Is a directory the project root?
#'
#' TBD
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
