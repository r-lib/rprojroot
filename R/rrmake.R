#' @rdname find_root
make_find_root <- function(filename, contents = NULL, n = -1L) {
  force(filename)
  force(contents)
  force(n)
  ret <- function(..., path = getwd()) {
    find_root(filename = filename, contents = contents, n = n, ..., path = path)
  }
  environment(ret) <- environment(find_root)
  ret
}

#' @rdname find_root
find_rstudio_root <- make_find_root(glob2rx("*.Rproj"), contents = "^Version: ", n = 1L)

#' @rdname find_root
find_package_root <- make_find_root(glob2rx("DESCRIPTION"), contents = "^Package: ", n = 1L)
