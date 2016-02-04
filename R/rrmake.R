make_find_root_file <- function(criterion) {
  force(criterion)
  eval(bquote(function(..., path = ".") {
    find_root_file(..., criterion = criterion, path = path)
  }))
}

make_fix_root_file <- function(criterion, path) {
  root <- find_root(criterion = criterion, path = path)
  eval(bquote(function(...) {
    file.path(.(root), ...)
  }))
}
