\name{NEWS}
\title{News for Package 'rprojroot'}
\encoding{UTF-8}
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
