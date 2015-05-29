<!-- README.md is generated from README.Rmd. Please edit that file -->
[rprojroot](https://krlmlr.github.io/rprojroot) [![wercker status](https://app.wercker.com/status/c4dfa136cd78514514e259cc388e880c/s/master "wercker status")](https://app.wercker.com/project/bykey/c4dfa136cd78514514e259cc388e880c) [![codecov.io](https://codecov.io/github/krlmlr/rprojroot/coverage.svg?branch=master)](https://codecov.io/github/krlmlr/rprojroot?branch=master)
=======================================================================================================================================================================================================================================================================================================================================================================================

This package helps accessing files relative to a *project root* to [stop the working directory insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f).

Example
-------

The source for this text is in the `readme` subdirectory:

``` r
basename(getwd())
#> [1] "readme"
```

How do we access the package root? In a robust fashion? Easily:

``` r
dir(rprojroot::find_root("DESCRIPTION"))
#>  [1] "DESCRIPTION"     "inst"            "Makefile"       
#>  [4] "makeR"           "man"             "NAMESPACE"      
#>  [7] "NEWS.md"         "NEWS.md.tmpl"    "R"              
#> [10] "readme"          "README.md"       "rprojroot.Rproj"
#> [13] "tests"           "vignettes"       "wercker.yml"
```

Installation and further reading
--------------------------------

Install from GitHub:

``` r
devtools::install("krlmlr/rprojroot")
```

See the [vignette](http://krlmlr.github.io/rprojroot/vignettes/rprojroot.html) for more detail.
