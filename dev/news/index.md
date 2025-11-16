# Changelog

## rprojroot 2.1.1.9003 (2025-11-12)

### Continuous integration

- Fix reviewdog and add commenting workflow
  ([\#177](https://github.com/r-lib/rprojroot/issues/177)).

## rprojroot 2.1.1.9002 (2025-11-10)

### Continuous integration

- Use workflows for fledge
  ([\#175](https://github.com/r-lib/rprojroot/issues/175)).

## rprojroot 2.1.1.9001 (2025-11-08)

### Continuous integration

- Sync ([\#173](https://github.com/r-lib/rprojroot/issues/173)).

## rprojroot 2.1.1.9000 (2025-09-21)

### Chore

- Auto-update from GitHub Actions
  ([\#170](https://github.com/r-lib/rprojroot/issues/170)).

## rprojroot 2.1.1 (2025-08-26)

CRAN release: 2025-08-26

### Features

- `is_vscode_project` looks for `.vscode/settings.json` instead of just
  `.vscode/` ([\#162](https://github.com/r-lib/rprojroot/issues/162),
  [\#163](https://github.com/r-lib/rprojroot/issues/163)).

### Documentation

- Use single quotes to avoid nested double quotes
  ([\#161](https://github.com/r-lib/rprojroot/issues/161)).

## rprojroot 2.1.0 (2025-07-12)

CRAN release: 2025-07-12

### Bug fixes

- Fix example for
  [`find_root()`](https://rprojroot.r-lib.org/dev/reference/find_root.md)
  ([@salim-b](https://github.com/salim-b),
  [\#98](https://github.com/r-lib/rprojroot/issues/98)).

### Features

- Add `is_vscode_project` criterion, true if a `.vscode/` directory
  exists ([\#155](https://github.com/r-lib/rprojroot/issues/155),
  [\#157](https://github.com/r-lib/rprojroot/issues/157),
  [@jennybc](https://github.com/jennybc)).

- New `is_targets_project`
  ([@mitchelloharawild](https://github.com/mitchelloharawild),
  [\#108](https://github.com/r-lib/rprojroot/issues/108),
  [\#146](https://github.com/r-lib/rprojroot/issues/146)).

- Avoid warnings about invalid inputs with non-native encoding
  ([@bastistician](https://github.com/bastistician),
  [\#80](https://github.com/r-lib/rprojroot/issues/80)).

- Align `is_pkgdown_project` with pkgdown \> 2.0.9.
  ([\#104](https://github.com/r-lib/rprojroot/issues/104),
  [\#106](https://github.com/r-lib/rprojroot/issues/106)).

- Avoid warnings on Windows network drives
  ([\#105](https://github.com/r-lib/rprojroot/issues/105)).

### Chore

- Rename `is_root()` to `is_fs_root()` to avoid confusion
  ([\#101](https://github.com/r-lib/rprojroot/issues/101)).

### Documentation

- Switch to `index.md`
  ([\#113](https://github.com/r-lib/rprojroot/issues/113)).

- Clarify `subdir` argument
  ([\#103](https://github.com/r-lib/rprojroot/issues/103)).

- Fix typo ([@salim-b](https://github.com/salim-b),
  [\#99](https://github.com/r-lib/rprojroot/issues/99)).

### Testing

- Replace mockr with
  [`testthat::local_mocked_bindings()`](https://testthat.r-lib.org/reference/local_mocked_bindings.html)
  ([@salim-b](https://github.com/salim-b),
  [\#97](https://github.com/r-lib/rprojroot/issues/97)).

## rprojroot 2.0.4 (2023-11-05)

CRAN release: 2023-11-05

### Features

- Add `is_renv_project` criterion looking for an `renv.lock` file
  ([@gadenbuie](https://github.com/gadenbuie),
  [\#86](https://github.com/r-lib/rprojroot/issues/86)).
- Add `is_quarto_project` criterion looking for a Quarto project
  ([@olivroy](https://github.com/olivroy),
  [\#91](https://github.com/r-lib/rprojroot/issues/91),
  [\#92](https://github.com/r-lib/rprojroot/issues/92)).

### Chore

- Update maintainer e-mail address.

### Testing

- Wrap `::` to skip if not installed in tests
  ([\#94](https://github.com/r-lib/rprojroot/issues/94)).

## rprojroot 2.0.3 (2022-03-25)

CRAN release: 2022-04-02

- Add `is_pkgdown_project` root criterion looking for a `_pkgdown.yml`,
  `_pkgdown.yaml`, `pkgdown/_pkgdown.yml` and/or `inst/_pkgdown.yml`
  file ([\#79](https://github.com/r-lib/rprojroot/issues/79),
  [@salim-b](https://github.com/salim-b)).
- Avoid `LazyData` in `DESCRIPTION`.

## rprojroot 2.0.2 (2020-11-15)

CRAN release: 2020-11-15

### Features

- In
  [`find_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md),
  if the first path component is already an absolute path, the path is
  returned unchanged without referring to the root. This allows using
  both root-relative and absolute paths in
  [`here::here()`](https://here.r-lib.org/reference/here.html). Mixing
  root-relative and absolute paths in the same call returns an error
  ([\#59](https://github.com/r-lib/rprojroot/issues/59)).
- [`find_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md)
  propagates `NA` values in path components. Using tidyverse recycling
  rules for path components of length different from one
  ([\#66](https://github.com/r-lib/rprojroot/issues/66)).
- [`has_file()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  and
  [`has_file_pattern()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  gain `fixed` argument
  ([\#75](https://github.com/r-lib/rprojroot/issues/75)).
- New `is_drake_project` criterion
  ([\#34](https://github.com/r-lib/rprojroot/issues/34)).
- Add `subdir` argument to `make_fix_file()`
  ([\#33](https://github.com/r-lib/rprojroot/issues/33),
  [@BarkleyBG](https://github.com/BarkleyBG)).
- Update documentation for version control criteria
  ([\#35](https://github.com/r-lib/rprojroot/issues/35),
  [@uribo](https://github.com/uribo)).

### Breaking changes

- [`has_file()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  and
  [`has_dir()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  now throw an error if the `filepath` argument is an absolute path
  ([\#74](https://github.com/r-lib/rprojroot/issues/74)).
- [`has_basename()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  replaces `has_dirname()` to avoid confusion
  ([\#63](https://github.com/r-lib/rprojroot/issues/63)).
- [`as_root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  and
  [`is_root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  replace `as.` and `is.`, respectively. The latter are soft-deprecated.
- [`thisfile()`](https://rprojroot.r-lib.org/dev/reference/thisfile.md)
  and related functions are soft-deprecated, now available in the
  whereami package
  ([\#43](https://github.com/r-lib/rprojroot/issues/43)).

### Bug fixes

- The `is_dirname()` criterion no longer considers sibling directories
  ([\#44](https://github.com/r-lib/rprojroot/issues/44)).

### Internal

- Use testthat 3e
  ([\#70](https://github.com/r-lib/rprojroot/issues/70)).
- The backports package is no longer imported
  ([\#68](https://github.com/r-lib/rprojroot/issues/68)).
- Re-license as MIT
  ([\#50](https://github.com/r-lib/rprojroot/issues/50)).
- Move checks to GitHub Actions
  ([\#52](https://github.com/r-lib/rprojroot/issues/52)).
- Availability of suggested packages knitr and rmarkdown, and pandoc, is
  now checked before running the corresponding tests.

## rprojroot 1.3-2 (2017-12-22)

CRAN release: 2018-01-03

- Availability of suggested packages knitr and rmarkdown, and pandoc, is
  now checked before running the corresponding tests.

## rprojroot 1.3-1 (2017-12-18)

CRAN release: 2017-12-18

- Adapt to testthat 2.0.0.
- New
  [`thisfile()`](https://rprojroot.r-lib.org/dev/reference/thisfile.md),
  moved from kimisc
  ([\#8](https://github.com/r-lib/rprojroot/issues/8)).
- Add more examples to vignette
  ([\#26](https://github.com/r-lib/rprojroot/issues/26),
  [@BarkleyBG](https://github.com/BarkleyBG)).
- Detect `.git` directories created with
  `git clone --separate-git-dir=...`
  ([\#24](https://github.com/r-lib/rprojroot/issues/24),
  [@karldw](https://github.com/karldw)).

## rprojroot 1.2 (2017-01-15)

CRAN release: 2017-01-16

- New root criteria
  - `is_projectile_project` recognize projectile projects
    ([\#21](https://github.com/r-lib/rprojroot/issues/21)).
  - [`has_dir()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
    constructs root criteria that check for existence of a directory.
  - `is_git_root`, `is_svn_root` and `is_vcs_root` look for a version
    control system root
    ([\#19](https://github.com/r-lib/rprojroot/issues/19)).
- New function
  - [`get_root_desc()`](https://rprojroot.r-lib.org/dev/reference/find_root.md)
    returns the description of the criterion that applies to a given
    root, useful for composite criteria created with `|`.
- Minor enhancements
  - Improve formatting of alternative criteria
    ([\#18](https://github.com/r-lib/rprojroot/issues/18)).
  - If root cannot be found, the start path is shown in the error
    message.
- Internal
  - The `$testfun` member of the `rprojroot` S3 class is now a list of
    functions instead of a function.

## rprojroot 1.1 (2016-10-29)

CRAN release: 2016-10-29

- Compatibility
  - Compatible with R \>= 3.0.0 with the help of the `backports`
    package.
- New root criteria
  - `is_remake_project` and
    [`find_remake_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md)
    look for [remake](https://github.com/richfitz/remake) project
    ([\#17](https://github.com/r-lib/rprojroot/issues/17)).
  - `is_testthat` and
    [`find_testthat_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md)
    that looks for `tests/testthat` root
    ([\#14](https://github.com/r-lib/rprojroot/issues/14)).
  - `from_wd`, useful for creating accessors to a known path
    ([\#11](https://github.com/r-lib/rprojroot/issues/11)).
- Minor enhancement
  - Criteria can be combined with the `|` operator
    ([\#15](https://github.com/r-lib/rprojroot/issues/15)).
- Documentation
  - Add package documentation with a few examples
    ([\#13](https://github.com/r-lib/rprojroot/issues/13)).
  - Clarify difference between `find_file()` and `make_fix_file()` in
    vignette ([\#9](https://github.com/r-lib/rprojroot/issues/9)).
  - Remove unexported functions from documentation and examples
    ([\#10](https://github.com/r-lib/rprojroot/issues/10)).
  - Use `pkgdown` to create website.
- Testing
  - Use Travis instead of wercker. Travis tests three R versions, and OS
    X.
  - Improve AppVeyor testing.

## rprojroot 1.0-2 (2016-03-28)

CRAN release: 2016-03-28

- Fix test that fails on Windows only on CRAN.

## rprojroot 1.0 (2016-03-26)

CRAN release: 2016-03-26

Initial CRAN release.

- S3 class `root_criterion`:
  - Member functions: `find_file()` and `make_fix_file()`
  - [`root_criterion()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  - [`as.root_criterion()`](https://rprojroot.r-lib.org/dev/reference/deprecated.md)
  - [`is.root_criterion()`](https://rprojroot.r-lib.org/dev/reference/deprecated.md)
  - [`has_file()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  - [`has_file_pattern()`](https://rprojroot.r-lib.org/dev/reference/root_criterion.md)
  - Built-in criteria:
    - `is_r_package`
    - `is_rstudio_project`
- Getting started:
  - [`find_package_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md)
  - [`find_rstudio_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md)
- Use a custom notion of a project root:
  - [`find_root()`](https://rprojroot.r-lib.org/dev/reference/find_root.md)
  - [`find_root_file()`](https://rprojroot.r-lib.org/dev/reference/find_root_file.md)
- Vignette
