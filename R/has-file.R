#' @rdname root_criterion
#' @param filename,contents Regular expressions to match the file name or contents
#' @inheritParams base::readLines
has_file <- function(filename, contents = NULL, n = -1L) {
  force(filename)
  force(contents)
  force(n)

  testfun <- eval(bquote(function(path) {
    files <- list_files(path, .(filename))
    for (f in files) {
      if (!match_contents(f, .(contents), .(n))) {
        next
      }
      return(TRUE)
    }
    return(FALSE)
  }))

  desc <- paste0(
    "Contains a file matching '", filename,
    if (!is.null(contents)) {
      paste0("' with contents matching '", contents, "'",
             if (n >= 0L) paste(" in the first", n, "lines"))
  })

  root_criterion(testfun, desc)
}

list_files <- function(path, filename) {
  files <- dir(path = path, pattern = filename, all.files = TRUE)
  files <- file.info(file.path(path, files), extra_cols = FALSE)
  files <- rownames(files)[!files$isdir]
  files
}

match_contents <- function(f, contents, n) {
  if (is.null(contents)) {
    return(TRUE)
  }

  fc <- readLines(f, n)
  any(grepl(contents, fc))
}
