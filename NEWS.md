Version 0.1-1 (2016-02-04)
===

- Add TL;DR section to vignette.
- Root criteria now have two function members, `find_file()` and `make_fix_file()`, instead of the now removed `make_find_root_file()` and `make_fix_root_file()`.


Version 0.1 (2016-02-03)
===

Initial GitHub release.

- Getting started:
    - `find_package_root_file()`
    - `find_rstudio_root_file()`

- S3 class `root_criterion`:
    - `root_criterion()`
    - `as.root_criterion()`
    - `is.root_criterion()`
    - `has_file()`
    - `has_file_pattern()`
    - `criteria`
        - `is_r_package`
        - `is_rstudio_project`

- Use a custom notion of a project root:
    - `find_root()`
    - `find_root_file()`
    - `make_find_root_file()`
    - `make_fix_root_file()`
