#' @title Determines the path of the currently running script
#' @description \R does not store nor export the path of the currently running
#'   script.  This is an attempt to circumvent this limitation by applying
#'   heuristics (such as call stack and argument inspection) that work in many
#'   cases.
#' @details This functions currently work only if the script was \code{source}d,
#'   processed with \code{knitr},
#'   or run with \code{Rscript} or using the \code{--file} parameter to the
#'   \code{R} executable.  For code run with \code{Rscript}, the exact value
#'   of the parameter passed to \code{Rscript} is returned.
#' @return The path of the currently running script, NULL if it cannot be
#'   determined.
#' @seealso \link[base]{source}, \link[utils]{Rscript}, \link[base]{getwd}
#' @references \url{http://stackoverflow.com/q/1815606/946850}
#' @author Kirill Müller, Hadley Wickham, Michael R. Head
#' @examples
#' \dontrun{thisfile()}
#' @export
thisfile <- function() {
  if (!is.null(res <- thisfile_source())) res
  else if (!is.null(res <- thisfile_r())) res
  else if (!is.null(res <- thisfile_rscript())) res
  else if (!is.null(res <- thisfile_knit())) res
  else NULL
}

#' @rdname thisfile
#' @export
thisfile_source <- function() {
  for (i in -(1:sys.nframe())) {
    if (identical(args(sys.function(i)), args(base::source)))
      return (normalizePath(sys.frame(i)$ofile))
  }

  NULL
}

#' @rdname thisfile
#' @export
thisfile_r <- function() {
  cmd_args <- commandArgs(trailingOnly = FALSE)
  if (!grepl("^R(?:|[.]exe)$", basename(cmd_args[[1L]]), ignore.case = TRUE))
    return (NULL)

  cmd_args_trailing <- commandArgs(trailingOnly = TRUE)
  leading_idx <-
    seq.int(from=1, length.out=length(cmd_args) - length(cmd_args_trailing))
  cmd_args <- cmd_args[leading_idx]
  file_idx <- c(which(cmd_args == "-f") + 1, which(grepl("^--file=", cmd_args)))
  res <- gsub("^(?:|--file=)(.*)$", "\\1", cmd_args[file_idx])

  # If multiple --file arguments are given, R uses the last one
  res <- tail(res[res != ""], 1)
  if (length(res) > 0)
    return (res)

  NULL
}

#' @rdname thisfile
#' @export
thisfile_rscript <- function() {
  cmd_args <- commandArgs(trailingOnly = FALSE)
  if (!grepl("^Rscript(?:|[.]exe)$", basename(cmd_args[[1L]]), ignore.case = TRUE))
    return(NULL)

  cmd_args_trailing <- commandArgs(trailingOnly = TRUE)
  leading_idx <-
    seq.int(from=1, length.out=length(cmd_args) - length(cmd_args_trailing))
  cmd_args <- cmd_args[leading_idx]
  res <- gsub("^(?:--file=(.*)|.*)$", "\\1", cmd_args)

  # If multiple --file arguments are given, R uses the last one
  res <- tail(res[res != ""], 1)
  if (length(res) > 0)
    return (res)

  NULL
}

#' @rdname thisfile
#' @export
thisfile_knit <- function() {
  if (requireNamespace("knitr"))
    return (knitr::current_input())

  NULL
}
