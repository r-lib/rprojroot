# document

Version: 2.2.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library("document")
      > test_check("document")
      ── 1. Error: (unknown) (@test_basic.R#13)  ─────────────────────────────────────
      R CMD check failed, read the above log and fix.
      1: document(file_name, check_package = TRUE, runit = TRUE) at testthat/test_basic.R:13
      2: check_package(package_directory = package_directory, working_directory = working_directory, 
             check_as_cran = check_as_cran, debug = debug, stop_on_check_not_passing = stop_on_check_not_passing)
      3: throw("R CMD check failed, read the above log and fix.")
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 0 SKIPPED: 0 FAILED: 1
      1. Error: (unknown) (@test_basic.R#13) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# excerptr

Version: 1.4.0

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘excerptr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: excerptr
    > ### Title: Excerpt Structuring Comments and Set a Table of Contents.
    > ### Aliases: excerptr
    > 
    > ### ** Examples
    > 
    > root <- system.file(package = "excerptr")
    > test_files <- file.path(root, "excerpts", "tests", "files")
    > excerptr(file_name = file.path(test_files, "some_file.txt"),
    +          output_path = tempdir(), run_pandoc = FALSE,
    +          compile_latex = FALSE,
    +          pandoc_formats = c("tex", "html"))
    cloning into '/home/muelleki/git/R/rprojroot/inst/excerpts'...
    Error in git2r::clone(url = "https://github.com/fvafrCU/excerpts/", branch = branch,  : 
      Error in 'git2r_clone': '/home/muelleki/git/R/rprojroot/inst/excerpts' exists and is not an empty directory
    Calls: excerptr ... get_excerpts -> <Anonymous> -> <Anonymous> -> .Call
    Execution halted
    ```

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      4: tryCatchOne(tryCatchList(expr, names[-nh], parentenv, handlers[-nh]), names[nh], 
             parentenv, handlers[[nh]])
      5: doTryCatch(return(expr), name, parentenv, handler)
      6: tryCatchList(expr, names[-nh], parentenv, handlers[-nh])
      7: tryCatchOne(expr, names, parentenv, handlers[[1L]])
      8: value[[3L]](cond)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 4 SKIPPED: 0 FAILED: 3
      1. Error: md (@test-that.R#31) 
      2. Error: pandoc_formats (@test-that.R#31) 
      3. Error: pandoc_formats_list (@test-that.R#31) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# fakemake

Version: 1.0.2

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘rcmdcheck’
    ```

# ggraptR

Version: 1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘DBI’ ‘GGally’ ‘RColorBrewer’ ‘Rcpp’ ‘assertthat’ ‘backports’
      ‘colorspace’ ‘colourpicker’ ‘evaluate’ ‘futile.options’ ‘gdtools’
      ‘gtable’ ‘htmltools’ ‘htmlwidgets’ ‘httpuv’ ‘labeling’ ‘lambda.r’
      ‘lazyeval’ ‘magrittr’ ‘miniUI’ ‘munsell’ ‘plyr’ ‘reshape’ ‘rprojroot’
      ‘scales’ ‘stringi’ ‘stringr’ ‘svglite’ ‘tibble’ ‘xtable’ ‘yaml’
      All declared Imports should be used.
    ```

# readxl

Version: 1.0.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.7Mb
      sub-directories of 1Mb or more:
        libs   4.4Mb
    ```

# repurrrsive

Version: 0.1.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 8 marked UTF-8 strings
    ```

# rmarkdown

Version: 1.8

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.6Mb
      sub-directories of 1Mb or more:
        rmd   6.1Mb
    ```

# teachingApps

Version: 1.0.2

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.6Mb
      sub-directories of 1Mb or more:
        apps   2.6Mb
        libs   2.1Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘data.table’ ‘datasets’ ‘stats’
      All declared Imports should be used.
    ```

# testthis

Version: 1.0.2

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Quitting from lines 13-22 (testthis.Rmd) 
    Error: processing vignette 'testthis.Rmd' failed with diagnostics:
    'roxygen2' >= 5.0.0 must be installed for this functionality.
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rprojroot’
      All declared Imports should be used.
    ```

