# rprojroot: Finding Files in Project Subdirectories

Robust, reliable and flexible paths to files below a project root. The
'root' of a project is defined as a directory that matches a certain
criterion, e.g., it contains a certain regular file.

## Details

See the "Value" section in
[`root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
for documentation of root criterion objects, and
[criteria](https://rprojroot.r-lib.org/dev/reference/criteria.md) for
useful predefined root criteria.

## See also

Useful links:

- <https://rprojroot.r-lib.org/>

- <https://github.com/r-lib/rprojroot>

- Report bugs at <https://github.com/r-lib/rprojroot/issues>

## Author

**Maintainer**: Kirill Müller <kirill@cynkra.com>
([ORCID](https://orcid.org/0000-0002-1416-3412))

## Examples

``` r
criteria
#> $is_rstudio_project
#> Root criterion: contains a file matching '[.]Rproj$' with contents matching '^Version: ' in the first line
#> 
#> $is_vscode_project
#> Root criterion: contains a file '.vscode/settings.json'
#> 
#> $is_r_package
#> Root criterion: contains a file 'DESCRIPTION' with contents matching '^Package: '
#> 
#> $is_remake_project
#> Root criterion: contains a file 'remake.yml'
#> 
#> $is_pkgdown_project
#> Root criterion: one of
#> - contains a file '_pkgdown.yml'
#> - contains a file '_pkgdown.yaml'
#> - contains a file 'pkgdown/_pkgdown.yml'
#> - contains a file 'pkgdown/_pkgdown.yaml'
#> - contains a file 'inst/_pkgdown.yml'
#> - contains a file 'inst/_pkgdown.yaml'
#> 
#> $is_renv_project
#> Root criterion: contains a file 'renv.lock' with contents matching '"Packages":\s*\{'
#> 
#> $is_projectile_project
#> Root criterion: contains a file '.projectile'
#> 
#> $is_quarto_project
#> Root criterion: contains a file '_quarto.yml'
#> 
#> $is_git_root
#> Root criterion: one of
#> - contains a directory '.git'
#> - contains a file '.git' with contents matching '^gitdir: '
#> 
#> $is_svn_root
#> Root criterion: contains a directory '.svn'
#> 
#> $is_vcs_root
#> Root criterion: one of
#> - contains a directory '.git'
#> - contains a file '.git' with contents matching '^gitdir: '
#> - contains a directory '.svn'
#> 
#> $is_testthat
#> Root criterion: directory name is "testthat" (also look in subdirectories: `tests/testthat`, `testthat`)
#> 
#> $from_wd
#> Root criterion: from current working directory
#> 
#> attr(,"class")
#> [1] "root_criteria"
if (FALSE) { # \dontrun{
is_r_package$find_file("NAMESPACE")
root_fun <- is_r_package$make_fix_file()
root_fun("NAMESPACE")
} # }
```
