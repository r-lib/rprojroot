# Find the root of a directory hierarchy

A *root* is defined as a directory that contains a regular file whose
name matches a given pattern and which optionally contains a given text.
The search for a root starts at a given directory (the working directory
by default), and proceeds up the directory hierarchy.

`get_root_desc()` returns the description of the criterion for a root
path. This is especially useful for composite root criteria created with
[`|.root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md).

## Usage

``` r
find_root(criterion, path = ".")

get_root_desc(criterion, path)
```

## Arguments

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

The normalized path of the root as specified by the search criterion.
Throws an error if no root is found

## Details

Starting from the working directory, the `find_root()` function searches
for the root. If a root is found, the `...` arguments are used to
construct a path; thus, if no extra arguments are given, the root is
returned. If no root is found, an error is thrown.

## See also

[`utils::glob2rx()`](https://rdrr.io/r/utils/glob2rx.html)
[`file.path()`](https://rdrr.io/r/base/file.path.html)

## Examples

``` r
if (FALSE) { # \dontrun{
find_root(has_file_pattern(
  pattern = glob2rx("DESCRIPTION"),
  contents = "^Package: "
))
} # }
```
