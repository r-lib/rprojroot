# File paths relative to the root of a directory hierarchy

`find_root_file()` is a wrapper around
[`find_root()`](https://rprojroot.r-lib.org/dev/reference/find_root.md)
that appends an arbitrary number of path components to the root using
[`base::file.path()`](https://rdrr.io/r/base/file.path.html).

## Usage

``` r
find_root_file(..., criterion, path = ".")

find_rstudio_root_file(..., path = ".")

find_package_root_file(..., path = ".")

find_remake_root_file(..., path = ".")

find_testthat_root_file(..., path = ".")
```

## Arguments

- ...:

  `[character]`  
  Further path components passed to
  [`file.path()`](https://rdrr.io/r/base/file.path.html). All arguments
  must be the same length or length one.

- criterion:

  `[root_criterion]`  
  A criterion, one of the predefined
  [criteria](https://rprojroot.r-lib.org/dev/reference/criteria.md) or
  created by
  [`root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md).
  Will be coerced using
  [`as_root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md).

- path:

  `[character(1)]`  
  The start directory.

## Value

The normalized path of the root as specified by the search criteria,
with the additional path components appended. Throws an error if no root
is found.

## Details

This function operates on the notion of relative paths. The `...`
argument is expected to contain a path relative to the root. If the
first path component passed to `...` is already an absolute path, the
`criterion` and `path` arguments are ignored, and `...` is forwarded to
[`file.path()`](https://rdrr.io/r/base/file.path.html).

## See also

[`find_root()`](https://rprojroot.r-lib.org/dev/reference/find_root.md)
[`utils::glob2rx()`](https://rdrr.io/r/utils/glob2rx.html)
[`base::file.path()`](https://rdrr.io/r/base/file.path.html)

## Examples

``` r
if (FALSE) { # \dontrun{
find_package_root_file("tests", "testthat.R")
has_file("DESCRIPTION", "^Package: ")$find_file
has_file("DESCRIPTION", "^Package: ")$make_fix_file(".")
} # }
```
