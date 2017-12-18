add_package_checks()

if (inherits(ci(), "TravisCI") && Sys.getenv("BUILD_PKGDOWN") != "" && Sys.getenv("id_rsa") != "") {
  # pkgdown documentation can be built optionally. Other example criteria:
  # - `inherits(ci(), "TravisCI")`: Only for Travis CI
  # - `ci()$is_tag()`: Only for tags, not for branches
  # - `Sys.getenv("BUILD_PKGDOWN") != ""`: If the env var "BUILD_PKGDOWN" is set
  # - `Sys.getenv("TRAVIS_EVENT_TYPE") == "cron"`: Only for Travis cron jobs
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  get_stage("deploy") %>%
    add_step(step_build_pkgdown(examples = FALSE)) %>%
    add_step(step_push_deploy(
      path = "docs",
      branch = if (ci()$get_branch() == "master") "gh-pages" else paste0("gh-pages-", ci()$get_branch())
    ))
}
