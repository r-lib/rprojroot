#' File paths relative to the root of a directory hierarchy
#'
#' Append an arbitrary number of path components to the root using
#' \code{\link[base]{file.path}}.
#'
#' The \code{find_root_file} function is a simple wrapper around
#' [find_root()] that
#' appends an arbitrary number of path components to the root using
#' \code{\link[base]{file.path}}.
#'
#' @param criterion A criterion, will be coerced using
#'   [as.root_criterion()]
#' @param path The start directory
#' @param ... Further path components passed to [file.path()]
#' @return The normalized path of the root as specified by the search criteria,
#'   with the additional path components appended.
#'   Throws an error if no root is found
#'
#' @examples
#' \dontrun{
#' find_package_root_file("tests", "testthat.R")
#' has_file("DESCRIPTION", "^Package: ")$find_file
#' has_file("DESCRIPTION", "^Package: ")$make_fix_file(".")
#' }
#'
#' @seealso [find_root()] \code{\link[utils]{glob2rx}} \code{\link[base]{file.path}}
#'
#' @export
find_root_file <- function(..., criterion, path = ".") {
  root <- find_root(criterion = criterion, path = path)
  file.path(root, ...)
}
