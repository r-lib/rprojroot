#' @rdname find_root_file
#' @export
make_find_root_file <- function(filename, contents = NULL, n = -1L) {
  force(filename)
  force(contents)
  force(n)
  ret <- function(..., path = getwd()) {
    find_root_file(filename = filename, contents = contents, n = n, ..., path = path)
  }
  environment(ret) <- environment(find_root)
  ret
}

#' @rdname find_root_file
#' @export
find_rstudio_root_file <- make_find_root_file(glob2rx("*.Rproj"), contents = "^Version: ", n = 1L)

#' @rdname find_root_file
#' @export
find_package_root_file <- make_find_root_file(glob2rx("DESCRIPTION"), contents = "^Package: ", n = 1L)
