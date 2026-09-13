
<!-- README.md and index.md are generated from README.Rmd. Please edit that file. -->

# [rprojroot](https://rprojroot.r-lib.org/)

<!-- badges: start -->

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![rcc](https://github.com/r-lib/rprojroot/workflows/rcc/badge.svg)](https://github.com/r-lib/rprojroot/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rprojroot)](https://cran.r-project.org/package=rprojroot)
[![Codecov test coverage](https://codecov.io/gh/r-lib/rprojroot/graph/badge.svg)](https://app.codecov.io/gh/r-lib/rprojroot/tree/main)
<!-- badges: end -->

This package helps accessing files relative to a *project root* to [stop the working directory insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f).
It is a low-level helper package for the [here](https://here.r-lib.org/) package.

``` r
library(rprojroot)
```

## Example

The rprojroot package works best when you have a "project":
all related files contained in a subdirectory that can be categorized using a strict criterion.
Let's create a package for demonstration.

``` r
# A fixed name, so the demo package is not called `file1a2b3c` in the output.
dir <- file.path(tempdir(), "demopkg")
pkg <- usethis::create_package(dir)
#> ✔ Creating /tmp/RtmpXXXXXX/demopkg/.
#> ✔ Setting active project to "/tmp/RtmpXXXXXX/demopkg".
#> ✔ Creating R/.
#> ✔ Writing DESCRIPTION.
#> Package: demopkg
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.0.0.9000
#> Authors@R (parsed):
#>     * First Last <first.last@example.com> [aut, cre]
#> Description: What the package does (one paragraph).
#> License: `use_mit_license()`, `use_gpl3_license()` or friends to
#>     pick a license
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 8.1.0
#> ✔ Writing NAMESPACE.
#> ✔ Setting active project to "<no active project>".
```

R packages satisfy the `is_r_package` criterion.
A criterion is an object that contains a `find_file()` function.
With `pkg` as working directory, the function works like `file.path()`, rooted at the working directory:

``` r
setwd(pkg)
is_r_package
#> Root criterion: contains a file 'DESCRIPTION' with contents matching '^Package: '
is_r_package$find_file()
#> [1] "/tmp/RtmpXXXXXX/demopkg"
is_r_package$find_file("tests", "testthat")
#> [1] "/tmp/RtmpXXXXXX/demopkg/tests/testthat"
```

This works identically when starting from a subdirectory:

``` r
setwd(file.path(pkg, "R"))
is_r_package$find_file()
#> [1] "/tmp/RtmpXXXXXX/demopkg"
is_r_package$find_file("tests", "testthat")
#> [1] "/tmp/RtmpXXXXXX/demopkg/tests/testthat"
```

There is one exception: if the first component passed to `find_file()` is already an absolute path.
This allows safely applying this function to paths that may be absolute or relative:

``` r
setwd(file.path(pkg, "R"))
path <- is_r_package$find_file()
is_r_package$find_file(path, "tests", "testthat")
#> [1] "/tmp/RtmpXXXXXX/demopkg/tests/testthat"
```

As long as you are sure that your working directory is somewhere inside your project, you can retrieve the project root.

## Installation and further reading

Install the package from CRAN:

``` r
install.package("rprojroot")
```

Or the development version from GitHub with:

``` r
# install.packages("pak")
pak::pak("r-lib/rprojroot")
```

See the [documentation](https://rprojroot.r-lib.org/articles/rprojroot.html) for more detail.

------------------------------------------------------------------------

## Code of Conduct

Please note that the rprojroot project is released with a [Contributor Code of Conduct](https://rprojroot.r-lib.org/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
