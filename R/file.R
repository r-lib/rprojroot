#' File paths relative to the root of a directory hierarchy
#'
#' Append an arbitrary number of path components to the root using
#' \code{\link[base]{file.path}}.
#'
#' The \code{find_root_file} function is a simple wrapper around
#' \code{\link{find_root}} that
#' appends an arbitrary number of path components to the root using
#' \code{\link[base]{file.path}}.
#' The function \code{make_find_root_file} can be used to create shorthand functions
#' such as \code{find_rstudio_root_file} and \code{find_package_root_file}.
#' In many cases, the function \code{make_fix_root_file} is even more useful:
#' It creates a shorthand function that is tied to a fixed root (as opposed to
#' \code{make_find_root_file} which creates a function that will look for the
#' root every time it is called).
#'
#' @param filename,contents Regular expressions to match the file name or contents
#' @param path The start directory
#' @inheritParams base::readLines
#' @param ... Additional arguments passed to \code{\link{file.path}}
#' @return The normalized path of the root as specified by the search criteria.
#'   Throws an error if no root is found
#'
#' @examples
#' find_package_root_file("tests", "testthat.R")
#' make_find_root_file(glob2rx("DESCRIPTION"), "^Package: ")
#' make_fix_root_file(glob2rx("DESCRIPTION"), "^Package: ")
#'
#' @seealso \code{\link{find_root}} \code{\link[utils]{glob2rx}} \code{\link[base]{file.path}}
#'
#' @export
find_root_file <- function(..., filename, contents = NULL, n = -1L, path = getwd()) {
  root <- find_root(filename = filename, contents = contents, n = n, path = path)
  file.path(root, ...)
}
