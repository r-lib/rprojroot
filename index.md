
<!-- README.md and index.md are generated from README.Rmd. Please edit that file. -->



# [rprojroot](https://rprojroot.r-lib.org/)

<!-- badges: start -->
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![rcc](https://github.com/r-lib/rprojroot/workflows/rcc/badge.svg)](https://github.com/r-lib/rprojroot/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rprojroot)](https://cran.r-project.org/package=rprojroot)
[![Codecov test coverage](https://codecov.io/gh/r-lib/rprojroot/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r-lib/rprojroot?branch=main)
<!-- badges: end -->

This package helps accessing files relative to a *project root* to [stop the working directory insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f).
It is a low-level helper package for the [here](https://here.r-lib.org/) package.


``` r
library(rprojroot)
```


## Example

The rprojroot package works best when you have a "project": all related files contained in a subdirectory that can be categorized using a strict criterion.
Let's create a package for demonstration.


``` r
dir <- tempfile()
pkg <- usethis::create_package(dir)
#> [32m✔[39m Creating
#>   [34m/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c/[39m.
#> [32m✔[39m Setting active project to
#>   [34m"/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c"[39m.
#> [32m✔[39m Creating [34mR/[39m.
#> [32m✔[39m Writing [34mDESCRIPTION[39m.
#> [34mPackage[39m: file2afe66d464c
#> [34mTitle[39m: What the Package Does (One Line, Title Case)
#> [34mVersion[39m: 0.0.0.9000
#> [34mDate[39m: 2024-10-27
#> [34mAuthors@R[39m (parsed):
#>     * Kirill Müller <kirill@cynkra.com> [aut, cre] (<https://orcid.org/0000-0002-1416-3412>)
#> [34mDescription[39m: What the package does (one paragraph).
#> [34mLicense[39m: GPL-3
#> [34mURL[39m: https://github.com/krlmlr/rprojroot,
#>     https://krlmlr.github.io/rprojroot
#> [34mBugReports[39m: https://github.com/krlmlr/rprojroot/issues
#> [34mEncoding[39m: UTF-8
#> [34mRoxygen[39m: list(markdown = TRUE)
#> [34mRoxygenNote[39m: 7.3.2.9000
#> [32m✔[39m Writing [34mNAMESPACE[39m.
#> [32m✔[39m Setting active project to [34m"<no active project>"[39m.
```

R packages satisfy the `is_r_package` criterion.
A criterion is an object that contains a `find_file()` function.
With `pkg` as working directory, the function works like `file.path()`, rooted at the working directory:


``` r
setwd(pkg)
is_r_package
#> Root criterion: contains a file "DESCRIPTION" with contents matching "^Package: "
is_r_package$find_file()
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c"
is_r_package$find_file("tests", "testthat")
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c/tests/testthat"
```

This works identically when starting from a subdirectory:


``` r
setwd(file.path(pkg, "R"))
is_r_package$find_file()
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c"
is_r_package$find_file("tests", "testthat")
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c/tests/testthat"
```

There is one exception: if the first component passed to `find_file()` is already an absolute path.
This allows safely applying this function to paths that may be absolute or relative:


``` r
setwd(file.path(pkg, "R"))
path <- is_r_package$find_file()
is_r_package$find_file(path, "tests", "testthat")
#> [1] "/private/var/folders/dj/yhk9rkx97wn_ykqtnmk18xvc0000gn/T/RtmpA7TxJ1/file2afe66d464c/tests/testthat"
```


As long as you are sure that your working directory is somewhere inside your project, you can retrieve the project root.


## Installation and further reading

Install the package from CRAN:

``` r
install.package("rprojroot")
```

See the [documentation](https://rprojroot.r-lib.org/articles/rprojroot.html) for more detail.

