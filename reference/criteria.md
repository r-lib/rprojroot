# Prespecified criteria

This is a collection of commonly used root criteria.

## Usage

``` r
criteria

is_rstudio_project

is_vscode_project

is_r_package

is_remake_project

is_drake_project

is_targets_project

is_pkgdown_project

is_renv_project

is_projectile_project

is_quarto_project

is_git_root

is_svn_root

is_vcs_root

is_testthat

from_wd
```

## Details

`is_rstudio_project` looks for a file with extension `.Rproj`.

`is_vscode_project` looks for a `.vscode/settings.json` file.

`is_r_package` looks for a `DESCRIPTION` file.

`is_remake_project` looks for a `remake.yml` file.

`is_drake_project` looks for a `.drake` directory.

`is_targets_project` looks for a `_targets.R` file.

`is_pkgdown_project` looks for a `_pkgdown.yml`, `_pkgdown.yaml`,
`pkgdown/_pkgdown.yml` and/or `inst/_pkgdown.yml` file.

`is_renv_project` looks for an `renv.lock` file.

`is_projectile_project` looks for a `.projectile` file.

`is_quarto_project` looks for a `_quarto.yml` file.

`is_git_root` looks for a `.git` directory.

`is_svn_root` looks for a `.svn` directory.

`is_vcs_root` looks for the root of a version control system, currently
only Git and SVN are supported.

`is_testthat` looks for the `testthat` directory, works when developing,
testing, and checking a package.

`from_wd` uses the current working directory.
