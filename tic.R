if (ci()$get_branch() != "revdep") {
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
} else {
  get_stage("script") %>%
    add_code_step(
      {
        requireNamespace("remotes")
        requireNamespace("rcmdcheck")

        check_pkg <- Sys.getenv("REVDEP_PKG")
        check_path <- download.packages(check_pkg, tempdir())[, 2]

        check_lib <- tempfile()
        dir.create(check_lib)
        withr::with_libpaths(check_lib, {
          print("Installing deps")
          remotes::install_deps(check_path, dependencies = TRUE)
        })

        pkg <- desc::desc()$get("Package")

        old_path <- download.packages(pkg, tempdir())[, 2]
        old_check <- withr::with_libpaths(check_lib, {
          rcmdcheck::rcmdcheck(check_path)
        })

        new_lib <- tempfile()
        dir.create(new_lib)
        new_check <- withr::with_libpaths(c(new_lib, check_lib), {
          remotes::install_local(".")
          rcmdcheck::rcmdcheck(check_path)
        })

        if (!inherits(old_check, "rcmdcheck") || !inherits(new_check, "rcmdcheck")) {
          stop("Installation error")
        } else {
          cmp <- rcmdcheck::compare_checks(old_check, new_check)
          print(cmp)
          if (cmp$status != "+") stop("New errors found")
        }
      },
      {
        remotes::install_github("r-lib/rcmdcheck")
      }
    )
}
