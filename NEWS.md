# rprojroot 1.0-2 (2016-03-28)

- Fix test that fails on Windows only on CRAN.


# rprojroot 1.0-1 (2016-03-26)

- Updated NEWS.


# rprojroot 1.0 (2016-03-26)

Initial CRAN release.

- S3 class `root_criterion`:
    - Member functions: `find_file()` and `make_fix_file()`
    - `root_criterion()`
    - `as.root_criterion()`
    - `is.root_criterion()`
    - `has_file()`
    - `has_file_pattern()`
    - Built-in criteria:
        - `is_r_package`
        - `is_rstudio_project`

- Getting started:
    - `find_package_root_file()`
    - `find_rstudio_root_file()`

- Use a custom notion of a project root:
    - `find_root()`
    - `find_root_file()`

- Vignette
