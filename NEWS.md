## rprojroot 1.0-6 (2016-10-22)

- Travis tests three R versions, and OS X.


## rprojroot 1.0-5 (2016-10-22)

- Use Travis instead of wercker.
- Criteria can be combined with the `|` operator (#15).


## rprojroot 1.0-4 (2016-05-30)

- Improve AppVeyor testing.
- Restore compatibility with R < 3.2.
- Add package documentation with a few examples (#13).


## rprojroot 1.0-3 (2016-05-13)

- New root criterion `from_wd`, useful for creating accessors to a known path (#11).
- Clarify difference between `find_file()` and `make_fix_file()` in vignette (#9).
- Remove unexported functions from documentation and examples (#10).


## rprojroot 1.0-2 (2016-03-28)

- Fix test that fails on Windows only on CRAN.


## rprojroot 1.0-1 (2016-03-26)

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
