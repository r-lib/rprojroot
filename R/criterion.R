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
#' @return
#' An S3 object of class \code{root_criterion} wit the following members:
#'
#' @include rrmake.R
#' @export
#'
#' @examples
#' root_criterion(function(path) file.exists(file.path(path, "somefile")), "Has somefile")
#' has_file("DESCRIPTION")
#' is_r_package
#' is_r_package$find_file
#' \dontrun{
#' is_r_package$make_fix_file(".")
#' }
root_criterion <- function(testfun, desc) {
  if (!isTRUE(all.equal(names(formals(testfun)), "path"))) {
    stop("testfun must be a function with one argument 'path'")
  }
  criterion <- structure(
    list(
      #' @return
      #' \describe{
      #'   \item{\code{testfun}}{The \code{testfun} argument}
      testfun = testfun,
      #'   \item{\code{desc}}{The \code{desc} argument}
      desc = desc
    ),
    class = "root_criterion"
  )

  #'   \item{\code{find_file}}{A function with \code{...} argument that returns
  #'     for a path relative to the root specified by this criterion.
  #'     The optional \code{path} argument specifies the starting directory,
  #'     which defaults to \code{"."}.
  #'   }
  criterion$find_file <- make_find_root_file(criterion)
  #'   \item{\code{make_fix_file}}{A function with a \code{path} argument that
  #'      returns a function that finds paths relative to the root.  For a
  #'      criterion \code{cr}, the result of \code{cr$make_fix_file(".")(...)}
  #'      is identical to \code{cr$find_file(...)}. The function created by
  #'      \code{make_fix_file} can be saved to a variable to be more independent
  #'      of the current working directory.
  #'   }
  #' }
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

#' @export
`|.root_criterion` <- function(x, y) {
  stopifnot(is.root_criterion(y))

  root_criterion(
    function(path) x$testfun(path) || y$testfun(path),
    paste0(x$desc, ", or ", y$desc)
  )
}
