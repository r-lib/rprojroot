#' @rdname find_root_file
#' @export
make_find_root_file <- function(criterion) {
  force(criterion)
  eval(bquote(function(..., path = getwd()) {
    find_root_file(..., criterion = .(criterion), path = path)
  }))
}

#' @rdname find_root_file
#' @export
make_fix_root_file <- function(criterion) {
  root <- find_root(criterion = criterion)
  eval(bquote(function(...) {
    file.path(.(root), ...)
  }))
}

#' @rdname find_root_file
#' @export
find_rstudio_root_file <- make_find_root_file(has_file_pattern(glob2rx("*.Rproj"), contents = "^Version: ", n = 1L))

#' @rdname find_root_file
#' @export
find_package_root_file <- make_find_root_file(has_file("DESCRIPTION", contents = "^Package: ", n = 1L))
