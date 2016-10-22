<!-- README.md is generated from README.Rmd. Please edit that file -->
[rprojroot](https://krlmlr.github.io/rprojroot) [![Travis-CI Build Status](https://travis-ci.org/krlmlr/rprojroot.svg?branch=master)](https://travis-ci.org/krlmlr/rprojroot) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/krlmlr/rprojroot?branch=master&svg=true)](https://ci.appveyor.com/project/krlmlr/rprojroot) [![codecov.io](https://codecov.io/github/krlmlr/rprojroot/coverage.svg?branch=master)](https://codecov.io/github/krlmlr/rprojroot?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rprojroot)](https://cran.r-project.org/package=rprojroot)
=============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================

This package helps accessing files relative to a *project root* to [stop the working directory insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f).

Example
-------

The source for this text is in the [`readme` subdirectory](https://github.com/krlmlr/rprojroot/tree/master/readme):

``` r
basename(getwd())
#> [1] "readme"
```

How do we access the package root? In a robust fashion? Easily:

``` r
dir(rprojroot::find_root("DESCRIPTION"))
#>  [1] "appveyor.yml"     "cran-comments.md" "DESCRIPTION"     
#>  [4] "docs"             "inst"             "Makefile"        
#>  [7] "man"              "NAMESPACE"        "NEWS.md"         
#> [10] "_pkgdown.yml"     "R"                "readme"          
#> [13] "README.md"        "rprojroot.Rproj"  "scripts"         
#> [16] "tests"            "vignettes"
```

Installation and further reading
--------------------------------

Install from GitHub:

``` r
devtools::install_github("krlmlr/rprojroot")
```

See the [vignette](http://krlmlr.github.io/rprojroot/vignettes/rprojroot.html) for more detail.
