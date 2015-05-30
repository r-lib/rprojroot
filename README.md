<!-- README.md is generated from README.Rmd. Please edit that file -->
[rprojroot](https://krlmlr.github.io/rprojroot) [![wercker status](https://app.wercker.com/status/c4dfa136cd78514514e259cc388e880c/s/master "wercker status")](https://app.wercker.com/project/bykey/c4dfa136cd78514514e259cc388e880c) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/krlmlr/rprojroot?branch=develop)](https://ci.appveyor.com/project/krlmlr/rprojroot) [![codecov.io](https://codecov.io/github/krlmlr/rprojroot/coverage.svg?branch=master)](https://codecov.io/github/krlmlr/rprojroot?branch=master)
=======================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================

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
#>  [1] "appveyor.yml"    "DESCRIPTION"     "inst"           
#>  [4] "Makefile"        "makeR"           "man"            
#>  [7] "NAMESPACE"       "NEWS.md"         "NEWS.md.tmpl"   
#> [10] "R"               "readme"          "README.md"      
#> [13] "rprojroot.Rproj" "tests"           "vignettes"      
#> [16] "wercker.yml"
```

Installation and further reading
--------------------------------

Install from GitHub:

``` r
devtools::install("krlmlr/rprojroot")
```

See the [vignette](http://krlmlr.github.io/rprojroot/vignettes/rprojroot.html) for more detail.
