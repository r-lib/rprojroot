\name{NEWS}
\title{News for Package 'rprojroot'}
\encoding{UTF-8}
\section{Changes in rprojroot version 0.0-7 (2015-05-31)}{
  \itemize{
    \item Use \code{winslash = "/"} for consistent tests and behavior
    \item Replace potentially endless loop with a limited loop
    \item Test on Windows with appveyor
  }
}
\section{Changes in rprojroot version 0.0-6 (2015-05-29)}{
  \itemize{
    \item Full test coverage
  }
}
\section{Changes in rprojroot version 0.0-5 (2015-05-29)}{
  \itemize{
    \item New function \code{as.root_criterion} (called by \code{find_root()}), a character argument is converted to a \code{has_file()} criterion. Now the call \code{find_root("filename")} is identical to \code{find_root(has_file("filename"))}.
    \item Use \code{"."} instead of \code{"getwd()"} as default for \code{path} argument
    \item Improved documentation
  }
}
\section{Changes in rprojroot version 0.0-4 (2015-05-20)}{
  \itemize{
    \item New variables \code{criteria}, \code{is_rstudio_project}, \code{is_r_package}
    \item New function \code{has_file_pattern} (was previously \code{has_file}); the \code{has_file} function now checks the entire file name without pattern matching
  }
}
\section{Changes in rprojroot version 0.0-3 (2015-05-20)}{
  \itemize{
    \item Criterion concept: constructors \code{root_criterion} and \code{has_file}
    \item All functions that used to accept \code{filename} + \code{contents} + \code{n} now accept only a criterion
  }
}
\section{Changes in rprojroot version 0.0-2 (2015-05-19)}{
  \itemize{
    \item Factory \code{make_fix_root_file} that fixes the working directory
  }
}
\section{Changes in rprojroot version 0.0-1 (2015-05-19)}{
  \itemize{
    \item Initial version
    \item Main workhorse function \code{find_root}
    \item Wrapper \code{find_root_file}
    \item Factory \code{make_find_root_file} and helpers \code{find_rstudio_root_file} and \code{find_package_root_file}
    \item Vignette
  }
}
