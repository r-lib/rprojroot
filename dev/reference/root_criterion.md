# Is a directory the project root?

Objects of the `root_criterion` class decide if a given directory is a
project root.

## Usage

``` r
root_criterion(testfun, desc, subdir = NULL)

is_root_criterion(x)

as_root_criterion(x)

# S3 method for class 'character'
as_root_criterion(x)

# S3 method for class 'root_criterion'
as_root_criterion(x)

# S3 method for class 'root_criterion'
x | y

has_file(filepath, contents = NULL, n = -1L, fixed = FALSE)

has_dir(filepath)

has_file_pattern(pattern, contents = NULL, n = -1L, fixed = FALSE)

has_basename(basename, subdir = NULL)
```

## Arguments

- testfun:

  `[function|list(function)]`  
  A function with one parameter that returns `TRUE` if the directory
  specified by this parameter is the project root, and `FALSE`
  otherwise. Can also be a list of such functions.

- desc:

  `[character]`  
  A textual description of the test criterion, of the same length as
  `testfun`.

- subdir:

  `[character]`  
  If given, the criterion will also be tested in the subdirectories
  defined by this argument, in the order given. The first existing
  directory will be used as a starting point. This is used for the
  [is_testthat](https://rprojroot.r-lib.org/dev/reference/criteria.md)
  criterion that needs to *descend* into `tests/testthat` if starting at
  the package root, but stay inside `tests/testthat` if called from a
  testthat test.

- x:

  `[object]`  
  An object.

- y:

  `[object]`  
  An object.

- filepath:

  `[character(1)]`  
  File path (can contain directories).

- contents, fixed:

  `[character(1)]`  
  If `contents` is `NULL` (the default), file contents are not checked.
  Otherwise, `contents` is a regular expression (if `fixed` is `FALSE`)
  or a search string (if `fixed` is `TRUE`), and file contents are
  checked matching lines.

- n:

  `[integerish(1)]`  
  Maximum number of lines to read to check file contents.

- pattern:

  `[character(1)]`  
  Regular expression to match the file name against.

- basename:

  `[character(1)]`  
  The required name of the root directory.

## Value

An S3 object of class `root_criterion` with the following members:

- `testfun`:

  The `testfun` argument

- `desc`:

  The `desc` argument

- `subdir`:

  The `subdir` argument

- `find_file`:

  A function with `...` and `path` arguments that returns a path
  relative to the root, as specified by this criterion. The optional
  `path` argument specifies the starting directory, which defaults to
  `"."`. The function forwards to
  [`find_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md),
  which passes `...` directly to
  [`file.path()`](https://rdrr.io/r/base/file.path.html) if the first
  argument is an absolute path.

- `make_fix_file`:

  A function with a `path` argument that returns a function that finds
  paths relative to the root. For a criterion `cr`, the result of
  `cr$make_fix_file(".")(...)` is identical to `cr$find_file(...)`. The
  function created by `make_fix_file()` can be saved to a variable to be
  more independent of the current working directory.

## Details

Construct criteria using `root_criterion` in a very general fashion by
specifying a function with a `path` argument, and a description.

The `as_root_criterion()` function accepts objects of class
`root_criterion`, and character values; the latter will be converted to
criteria using `has_file`.

Root criteria can be combined with the `|` operator. The result is a
composite root criterion that requires either of the original criteria
to match.

The `has_file()` function constructs a criterion that checks for the
existence of a specific file (which itself can be in a subdirectory of
the root) with specific contents.

The `has_dir()` function constructs a criterion that checks for the
existence of a specific directory.

The `has_file_pattern()` function constructs a criterion that checks for
the existence of a file that matches a pattern, with specific contents.

The `has_basename()` function constructs a criterion that checks if the
[`base::basename()`](https://rdrr.io/r/base/basename.html) of the root
directory has a specific name, with support for case-insensitive file
systems.

## Examples

``` r
root_criterion(function(path) file.exists(file.path(path, "somefile")), "has somefile")
#> Root criterion: has somefile
has_file("DESCRIPTION")
#> Root criterion: contains a file 'DESCRIPTION'
is_r_package
#> Root criterion: contains a file 'DESCRIPTION' with contents matching '^Package: '
if (FALSE) { # \dontrun{
is_r_package$find_file
is_r_package$make_fix_file(".")
} # }
```
