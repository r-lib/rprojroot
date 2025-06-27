
<!-- README.md and index.md are generated from README.Rmd. Please edit that file. -->

# [rprojroot](https://rprojroot.r-lib.org/)

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![rcc](https://github.com/r-lib/rprojroot/workflows/rcc/badge.svg)](https://github.com/r-lib/rprojroot/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rprojroot)](https://cran.r-project.org/package=rprojroot)
[![Codecov test
coverage](https://codecov.io/gh/r-lib/rprojroot/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r-lib/rprojroot?branch=main)
<!-- badges: end -->

This package helps accessing files relative to a *project root* to [stop
the working directory
insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f). It is a
low-level helper package for the [here](https://here.r-lib.org/)
package.

``` r
library(rprojroot)
```

## Example

The rprojroot package works best when you have a “project”: all related
files contained in a subdirectory that can be categorized using a strict
criterion. Let’s create a package for demonstration.

``` r
dir <- tempfile()
pkg <- usethis::create_package(dir)
#> ✔ Creating
#>   /var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586/.
#> ✔ Setting active project to
#>   "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586".
#> ✔ Creating R/.
#> ✔ Writing DESCRIPTION.
#> Package: file337b29a46586
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.0.0.9000
#> Date: 2025-06-27
#> Authors@R (parsed):
#>     * Kirill Müller <kirill@cynkra.com> [aut, cre] (<https://orcid.org/0000-0002-1416-3412>)
#> Description: What the package does (one paragraph).
#> License: MIT
#> URL: https://github.com/krlmlr/rprojroot,
#>     https://krlmlr.github.io/rprojroot
#> BugReports: https://github.com/krlmlr/rprojroot/issues
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.3.2.9000
#> ✔ Writing NAMESPACE.
#> ✔ Setting active project to "<no active project>".
```

R packages satisfy the `is_r_package` criterion. A criterion is an
object that contains a `find_file()` function. With `pkg` as working
directory, the function works like `file.path()`, rooted at the working
directory:

``` r
setwd(pkg)
is_r_package
#> Root criterion: contains a file "DESCRIPTION" with contents matching "^Package: "
is_r_package$find_file()
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586"
is_r_package$find_file("tests", "testthat")
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586/tests/testthat"
```

This works identically when starting from a subdirectory:

``` r
setwd(file.path(pkg, "R"))
is_r_package$find_file()
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586"
is_r_package$find_file("tests", "testthat")
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586/tests/testthat"
```

There is one exception: if the first component passed to `find_file()`
is already an absolute path. This allows safely applying this function
to paths that may be absolute or relative:

``` r
setwd(file.path(pkg, "R"))
path <- is_r_package$find_file()
is_r_package$find_file(path, "tests", "testthat")
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpVBhMLR/file337b29a46586/tests/testthat"
```

As long as you are sure that your working directory is somewhere inside
your project, you can retrieve the project root.

## Installation and further reading

Install the package from CRAN:

``` r
install.package("rprojroot")
```

See the
[documentation](https://rprojroot.r-lib.org/articles/rprojroot.html) for
more detail.

------------------------------------------------------------------------

## Code of Conduct

Please note that the rprojroot project is released with a [Contributor
Code of Conduct](https://rprojroot.r-lib.org/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
