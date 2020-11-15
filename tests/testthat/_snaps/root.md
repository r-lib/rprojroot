# Formatting

    Code
      format(is_r_package)
    Output
      [1] "Root criterion: contains a file \"DESCRIPTION\" with contents matching \"^Package: \""

---

    Code
      is_r_package
    Output
      Root criterion: contains a file "DESCRIPTION" with contents matching "^Package: "

---

    Code
      is_vcs_root
    Output
      Root criterion: one of
      - contains a directory ".git"
      - contains a file ".git" with contents matching "^gitdir: "
      - contains a directory ".svn"

---

    Code
      has_file("a", contents = "foo", fixed = TRUE)
    Output
      Root criterion: contains a file "a" with contents "foo"

---

    Code
      has_file_pattern("a.*b", contents = "foo", fixed = TRUE)
    Output
      Root criterion: contains a file matching "a.*b" with contents "foo"

---

    Code
      criteria
    Output
      $is_rstudio_project
      Root criterion: contains a file matching "[.]Rproj$" with contents matching "^Version: " in the first line
      
      $is_r_package
      Root criterion: contains a file "DESCRIPTION" with contents matching "^Package: "
      
      $is_remake_project
      Root criterion: contains a file "remake.yml"
      
      $is_projectile_project
      Root criterion: contains a file ".projectile"
      
      $is_git_root
      Root criterion: one of
      - contains a directory ".git"
      - contains a file ".git" with contents matching "^gitdir: "
      
      $is_svn_root
      Root criterion: contains a directory ".svn"
      
      $is_vcs_root
      Root criterion: one of
      - contains a directory ".git"
      - contains a file ".git" with contents matching "^gitdir: "
      - contains a directory ".svn"
      
      $is_testthat
      Root criterion: directory name is "testthat" (also look in subdirectories: `tests/testthat`, `testthat`)
      
      $from_wd
      Root criterion: from current working directory
      
      attr(,"class")
      [1] "root_criteria"

---

    Code
      str(criteria)
    Output
      List of 9
       $ is_rstudio_project   : chr "Root criterion: contains a file matching \"[.]Rproj$\" with contents matching \"^Version: \" in the first line"
       $ is_r_package         : chr "Root criterion: contains a file \"DESCRIPTION\" with contents matching \"^Package: \""
       $ is_remake_project    : chr "Root criterion: contains a file \"remake.yml\""
       $ is_projectile_project: chr "Root criterion: contains a file \".projectile\""
       $ is_git_root          : chr [1:3] "Root criterion: one of" "- contains a directory \".git\"" "- contains a file \".git\" with contents matching \"^gitdir: \""
       $ is_svn_root          : chr "Root criterion: contains a directory \".svn\""
       $ is_vcs_root          : chr [1:4] "Root criterion: one of" "- contains a directory \".git\"" "- contains a file \".git\" with contents matching \"^gitdir: \"" "- contains a directory \".svn\""
       $ is_testthat          : chr "Root criterion: directory name is \"testthat\" (also look in subdirectories: `tests/testthat`, `testthat`)"
       $ from_wd              : chr "Root criterion: from current working directory"

# Combining criteria

    Code
      comb_crit
    Output
      Root criterion: one of
      - contains a file "DESCRIPTION" with contents matching "^Package: "
      - contains a file matching "[.]Rproj$" with contents matching "^Version: " in the first line

