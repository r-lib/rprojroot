- New function `as.root_criterion` (called by `find_root()`), a character argument is converted to a `has_file()` criterion. Now the call `find_root("filename")` is identical to `find_root(has_file("filename"))`.
- Use `"."` instead of `"getwd()"` as default for `path` argument

Version 0.0-4 (2015-05-20)
===

- New variables `criteria`, `is_rstudio_project`, `is_r_package`
- New function `has_file_pattern` (was previously `has_file`); the `has_file` function now checks the entire file name without pattern matching

Version 0.0-3 (2015-05-20)
===

- Criterion concept: constructors `root_criterion` and `has_file`
- All functions that used to accept `filename` + `contents` + `n` now accept only a criterion

Version 0.0-2 (2015-05-19)
===

- Factory `make_fix_root_file` that fixes the working directory

Version 0.0-1 (2015-05-19)
===

- Initial version
- Main workhorse function `find_root`
- Wrapper `find_root_file`
- Factory `make_find_root_file` and helpers `find_rstudio_root_file` and `find_package_root_file`
- Vignette
