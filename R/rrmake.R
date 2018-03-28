make_find_root_file <- function(criterion) {
  force(criterion)
  eval(bquote(function(..., path = ".") {
    find_root_file(..., criterion = criterion, path = path)
  }))
}

make_fix_root_file <- function(criterion, path, subdir=NULL) {
  root <- find_root(criterion = criterion, path = path)
  if (!is.null(subdir)) {root <- file.path(root, subdir)}
  eval(bquote(function(...) {
    file.path(.(root), ...)
  }))
}
