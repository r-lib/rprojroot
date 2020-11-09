# Steps for adopting older packages to new development standards

## `docs` branch

- [x] Create from last released tag
- [x] Copy `.github/workflows/pkgdown.yaml` there
- [x] Fix URL in DESCRIPTION, don't forget trailing slash
- [x] Tweak `_pkgdown.yml`
- [x] Set source of GitHub Pages to branch

## Separate pull requests

- [x] Use GitHub Actions
- [x] Disable tic
- [x] Disable Travis CI and AppVeyor
- [x] Tweak README

    - use `downlit::readme_document` and `load_all()` if possible

- [x] Update roxygen2
- [x] Use `@examplesIf` where appropriate
- [x] `styler::style_pkg()`
- [x] Remove `Collate:`
- [ ] Add pkgdown reference index
- [ ] Adapt tests to testthat 3e
- [ ] Import rlang where appropriate
- [ ] Consider open pull requests
- [ ] Close open issues
- [ ] Deprecate functions that have moved somewhere else
- [ ] Synchronize with own downstream packages
- [ ] Release to CRAN

