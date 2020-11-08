<!-- README.md is generated from README.Rmd. Please edit that file -->

# [rprojroot](https://r-lib.github.io/rprojroot)

<!-- badges: start -->

[![rcc](https://github.com/r-lib/rprojroot/workflows/rcc/badge.svg)](https://github.com/r-lib/rprojroot/actions) [![codecov.io](https://codecov.io/github/r-lib/rprojroot/coverage.svg?branch=master)](https://codecov.io/github/r-lib/rprojroot?branch=master) [![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/rprojroot)](https://cran.r-project.org/package=rprojroot)

<!-- badges: end -->

This package helps accessing files relative to a *project root* to [stop the working directory insanity](https://gist.github.com/jennybc/362f52446fe1ebc4c49f).

## Example

The source for this text is in the [`readme` subdirectory](https://github.com/r-lib/rprojroot/tree/master/readme):

<pre class='chroma'>
<span class='nf'><a href='https://rdrr.io/r/base/basename.html'>basename</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/getwd.html'>getwd</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "rprojroot"</span></pre>

How do we access the package root? In a robust fashion? Easily:

<pre class='chroma'>
<span class='nf'><a href='https://rdrr.io/r/base/list.files.html'>dir</a></span><span class='o'>(</span><span class='nf'>rprojroot</span><span class='nf'>::</span><span class='nf'><a href='https://r-lib.github.io/rprojroot/reference/find_root.html'>find_root</a></span><span class='o'>(</span><span class='s'>"DESCRIPTION"</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt;  [1] "_pkgdown.yml"     "cran-comments.md" "DESCRIPTION"      "docs"            </span>
<span class='c'>#&gt;  [5] "inst"             "LICENSE"          "LICENSE.md"       "man"             </span>
<span class='c'>#&gt;  [9] "NAMESPACE"        "NEWS.md"          "R"                "readme"          </span>
<span class='c'>#&gt; [13] "README.md"        "README.Rmd"       "revdep"           "rprojroot.Rcheck"</span>
<span class='c'>#&gt; [17] "rprojroot.Rproj"  "tests"            "tic.R"            "vignettes"</span></pre>

## Installation and further reading

Install from GitHub:

<pre class='chroma'>
<span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://devtools.r-lib.org//reference/remote-reexports.html'>install_github</a></span><span class='o'>(</span><span class='s'>"r-lib/rprojroot"</span><span class='o'>)</span></pre>

See the [documentation](https://r-lib.github.io/rprojroot/articles/rprojroot.html) for more detail.
