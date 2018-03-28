<!-- README.md is generated from README.Rmd. Please edit that file -->
[rprojroot](https://r-lib.github.io/rprojroot)
===============================================

[![Travis-CI Build Status](https://travis-ci.org/r-lib/rprojroot.svg?branch=master)](https://travis-ci.org/r-lib/rprojroot) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/r-lib/rprojroot?branch=master&svg=true)](https://ci.appveyor.com/project/r-lib/rprojroot) [![codecov.io](https://codecov.io/github/r-lib/rprojroot/coverage.svg?branch=master)](https://codecov.io/github/r-lib/rprojroot?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rprojroot)](https://cran.r-project.org/package=rprojroot)

This package helps accessing files relative to a *project root* to [stop the working directory insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f).

Example
-------

The source for this text is in the [`readme` subdirectory](https://github.com/r-lib/rprojroot/tree/master/readme):

``` r
basename(getwd())
#> [1] "readme"
```

How do we access the package root? In a robust fashion? Easily:

``` r
dir(rprojroot::find_root("DESCRIPTION"))
#>  [1] "_pkgdown.yml"     "API"              "appveyor.yml"    
#>  [4] "cran-comments.md" "DESCRIPTION"      "docs"            
#>  [7] "inst"             "Makefile"         "man"             
#> [10] "NAMESPACE"        "NEWS.md"          "R"               
#> [13] "readme"           "README.md"        "revdep"          
#> [16] "rprojroot.Rproj"  "tests"            "tic.R"           
#> [19] "vignettes"
```

Installation and further reading
--------------------------------

Install from GitHub:

``` r
devtools::install_github("r-lib/rprojroot")
```

See the [documentation](http://r-lib.github.io/rprojroot/articles/rprojroot.html) for more detail.
