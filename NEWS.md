# rprojroot 1.1 (2016-10-29)

- Compatibility
    - Compatible with R >= 3.0.0 with the help of the `backports` package.

- New root criteria
    - `is_remake_project` and `find_remake_root_file()` look for [remake](https://github.com/richfitz/remake) project (#17).
    - `is_testthat` and `find_testthat_root_file()` that looks for `tests/testthat` root (#14).
    - `from_wd`, useful for creating accessors to a known path (#11).

- Minor enhancement
    - Criteria can be combined with the `|` operator (#15).

- Documentation
    - Add package documentation with a few examples (#13).
    - Clarify difference between `find_file()` and `make_fix_file()` in vignette (#9).
    - Remove unexported functions from documentation and examples (#10).
    - Use `pkgdown` to create website.

- Testing
    - Use Travis instead of wercker. Travis tests three R versions, and OS X.
    - Improve AppVeyor testing.


# rprojroot 1.0-2 (2016-03-28)

- Fix test that fails on Windows only on CRAN.


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
