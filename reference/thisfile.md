# Determines the path of the currently running script

**\[soft-deprecated\]**

R does not store nor export the path of the currently running script.
This is an attempt to circumvent this limitation by applying heuristics
(such as call stack and argument inspection) that work in many cases.
**CAVEAT**: Use this function only if your workflow does not permit
other solution: if a script needs to know its location, it should be set
outside the context of the script if possible.

## Usage

``` r
thisfile()

thisfile_source()

thisfile_r()

thisfile_rscript()

thisfile_knit()
```

## Value

The path of the currently running script, NULL if it cannot be
determined.

## Details

This functions currently work only if the script was `source`d,
processed with `knitr`, or run with `Rscript` or using the `--file`
parameter to the `R` executable. For code run with `Rscript`, the exact
value of the parameter passed to `Rscript` is returned.

## Life cycle

These functions are now available in the whereami package.

## References

<https://stackoverflow.com/q/1815606/946850>

## See also

[`base::source()`](https://rdrr.io/r/base/source.html),
[`utils::Rscript()`](https://rdrr.io/r/utils/Rscript.html),
[`base::getwd()`](https://rdrr.io/r/base/getwd.html)

## Author

Kirill Müller, Hadley Wickham, Michael R. Head

## Examples

``` r
if (FALSE) { # \dontrun{
thisfile()
} # }
```
