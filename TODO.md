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
- [ ] Tweak README

    - use `downlit::readme_document` and `load_all()` if possible

- [ ] Update roxygen2
- [ ] Use `@examplesIf` where appropriate
- [ ] Add pkgdown reference index
- [ ] Consider open pull requests
- [ ] Close open issues
- [ ] Deprecate functions that have moved somewhere else
- [ ] Synchronize with own downstream packages
- [ ] Release to CRAN
