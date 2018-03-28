#' Is a directory the project root?
#'
#' Objects of the `root_criterion` class decide if a
#' given directory is a project root.
#'
#' Construct criteria using `root_criterion` in a very general fashion
#' by specifying a function with a `path` argument, and a description.
#'
#' @param testfun A function with one parameter that returns `TRUE`
#'   if the directory specified by this parameter is the project root,
#'   and `FALSE` otherwise. Can also be a list of such functions.
#' @param desc A textual description of the test criterion, of the same length
#'   as `testfun`
#' @param subdir Subdirectories to start the search in, if found
#'
#' @return
#' An S3 object of class `root_criterion` wit the following members:
#'
#' @include rrmake.R
#' @export
#'
#' @examples
#' root_criterion(function(path) file.exists(file.path(path, "somefile")), "has somefile")
#' has_file("DESCRIPTION")
#' is_r_package
#' is_r_package$find_file
#' \dontrun{
#' is_r_package$make_fix_file(".")
#' }
root_criterion <- function(testfun, desc, subdir = NULL) {
  testfun <- check_testfun(testfun)

  stopifnot(length(desc) == length(testfun))

  full_desc <- paste0(
    desc,
    if (!is.null(subdir)) {
      paste0(
        " (also look in subdirectories: ",
        paste0("`", subdir, "`", collapse = ", "),
        ")"
      )
    }
  )

  criterion <- structure(
    list(
      #' @return
      #' \describe{
      #'   \item{`testfun`}{The `testfun` argument}
      testfun = testfun,
      #'   \item{`desc`}{The `desc` argument}
      desc = full_desc,
      #'   \item{`subdir`}{The `subdir` argument}
      subdir = subdir
    ),
    class = "root_criterion"
  )

  #'   \item{`find_file`}{A function with `...` argument that returns
  #'     for a path relative to the root specified by this criterion.
  #'     The optional `path` argument specifies the starting directory,
  #'     which defaults to `"."`.
  #'   }
  criterion$find_file <- make_find_root_file(criterion)
  #'   \item{`make_fix_file`}{A function with a `path` argument that
  #'      returns a function that finds paths relative to the root.  For a
  #'      criterion `cr`, the result of `cr$make_fix_file(".")(...)`
  #'      is identical to `cr$find_file(...)`. The function created by
  #'      `make_fix_file` can be saved to a variable to be more independent
  #'      of the current working directory.
  #'   }
  #' }
  criterion$make_fix_file <-
    function(path = getwd(), subdir = NULL) {
      make_fix_root_file(criterion, path, subdir)
    }

  criterion
}

check_testfun <- function(testfun) {
  if (is.function(testfun)) {
    testfun <- list(testfun)
  }

  for (f in testfun) {
    if (!isTRUE(all.equal(names(formals(f)), "path"))) {
      stop("All functions in testfun must have exactly one argument 'path'")
    }
  }

  testfun
}

#' @rdname root_criterion
#' @param x An object
#' @export
is_root_criterion <- function(x) {
  inherits(x, "root_criterion")
}

#' @rdname deprecated
#' @inheritParams is_root_criterion
#' @export
is.root_criterion <- function(x) {
  .Deprecated("is_root_criterion")
  is_root_criterion(x)
}

#' @rdname root_criterion
#' @export
as_root_criterion <- function(x) UseMethod("as_root_criterion", x)

#' @rdname deprecated
#' @export
as.root_criterion <- function(x) {
  .Deprecated("as_root_criterion")
  UseMethod("as.root_criterion", x)
}

#' @details
#' The `as.root_criterion()` function accepts objects of class
#' `root_criterion`, and character values; the latter will be
#' converted to criteria using `has_file`.
#'
#' @rdname root_criterion
#' @export
as_root_criterion.character <- function(x) {
  has_file(x)
}

#' @rdname root_criterion
#' @export
as_root_criterion.root_criterion <- identity

#' @export
as_root_criterion.default <- function(x) {
  stop("Cannot coerce ", x, " to type root_criterion.")
}

#' @export
as.root_criterion.default <- function(x) {
  as_root_criterion(x)
}

#' @export
format.root_criterion <- function(x, ...) {
  if (length(x$desc) > 1) {
    c("Root criterion: one of", paste0("- ", x$desc))
  } else {
    paste0("Root criterion: ", x$desc)
  }
}

#' @export
print.root_criterion <- function(x, ...) {
  cat(format(x), sep = "\n")
  invisible(x)
}

#' @export
#' @rdname root_criterion
#' @details Root criteria can be combined with the `|` operator. The result is a
#'   composite root criterion that requires either of the original criteria to
#'   match.
#' @param y An object
`|.root_criterion` <- function(x, y) {
  stopifnot(is_root_criterion(y))

  root_criterion(
    c(x$testfun, y$testfun),
    c(x$desc, y$desc)
  )
}
