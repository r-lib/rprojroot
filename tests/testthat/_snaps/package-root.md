# r_package_subdirs()

    Code
      r_package_subdirs()
    Output
      [1] "pkg-r" "r"     "R"    

---

    Code
      package_root_desc(r_package_subdirs())
    Output
      Root criterion: one of
      - contains a file 'DESCRIPTION' with contents matching '^Package: '
      - contains an RStudio project file with a 'PackagePath:' field pointing to a package
      - contains a file 'pkg-r/DESCRIPTION' with contents matching '^Package: '
      - contains a file 'r/DESCRIPTION' with contents matching '^Package: '
      - contains a file 'R/DESCRIPTION' with contents matching '^Package: '

